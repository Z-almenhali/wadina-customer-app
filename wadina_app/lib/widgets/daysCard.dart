import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/days.dart';
import 'daysCardItems.dart';

class DaysCard extends StatefulWidget {
  const DaysCard({Key? key}) : super(key: key);

  @override
  _DaysCardState createState() => _DaysCardState();
}

class _DaysCardState extends State<DaysCard> {
  Days day = Days();
  User? customer = FirebaseAuth.instance.currentUser;

  List<Days> days = [];
  @override
  void initState() {
    print("days cards");
    super.initState();
    FirebaseFirestore.instance
        .collection('schadule')
        .doc(customer!.uid)
        .collection("days")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        // print(element.data());
        day = Days.fromMap(element);
        days.add(day);
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: days.length,
            itemBuilder: (BuildContext context, int index) {
              return DaysCardItems(days[index]);
            }));
  }

}
