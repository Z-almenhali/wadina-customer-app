import 'package:flutter/material.dart';
import 'package:wadina_app/guestScreen/PaymentCard.dart';
import 'package:wadina_app/guestScreen/current_location.dart';
import '../model/company.dart';
import '../widgets/daysCard.dart';

class Schadule extends StatefulWidget {
   String neighbrhoods;
  String customerID;
  Company? company;
  Schadule(this.company, this.customerID,this.neighbrhoods);

  @override
  _SchaduleState createState() => _SchaduleState();
}

class _SchaduleState extends State<Schadule> {
  // @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(97, 120, 232, 1),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CurrentLocation(widget.company,widget.neighbrhoods,false)));
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Text(
                "Set Your Schedule",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Microsoft_PhagsPa',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 30),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PaymentCard(widget.customerID,widget.company,widget.neighbrhoods)));
                },
                child: Text(
                  "skip",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          width: MediaQuery.of(context).size.width - 60,
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 3),
            ],
          ),
          child: DaysCard(),
        ),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentCard(widget.customerID,widget.company,widget.neighbrhoods)));
          },
          child: const Text(
            'Confirm',
            style: TextStyle(letterSpacing: 2),
          ),
          style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(243, 214, 35, 1),
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
        )
      ]),
    );
  }
}
