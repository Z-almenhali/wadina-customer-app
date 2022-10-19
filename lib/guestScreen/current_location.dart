import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wadina_app/customerScreen/homePage.dart';
import 'package:wadina_app/guestScreen/PaymentCard.dart';
import 'package:wadina_app/guestScreen/schadule.dart';
import 'package:wadina_app/guestScreen/splash.dart';

import '../model/company.dart';
import '../model/customer.dart';

class CurrentLocation extends StatefulWidget {
  bool isREG = true;
  
  String neighbrhoods;
  Company? company;
  CurrentLocation(this.company, this.neighbrhoods, this.isREG);
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? customer = FirebaseAuth.instance.currentUser;

  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  Customer? customerModel;
  String text = "Current Location";
  late GoogleMapController googleMapController;
  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(21.543333, 39.172779), zoom: 14);

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: markers,
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
            )),
        Container(
          padding: EdgeInsets.only(top: 50),
          width: MediaQuery.of(context).size.width,
          height: 150,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(50),
                bottomRight: const Radius.circular(50)),
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 3),
            ],
          ),
          child: Row(children: [
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
               showDialog(
                barrierColor: Colors.black26,
                context: context,
                builder: (context) {
                  return ReminderAlertDialog(
                    title: "Logout",
                    description: "are you sure you want to logout?",
                    icon: Icons.logout,
                    page: Splash(),
                  );
                },
              );
              },
              child: Icon(
                Icons.arrow_back,
                size: 40,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Text("Select Your Location",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Microsoft_PhagsPa',
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                )),
          ]),
        ),

        //----------------------------------------

        Positioned(
            child: Align(
          alignment: Alignment(-0.1, 0.9),
          child: ElevatedButton(
              onPressed: () async {
                Position position = await _determinePosition();

                googleMapController.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(position.latitude, position.longitude),
                        zoom: 14)));

                markers.clear();

                markers.add(Marker(
                    markerId: const MarkerId('currentLocation'),
                    position: LatLng(position.latitude, position.longitude)));
                if (text == "Confirm Pickup") {
                  if (widget.isREG == true) {
                    await FirebaseFirestore.instance
                        .collection("company")
                        .doc(widget.company?.Id)
                        .collection("customer")
                        .doc(widget.customer!.uid)
                        .update({
                      'latitude': position.latitude.toString(),
                      'longitude': position.longitude.toString()
                    });

                    await FirebaseFirestore.instance
                        .collection("company")
                        .doc(widget.company?.Id)
                        .collection("customer")
                        .doc(widget.customer!.uid)
                        .get()
                        .then((value) => customerModel =
                            Customer.fromMapForCompany(value.data()));

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(0,
                                widget.company, customerModel, FirebaseFirestore.instance,FirebaseAuth.instance)),
                        (route) => false);
                  } else {
                    Update(position.longitude.toString(),
                        position.latitude.toString());
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Schadule(widget.company,
                                widget.customer!.uid, widget.neighbrhoods)),
                        (route) => false);
                  }
                }
                setState(() {
                  text = "Confirm Pickup";
                });
              },
              child: Text(
                text,
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(243, 214, 35, 1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)))),
        )),
      ]),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  Update(String long, String lat) async {
    await widget.firebaseFirestore
        .collection("customer")
        .doc(widget.customer!.uid)
        .update({'latitude': lat, 'longitude': long});
  }
}
