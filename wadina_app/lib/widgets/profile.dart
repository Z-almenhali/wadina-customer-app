import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wadina_app/guestScreen/current_location.dart';
import 'package:wadina_app/model/company.dart';

import '../customerScreen/homePage.dart';
import '../model/customer.dart';

class Profile extends StatefulWidget {
  Company? company;
  Customer? customer;
  Profile(this.company, this.customer);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Customer customerModel = Customer();
  User? customer = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final _formkey = GlobalKey<FormState>();
  late Icon profileIcon = Icon(Icons.edit);
  TextEditingController _fullNameField = TextEditingController();
  TextEditingController _phoneNumberField = TextEditingController();
  TextEditingController _emailField = TextEditingController();
  TextEditingController _schoolNameField = TextEditingController();
  String Error = "";
  bool isLoading = false;
  bool isable = false;
  String dropdownvalue = "KAU";
  var neighbrhoods = [
    'KAU',
    '211 primary school',
    '24 primary school',
    '118 high school',
  ];

  @override
  void initState() {
    print("company inside profile ");
    print(widget.company?.Id);
    print(customer?.uid);
    super.initState();
    isLoading = true;
    FirebaseFirestore.instance.collection('company').get().then((value) {
      value.docs.forEach((elements) {
        FirebaseFirestore.instance
            .collection("company")
            .doc(elements.id)
            .collection("customer")
            .where("customerid", isEqualTo: customer?.uid)
            .get()
            .then((value) => value.docs.forEach((element) {
                  setState(() {
                    isLoading = false;
                    print(element.data());
                    this.customerModel =
                        Customer.fromMapForCompany(element.data());
                        widget.customer=Customer.fromMapForCompany(element.data());
                  });
                }));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SizedBox(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (isable == false) {
                              isable = true;
                              profileIcon = Icon(
                                Icons.done_sharp,
                                color: Color.fromRGBO(97, 120, 232, 1),
                                size: 30,
                              );
                            } else {
                              pushToFireStore();
                              isable = false;
                              profileIcon = Icon(
                                Icons.edit,
                                size: 30,
                              );
                            
                            }
                          });
                        },
                        child: Positioned(
                            child: Align(
                                alignment: Alignment(0.9, 0.9),
                                child: profileIcon)),
                      ),
                    ),
                    (!isable)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Your Name",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Microsoft_PhagsPa',
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Color.fromRGBO(97, 120, 232, 1))),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: TextField(
                                  enabled: isable,
                                  controller: TextEditingController()
                                    ..text = _fullNameField.text.isEmpty
                                        ? "    ${this.customerModel.name}"
                                        : _fullNameField.text,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 1),
                                    fillColor: Color.fromRGBO(97, 120, 232, 1)
                                        .withOpacity(0.1),
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(245, 245, 245, 245),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Phone Number",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Microsoft_PhagsPa',
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Color.fromRGBO(97, 120, 232, 1))),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: TextField(
                                  enabled: isable,
                                  controller: TextEditingController()
                                    ..text = _phoneNumberField.text.isEmpty
                                        ? "    ${this.customerModel.phoneNumber}"
                                        : _phoneNumberField.text,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 1),
                                    fillColor: Color.fromRGBO(97, 120, 232, 1)
                                        .withOpacity(0.1),
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(245, 245, 245, 245),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text("Email",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Microsoft_PhagsPa',
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Color.fromRGBO(97, 120, 232, 1))),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: TextFormField(
                                  enabled: isable,
                                  controller: TextEditingController()
                                    ..text = _emailField.text.isEmpty
                                        ? "    ${this.customerModel.email}"
                                        : _emailField.text,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 1),
                                    fillColor: Color.fromRGBO(97, 120, 232, 1)
                                        .withOpacity(0.1),
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(245, 245, 245, 245),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("School Name",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Microsoft_PhagsPa',
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.8,
                                      color: Color.fromRGBO(97, 120, 232, 1))),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: TextField(
                                  enabled: false,
                                  controller: TextEditingController()
                                    ..text = _schoolNameField.text.isEmpty
                                        ? "    ${this.customerModel.schoolName}"
                                        : _schoolNameField.text,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 1),
                                    fillColor: Color.fromRGBO(97, 120, 232, 1)
                                        .withOpacity(0.1),
                                    filled: true,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(245, 245, 245, 245),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          )
                        // _____________________________________________________________________
                        : Form(
                            key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(""),
                                Text("Your Name",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Microsoft_PhagsPa',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                        color:
                                            Color.fromRGBO(97, 120, 232, 1))),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: TextFormField(

                                    enabled: isable,
                                    controller: _fullNameField,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 1),
                                      fillColor: Color.fromRGBO(97, 120, 232, 1)
                                          .withOpacity(0.1),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              245, 245, 245, 245),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Phone Number",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Microsoft_PhagsPa',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                        color:
                                            Color.fromRGBO(97, 120, 232, 1))),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: TextFormField(
                                    enabled: isable,
                                    controller: _phoneNumberField,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 1),
                                      fillColor: Color.fromRGBO(97, 120, 232, 1)
                                          .withOpacity(0.1),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              245, 245, 245, 245),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("Email",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Microsoft_PhagsPa',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                        color:
                                            Color.fromRGBO(97, 120, 232, 1))),
                                SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: TextField(
                                    enabled: isable,
                                    controller: _emailField,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 1),
                                      fillColor: Color.fromRGBO(97, 120, 232, 1)
                                          .withOpacity(0.1),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              245, 245, 245, 245),
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("School Name",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Microsoft_PhagsPa',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                        color:
                                            Color.fromRGBO(97, 120, 232, 1))),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(245, 245, 245,
                                              245), //background color of dropdown button //border of dropdown button
                                          borderRadius: BorderRadius.circular(
                                              40), //border raiuds of dropdown button
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: DropdownButton(
                                            dropdownColor: Color.fromARGB(
                                                245, 245, 245, 245),
                                            // Initial Value
                                            value: dropdownvalue,
                                            hint: Text(
                                                "Please select your nigebrhood"),

                                            // Down Arrow Icon
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color.fromRGBO(
                                                  97, 120, 232, 1),
                                            ),

                                            // Array list of items
                                            items: neighbrhoods
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.school,
                                                        color: Color.fromRGBO(
                                                            97, 120, 232, 1),
                                                        size: 30,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        items,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color: Color.fromARGB(
                                                              179, 7, 6, 6),
                                                        ),
                                                      ),
                                                    ],
                                                  ));
                                            }).toList(),
                                            // After selecting the desired option,it will
                                            // change button value to selected value
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownvalue = newValue!;
                                                _schoolNameField.text =
                                                    "   " + dropdownvalue;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                    // TextFormField(
                                    //   enabled: isable,
                                    //   controller: _schoolNameField,
                                    //   decoration: InputDecoration(
                                    //     contentPadding:
                                    //         EdgeInsets.symmetric(vertical: 1),
                                    //     fillColor: Color.fromRGBO(97, 120, 232, 1)
                                    //         .withOpacity(0.1),
                                    //     filled: true,
                                    //     enabledBorder: OutlineInputBorder(
                                    //       borderSide: BorderSide(
                                    //         color: Color.fromARGB(
                                    //             245, 245, 245, 245),
                                    //       ),
                                    //       borderRadius: BorderRadius.circular(20),
                                    //     ),
                                    //   ),
                                    // ),

                                    ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 60),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CurrentLocation(
                                                      widget.company,
                                                      this
                                                          .customerModel
                                                          .neighbrhoods!,
                                                      true)),
                                          (route) => false);
                                    },
                                    icon: Icon(
                                      // <-- Icon
                                      Icons.location_pin,
                                      size: 24.0,
                                    ),
                                    label: Text('Set Location'), // <-- Text
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              )
            ]),
          );
  }

  void pushToFireStore() async {
    if (!_schoolNameField.text.isEmpty &&
        customerModel.schoolName != _schoolNameField.text) {
      setState(() {
        customerModel.schoolName = this.dropdownvalue;
      });

      await FirebaseFirestore.instance
          .collection("company")
          .where("CompanyID", isEqualTo: widget.company?.Id)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection("company")
              .doc(element.id)
              .collection("customer")
              .doc(widget.customer?.customerid)
              .update({'schoolName': customerModel.schoolName});
        });
      });
    }

    if (!_fullNameField.text.isEmpty &&
        customerModel.name != _fullNameField.text) {
      setState(() {
        customerModel.name = _fullNameField.text;
      });

      await FirebaseFirestore.instance
          .collection("company")
          .where("CompanyID", isEqualTo: widget.company?.Id)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection("company")
              .doc(element.id)
              .collection("customer")
              .doc(widget.customer?.customerid)
              .update({'Name': customerModel.name});
        });
      });
    }

    RegExp regex = new RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");
    RegExp regexPhoneNumber =
        new RegExp(r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$');

    if (!regex.hasMatch(_emailField.text) && !_emailField.text.isEmpty) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Please Enter Valid Email ',
              style: TextStyle(
                  color: Color.fromARGB(255, 146, 7, 7),
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage(2, widget.company, widget.customer, FirebaseFirestore.instance,FirebaseAuth.instance)));
                },
              ),
            ],
          );
        },
      );
    } else {
      if (!_emailField.text.isEmpty &&
          customerModel.email != _emailField.text) {
        setState(() {
          customerModel.email = _emailField.text;
        });

        await FirebaseFirestore.instance
            .collection("company")
            .where("CompanyID", isEqualTo: widget.company?.Id)
            .get()
            .then((value) {
          value.docs.forEach((element) {
            FirebaseFirestore.instance
                .collection("company")
                .doc(element.id)
                .collection("customer")
                .doc(widget.customer?.customerid)
                .update({'email': customerModel.email});
          });
        });
      }
    }

    if (!_phoneNumberField.text.isEmpty &&
        !regexPhoneNumber.hasMatch(_phoneNumberField.text)) {
           showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Please Enter Valid Phone Number',
              style: TextStyle(
                  color: Color.fromARGB(255, 146, 7, 7),
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage(2, widget.company, widget.customer, FirebaseFirestore.instance,FirebaseAuth.instance)));
                },
              ),
            ],
          );
        },
      );
    }else{

    if (!_phoneNumberField.text.isEmpty &&
        customerModel.phoneNumber != _phoneNumberField.text) {
      setState(() {
        customerModel.phoneNumber = _phoneNumberField.text;
      });

      await FirebaseFirestore.instance
          .collection("company")
          .where("CompanyID", isEqualTo: widget.company?.Id)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection("company")
              .doc(element.id)
              .collection("customer")
              .doc(widget.customer?.customerid)
              .update({'phoneNumber': customerModel.phoneNumber});
        });
      });
    }
    }

  }
}
