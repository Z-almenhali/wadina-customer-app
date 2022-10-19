import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../model/days.dart';

class DaysCardItems extends StatefulWidget {
  Days day;

  DaysCardItems(this.day);

  @override
  _DaysCardItemsState createState() => _DaysCardItemsState();
}

class _DaysCardItemsState extends State<DaysCardItems> {
  @override
  Widget build(BuildContext context) {
    pushToFireStore();

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Container(
          child: Column(
            children: [
              (widget.day.active!)
                  ? ListTile(
                      title: Text(
                        widget.day.day!.substring(1),
                        style: TextStyle(fontSize: 20),
                      ),
                      leading: InkWell(
                        onTap: () {
                          setState(() {
                            widget.day.active = !widget.day.active!;
                          });
                        },
                        child: Icon(
                          Icons.check_circle_outlined,
                          color: Color.fromRGBO(114, 206, 243, 1),
                          size: 45,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          // pickup time picker
                          InkWell(
                            onTap: () {
                              showCustomTimePickerPickup();
                            },
                            child: Text("\n" + widget.day.pickup!+" - ",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          ),
                          // dropOff time picker
                          InkWell(
                            onTap: () {
                              showCustomTimePickerDropoff();
                            },
                            child: Text("\n" + widget.day.dropoff!,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black)),
                          )
                        ],
                      ),
                    )

                  //----------------------------------------------------------------------------

                  : ListTile(
                      title: Text(widget.day.day!.substring(1),
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 107, 103, 103))),
                      leading: InkWell(
                        onTap: () {
                          setState(() {
                            widget.day.active = !widget.day.active!;
                          });
                        },
                        child: Icon(
                          Icons.circle_outlined,
                          color: Color.fromARGB(255, 107, 103, 103),
                          size: 45,
                        ),
                      ),
                      subtitle:
                          Text("\n${widget.day.pickup} - ${widget.day.dropoff}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 107, 103, 103),
                              )),
                    ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
          decoration: BoxDecoration(
              border: Border(
            bottom:
                BorderSide(width: 1, color: Color.fromARGB(112, 112, 112, 112)),
          ))),
    );
  }

  showCustomTimePickerDropoff() {
    DatePicker.showTime12hPicker(context,
        showTitleActions: true, currentTime: DateTime.now(), onConfirm: (time) {
      print(time.hour);

      setState(() {
        if (time.hour < 12) {
          widget.day.dropoff = "${time.hour}:00 AM";
        }

        if (time.hour < 7) {
          widget.day.dropoff = "7:00 AM";
          _showMyDialog();
        }

        if (time.hour >= 17) {
          widget.day.dropoff = "17:00 PM";
          _showMyDialog();
        }

        if (time.hour > 12 && time.hour < 17) {
          widget.day.dropoff = "${time.hour}:00 PM";
        }
      });
    });
  }

  showCustomTimePickerPickup() {
    DatePicker.showTime12hPicker(context,
        showTitleActions: true, currentTime: DateTime.now(), onConfirm: (time) {
      print(time.hour);

      setState(() {
        if (time.hour < 12) {
          widget.day.pickup = "${time.hour}:00 AM";
        }

        if (time.hour < 7) {
          widget.day.pickup = "7:00 AM";
          _showMyDialog();
        }

        if (time.hour >= 17) {
          widget.day.pickup = "17:00 PM";
          _showMyDialog();
        }

        if (time.hour > 12 && time.hour < 17) {
          widget.day.pickup = "${time.hour}:00 PM";
        }
      });
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Your Time is out of range',
            style: TextStyle(
                color: Color.fromARGB(255, 146, 7, 7),
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void pushToFireStore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    User? customerUser = FirebaseAuth.instance.currentUser;

    await firebaseFirestore
        .collection("schadule")
        .doc(customerUser!.uid)
        .collection("days")
        .doc(widget.day.day!)
        .set(widget.day.toMap());

    if (!(widget.day.active!)) {
      // get customer company ref
      final customerCompanyRef = await FirebaseFirestore.instance
          .collection("customer-company")
          .doc(customerUser.uid)
          .get();

      // update drivers id
      await FirebaseFirestore.instance
          .collection('company')
          .doc(customerCompanyRef["companyID"].trim())
          .collection('customer')
          .doc(customerUser.uid)
          .update({"driverDropoff": null, "driverPickup": null});
    }
  }
}
