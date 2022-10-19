import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wadina_app/model/company.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../customerScreen/homePage.dart';
import '../model/customer.dart';
import '../model/driver.dart';
import 'package:url_launcher/url_launcher.dart';

class ReminderAlertDialogForN extends StatefulWidget {
  const ReminderAlertDialogForN(
      {Key? key,
      required this.title,
      required this.Text1,
      required this.Text2,
      required this.icon,
      required this.description,
      this.customer,
      this.company})
      : super(key: key);

  final String title, description, Text1, Text2;
  final icon;
  final Customer? customer;
  final Company? company;

  @override
  _ReminderAlertDialogForNState createState() =>
      _ReminderAlertDialogForNState();
}

class _ReminderAlertDialogForNState extends State<ReminderAlertDialogForN> {
   Driver driver = new Driver();
     String number="";
  @override
  Widget build(BuildContext context) {
   
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: 40,
              color: Color.fromRGBO(97, 120, 232, 1),
            ),
            SizedBox(height: 15),
            Text(
              "${widget.title}",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "${widget.description}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            Divider(
              height: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: InkWell(
                highlightColor: Colors.grey[200],
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage(0, widget.company, widget.customer, FirebaseFirestore.instance,FirebaseAuth.instance)));
                },
                child: Center(
                  child: Text(
                    widget.Text1,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: InkWell(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
                highlightColor: Colors.grey[200],
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection("driver")
                      .doc(widget.customer?.pickUpDriver)
                      .get()
                      .then((value) {
                    print(value.data());
                    setState(() {
                      driver = Driver.fromMap(value.data());
                      number = driver.phoneNumber!;
                    });
                  });
              
    
                          final Uri launchUri = Uri(
                      scheme: 'tel',
                                path: number,
                              );
                            await launch(launchUri.toString());
                                      
                },
                child: Center(
                  child: Text(
                    widget.Text2,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
