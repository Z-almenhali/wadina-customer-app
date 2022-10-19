import 'package:flutter/material.dart';
import 'package:wadina_app/guestScreen/PaymentCard.dart';
import 'package:wadina_app/guestScreen/splash.dart';
import 'package:wadina_app/widgets/companyInfo.dart';

// ignore: camel_case_types
class avalibleCompanies extends StatefulWidget {
  String neighbrhoods;
  String? customerID;
  avalibleCompanies(this.neighbrhoods,this.customerID);

  @override
  _avalibleCompaniesState createState() => _avalibleCompaniesState();
}

// ignore: camel_case_types
class _avalibleCompaniesState extends State<avalibleCompanies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(97, 120, 232, 1),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 70, left: 30),
          child: InkWell(
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
            child: Container(
              alignment: Alignment.topLeft,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 20),
          child: Container(
              alignment: Alignment.centerLeft,
              child: Text("Available Companies",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Microsoft_PhagsPa',
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                      color: Colors.white))),
        ),
        Container(
            margin: EdgeInsets.only(top: 40),
            width: MediaQuery.of(context).size.width,
            height: 585,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(40),
                  topRight: const Radius.circular(40)),
              boxShadow: [
                BoxShadow(color: Colors.white, spreadRadius: 3),
              ],
            ),
            child: CompanyInfo(widget.neighbrhoods,widget.customerID)),
      ]),
    );
  }
}
