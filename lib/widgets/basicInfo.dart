// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wadina_app/model/company.dart';
import 'package:wadina_app/model/customer.dart';

import '../model/driver.dart';

class basicInfo extends StatefulWidget {
  Company? company;
  Customer? customer;
  basicInfo(this.company, this.customer);
  @override
  _basicInfoState createState() => _basicInfoState();
}

class _basicInfoState extends State<basicInfo> {
  late Driver pickupDriver;
  late Driver dropoffDriver;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    if (widget.customer!.dropOfDriver == null ||
        widget.customer!.pickUpDriver == null) {
      isLoading = false;
      return;
    }

  

    isLoading = true;

    firebaseFirestore
        .collection("driver")
        .doc(widget.customer!.pickUpDriver)
        .get()
        .then((value) {
      setState(() {
        this.pickupDriver = Driver.fromMap(value.data());
        isLoading = false;
      });

    });

    firebaseFirestore
        .collection("driver")
        .doc(widget.customer?.dropOfDriver)
        .get()
        .then((value) {
      print(value.data());
      setState(() {
        isLoading = false;
        this.dropoffDriver = Driver.fromMap(value.data());
        print(" this.dropoffDriver.name." + this.dropoffDriver.name.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("company from dash");

    print(widget.company?.Id);

    print("customer from dash");

    print(widget.customer?.customerid);

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SizedBox(
          height: 500,
          child: ListView(padding: EdgeInsets.all(0), children: [
            Container(
              margin: EdgeInsets.only(right: 30, left: 30),
              padding: EdgeInsets.only(left: 40, top: 30, bottom: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(color: Colors.white, spreadRadius: 3),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(97, 120, 232, 1)
                                      .withOpacity(0.3),
                                  spreadRadius: 3),
                            ],
                          ),
                          child: Icon(
                            Icons.business,
                            size: 30,
                            color: Color.fromRGBO(97, 120, 232, 1),
                          ),
                        ),
                        SizedBox(
                          width: 45,
                        ),
                        Column(
                          children: [
                            Text(
                              "Company Name",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Microsoft_PhagsPa',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.8),
                            ),
                            Text(
                              widget.company!.name!,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Microsoft_PhagsPa',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(97, 120, 232, 1)
                                      .withOpacity(0.3),
                                  spreadRadius: 3),
                            ],
                          ),
                          child: Icon(
                            Icons.person_pin_circle,
                            size: 30,
                            color: Color.fromRGBO(97, 120, 232, 1),
                          ),
                        ),
                        SizedBox(
                          width: 45,
                        ),
                        // pickupDriver name and phone container
                        Column(
                          children: [
                            Text(
                              widget.customer!.pickUpDriver != null
                                  ? "${pickupDriver.name}"
                                  : "No Driver Assigned",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Microsoft_PhagsPa',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8),
                            ),
                            Text(
                              widget.customer!.pickUpDriver != null
                                  ? "${pickupDriver.phoneNumber}"
                                  : "-----",
                              style: TextStyle(
                                  color: Color.fromRGBO(97, 120, 232, 1),
                                  fontSize: 18,
                                  fontFamily: 'Microsoft_PhagsPa',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8),
                            ),
                            Text(
                              "Pickup Driver",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Microsoft_PhagsPa',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.8),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(97, 120, 232, 1)
                                      .withOpacity(0.3),
                                  spreadRadius: 3),
                            ],
                          ),
                          child: Icon(
                            Icons.location_pin,
                            size: 30,
                            color: Color.fromRGBO(97, 120, 232, 1),
                          ),
                        ),
                        SizedBox(
                          width: 45,
                        ),

                        // dropoffDriver name and phone container
                        Column(
                          children: [
                            Text(
                              widget.customer!.dropOfDriver != null
                                  ? "${dropoffDriver.name}"
                                  : "No Driver Assigned",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Microsoft_PhagsPa',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8),
                            ),
                            Text(
                              widget.customer!.dropOfDriver != null
                                  ? "${dropoffDriver.phoneNumber}"
                                  : "-----",
                              style: TextStyle(
                                  color: Color.fromRGBO(97, 120, 232, 1),
                                  fontSize: 18,
                                  fontFamily: 'Microsoft_PhagsPa',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8),
                            ),
                            Text(
                              "DropOff Driver",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Microsoft_PhagsPa',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.8),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(97, 120, 232, 1)
                                      .withOpacity(0.3),
                                  spreadRadius: 3),
                            ],
                          ),
                          child: Icon(
                            Icons.bus_alert,
                            size: 30,
                            color: Color.fromRGBO(97, 120, 232, 1),
                          ),
                        ),
                        SizedBox(
                          width: 45,
                        ),

                        // busses numbers
                        Column(
                          children: [
                            Text(
                              widget.customer!.pickUpDriver != null
                                  ? "PickUp Bus no:${pickupDriver.bussNumber}"
                                  : "No Bus Assigned",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Microsoft_PhagsPa',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8),
                            ),
                            Text(
                              widget.customer!.dropOfDriver != null
                                  ? "DropOff Bus no: ${dropoffDriver.bussNumber}"
                                  : "No Bus Assigned",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Microsoft_PhagsPa',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(97, 120, 232, 1)
                                      .withOpacity(0.3),
                                  spreadRadius: 3),
                            ],
                          ),
                          child: Icon(
                            Icons.location_city,
                            size: 30,
                            color: Color.fromRGBO(97, 120, 232, 1),
                          ),
                        ),
                        SizedBox(
                          width: 45,
                        ),

                        // school name
                        Column(
                          children: [
                            Text(
                              "School Name",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Microsoft_PhagsPa',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.8),
                            ),
                            Text(
                              widget.customer!.schoolName!,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Microsoft_PhagsPa',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]));
    }
  }
}
