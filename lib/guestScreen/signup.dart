import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wadina_app/model/customer.dart';

import '../model/days.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  String neighbrhoods;
  Signup(this.neighbrhoods);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _fullNameField = TextEditingController();
  TextEditingController _phoneNumberField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _emailField = TextEditingController();
  TextEditingController _schoolNameField = TextEditingController();
  String Error = "";

  String dropdownvalue = 'KAU';
  var neighbrhoods = [
    'KAU',
    '211 primary school',
    '24 primary school',
    '118 high school',
  ];
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(97, 120, 232, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Login(null, widget.neighbrhoods, null)),
                              );
                            },
                            child: Icon(Icons.arrow_back)),
                      ),
                    ),
                    Text(
                      "Welcome!",
                      style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Microsoft_PhagsPa',
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Create your account",
                      style: TextStyle(
                        fontSize: 19,
                        fontFamily: 'Microsoft_PhagsPa',
                      ),
                    ),
                    Image.asset(
                      'assets/logo.png',
                      height: 140,
                      width: 150,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Text(Error),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextFormField(
                          controller: _fullNameField,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{3,}$');

                            if (value!.isEmpty) {
                              return ("Name cannot be empty");
                            }

                            if (!regex.hasMatch(value)) {
                              return ("please Enter Valid Name for Min 3 charecter");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _fullNameField.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white70,
                            ),
                            labelText: ' Full Name',
                            labelStyle: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Microsoft_PhagsPa'),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.white70,
                                width: 3.0,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      // ---------------------------------------------------------------
                      // Password Text Field

                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextFormField(
                          controller: _phoneNumberField,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            RegExp regex = new RegExp(
                                r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$');

                            if (value!.isEmpty) {
                              return ("phone Number cannot be empty");
                            }

                            if (!regex.hasMatch(value)) {
                              return ("please Enter Valid Phone Number start with +966");
                            }
                          },
                          onSaved: (value) {
                            _emailField.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.white70,
                            ),
                            labelText: ' Phone Number',
                            labelStyle: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Microsoft_PhagsPa'),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.white70,
                                width: 3.0,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextFormField(
                          controller: _passwordField,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');

                            if (value!.isEmpty) {
                              return ("please Enter Your Password");
                            }

                            if (!regex.hasMatch(value)) {
                              return ("please Enter Valid Password for Min 6 charecter");
                            }
                          },
                          onSaved: (value) {
                            _emailField.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white70,
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Colors.white70,
                                fontFamily: 'Microsoft_PhagsPa'),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.white70,
                                width: 3.0,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: TextFormField(
                          controller: _emailField,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Email");
                            }

                            if (value == _auth.currentUser!.email) {
                              return ("The email address is already registerd");
                            }
                            //reg exp

                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Please Enter valid Email");
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _emailField.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.white70,
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 0.702),
                                fontFamily: 'Microsoft_PhagsPa'),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: Colors.white70,
                                width: 3.0,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 15),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(97, 120, 232,
                                1), //background color of dropdown button //border of dropdown button
                            borderRadius: BorderRadius.circular(
                                40), //border raiuds of dropdown button
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 20.0),
                            child: DropdownButton(
                              dropdownColor: Color.fromRGBO(97, 120, 232, 1),
                              // Initial Value
                              value: dropdownvalue,
                              hint: Text("Please select your nigebrhood"),

                              // Down Arrow Icon
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white70,
                              ),

                              // Array list of items
                              items: neighbrhoods.map((String items) {
                                return DropdownMenuItem(
                                    value: items,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.school,
                                          color: Colors.white70,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          items,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white70,
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
                                });
                              },
                            ),
                          ),
                        ),
                      )

                      // -----------------------------------------------------
                      // Button
                      ,
                      SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () async {
                          signup(_emailField.text, _passwordField.text);
                        },
                        child: const Text(
                          'Get Started',
                          style: TextStyle(letterSpacing: 2),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(243, 214, 35, 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 15),
                            textStyle: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void signup(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {pushToFireStore()})
          .catchError((e) {
        print(e.toString());
      });
    }
  }

  void pushToFireStore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? customer = _auth.currentUser;
    Customer customerModel = Customer();
    customerModel.email = customer!.email;
    customerModel.name = _fullNameField.text;
    customerModel.customerid = customer.uid;
    customerModel.phoneNumber = _phoneNumberField.text;
    customerModel.schoolName = dropdownvalue;

    await firebaseFirestore
        .collection("customer")
        .doc(customerModel.customerid)
        .set(customerModel.toMap());

    await firebaseFirestore
        .collection("customer-company")
        .doc(customerModel.customerid)
        .set({"companyID": ""});

    uid();
    print(customerModel.toMap());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Login(null, widget.neighbrhoods, null)),
        (route) => false);
  }

  Future<List<Days>> uid() async {
    User? customer = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    List<Days> days = [
      Days(
          customerid: customer!.uid,
          day: "1Sunday",
          pickup: "8:00 AM",
          dropoff: "12:00 PM",
          active: true),
      Days(
          customerid: customer.uid,
          day: "2Monday",
            pickup: "8:00 AM",
          dropoff: "12:00 PM",
          active: true),
      Days(
          customerid: customer.uid,
          day: "3Tuesday",
          pickup: "8:00 AM",
          dropoff: "12:00 PM",
          active: true),
      Days(
          customerid: customer.uid,
          day: "4Wednesday",
          pickup: "8:00 AM",
          dropoff: "12:00 PM",
          active: false),
      Days(
          customerid: customer.uid,
          day: "5Thursday",
          pickup: "8:00 AM",
          dropoff: "12:00 PM",
          active: false),
    ];
    for (var i = 0; i < days.length; i++) {
      await firebaseFirestore
          .collection("schadule")
          .doc(customer.uid)
          .collection("days")
          .doc(days[i].day!)
          .set(days[i].toMap());
    }
    return days;
  }
}
