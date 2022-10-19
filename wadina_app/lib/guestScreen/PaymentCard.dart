import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wadina_app/guestScreen/schadule.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import '../customerScreen/homePage.dart';
import '../model/company.dart';
import '../model/creditCard.dart';
import '../model/customer.dart';

class PaymentCard extends StatefulWidget {
  Company? company;
  String neighbrhoods;

  String customerID;

  PaymentCard(this.customerID, this.company, this.neighbrhoods);

  @override
  _PaymentCardState createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  bool isSwitchedCard = true;
  bool isSwitchedCash = false;
  bool isable = true;
  TextEditingController _cardNumberField = TextEditingController();
  TextEditingController _ExpDateField = TextEditingController();
  TextEditingController _CVVField = TextEditingController();
  TextEditingController _cardHolderNameField = TextEditingController();
  Color isAbleColor = Color.fromARGB(255, 0, 0, 0);
  final _formkey = GlobalKey<FormState>();
  User? customer = FirebaseAuth.instance.currentUser;
  Customer customerModel = Customer();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CreditCard creditCard = CreditCard();

  void initState() {
    super.initState();
    // isLoading = true;

    print("customer uid");
    print(customer?.uid);
    FirebaseFirestore.instance
        .collection("customer")
        .doc(customer?.uid)
        .get()
        .then((value) {
      setState(() {
        print("customer is ");
        print(value.data());
        this.customerModel = Customer.fromMap(value.data());
        print("customerModel is is is " + customerModel.name.toString());
      });
    });

    FirebaseFirestore.instance
        .collection("creditCard")
        .doc(customer?.uid)
        .get()
        .then((value) {
      setState(() {
        print(value.data());
        this.creditCard = CreditCard.fromMap(value.data());
        print("creditCard is is is " + creditCard.amount.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("company in payment");
    print(widget.company?.name);
    return Scaffold(
      backgroundColor: Color.fromRGBO(97, 120, 232, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, top: 70),
              alignment: Alignment.bottomLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Schadule(widget.company,
                              widget.customerID, widget.neighbrhoods)));
                },
                child: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text("350.00 SR",
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w700)),
            ),
            Text("Per Month",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 590,
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(40),
                    topRight: const Radius.circular(40)),
                boxShadow: [
                  BoxShadow(color: Colors.white, spreadRadius: 3),
                ],
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 30),
                  child: (creditCard.cardNumber != null)
                      ? Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Card Number",
                                style: TextStyle(
                                    fontFamily: 'Microsoft_PhagsPa',
                                    fontSize: 18,
                                    color: isAbleColor),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 30, bottom: 20),
                                child: TextFormField(
                                  controller: TextEditingController()
                                    ..text = "${creditCard.cardholdername}",
                                  validator: (value) {
                                    // RegExp regex =
                                    //     new RegExp("(?:0[4-9]|1[0-2])/[2-9][2-9]");

                                    if (value!.isEmpty) {
                                      return ("Card Number cannot be empty");
                                    }

                                    // if (!regex.hasMatch(value)) {
                                    //   return ("please Enter Valid expire Date");
                                    // }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    new LengthLimitingTextInputFormatter(16),
                                  ],
                                  keyboardType: TextInputType.number,
                                  enabled: isable,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 5),
                                    fillColor:
                                        Color.fromARGB(245, 245, 245, 245),
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
                              Text("Card Holder Name",
                                  style: TextStyle(
                                      fontFamily: 'Microsoft_PhagsPa',
                                      fontSize: 18,
                                      color: isAbleColor)),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 30,
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("Card Holder Name cannot be empty");
                                    }
                                    return null;
                                  },
                                  controller: TextEditingController()
                                    ..text = "   ${creditCard.cardNumber!}",
                                  inputFormatters: [

                                    new LengthLimitingTextInputFormatter(16),
                                  ],
                                  enabled: isable,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 5),
                                    fillColor:
                                        Color.fromARGB(245, 245, 245, 245),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "CVV",
                                    style: TextStyle(
                                        fontFamily: 'Microsoft_PhagsPa',
                                        fontSize: 18,
                                        color: isAbleColor),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 80),
                                    child: Text(
                                      "Expire Date",
                                      style: TextStyle(
                                          fontFamily: 'Microsoft_PhagsPa',
                                          fontSize: 18,
                                          color: isAbleColor),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return ("CVV cannot be empty");
                                        }
                                        return null;
                                      },
                                      controller: _CVVField,
                                      inputFormatters: [
                                        new LengthLimitingTextInputFormatter(3),
                                      ],
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        signed: false,
                                        decimal: false,
                                      ),
                                      enabled: isable,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        fillColor:
                                            Color.fromARGB(245, 245, 245, 245),
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  245, 245, 245, 245),
                                              width: 30),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: TextFormField(
                                      controller: TextEditingController()
                                        ..text = "${creditCard.expDate}",
                                      onChanged: (value) {
                                        setState(() {
                                          value = value.replaceAll(
                                              RegExp(r"\D"), "");
                                          switch (value.length) {
                                            case 0:
                                              _ExpDateField.text = "MM/YY";
                                              _ExpDateField.selection =
                                                  TextSelection.collapsed(
                                                      offset: 0);
                                              break;
                                            case 1:
                                              _ExpDateField.text =
                                                  "${value}M/YY";
                                              _ExpDateField.selection =
                                                  TextSelection.collapsed(
                                                      offset: 1);
                                              break;
                                            case 2:
                                              _ExpDateField.text = "$value/YY";
                                              _ExpDateField.selection =
                                                  TextSelection.collapsed(
                                                      offset: 2);
                                              break;
                                            case 3:
                                              _ExpDateField.text =
                                                  "${value.substring(0, 2)}/${value.substring(2)}Y";
                                              _ExpDateField.selection =
                                                  TextSelection.collapsed(
                                                      offset: 4);
                                              break;
                                            case 4:
                                              _ExpDateField.text =
                                                  "${value.substring(0, 2)}/${value.substring(2, 4)}";
                                              _ExpDateField.selection =
                                                  TextSelection.collapsed(
                                                      offset: 5);
                                              break;
                                          }
                                          if (value.length > 4) {
                                            _ExpDateField.text =
                                                "${value.substring(0, 2)}/${value.substring(2, 4)}";
                                            _ExpDateField.selection =
                                                TextSelection.collapsed(
                                                    offset: 5);
                                          }
                                        });
                                      },
                                      validator: (value) {
                                        // RegExp regex =
                                        //     new RegExp("(?:0[4-9]|1[0-2])/[2-9][2-9]");

                                        if (value!.isEmpty) {
                                          return ("Expire Date is empty");
                                        }

                                        // if (!regex.hasMatch(value)) {
                                        //   return ("please Enter Valid expire Date");
                                        // }
                                        return null;
                                      },
                                      enabled: isable,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        fillColor:
                                            Color.fromARGB(245, 245, 245, 245),
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  245, 245, 245, 245),
                                              width: 30),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Save this Card",
                                      style: TextStyle(
                                          fontFamily: 'Microsoft_PhagsPa',
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w900)),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Switch(
                                      value: isSwitchedCard,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitchedCard = value;
                                          print(isSwitchedCard);
                                        });
                                      },
                                      activeTrackColor:
                                          Color.fromRGBO(97, 120, 232, 1),
                                      activeColor:
                                          Color.fromRGBO(97, 120, 232, 1),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("I want to pay cash later",
                                      style: TextStyle(
                                        fontFamily: 'Microsoft_PhagsPa',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: Color.fromRGBO(114, 206, 243, 1),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Switch(
                                      value: isSwitchedCash,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitchedCash = value;
                                          if (isSwitchedCash == true) {
                                            isable = false;
                                            isSwitchedCard = false;
                                            isAbleColor = Color.fromARGB(
                                                255, 112, 112, 112);
                                          } else {
                                            isable = true;
                                            isSwitchedCard = true;
                                            isAbleColor =
                                                Color.fromARGB(255, 0, 0, 0);
                                          }
                                        });
                                      },
                                      activeTrackColor:
                                          Color.fromRGBO(97, 120, 232, 1),
                                      activeColor:
                                          Color.fromRGBO(97, 120, 232, 1),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (isSwitchedCash == false) {
                                      if (_formkey.currentState!.validate()) {
                                        if (isSwitchedCard) {
                                          setState(() {
                                            customerModel.pickUpDriver =
                                                null;
                                            customerModel.dropOfDriver =
                                                null;
                                          });
                                          
                                          if (creditCard.cardNumber == null) {
                                            creditCard.cardNumber =
                                                _cardNumberField.text;
                                            creditCard.cardholdername =
                                                _cardHolderNameField.text;
                                            creditCard.expDate =
                                                _ExpDateField.text;
                                            creditCard.amount = 350;
                                            customerModel.paymentMethod =
                                                "creditcard";
                                            firebaseFirestore
                                                .collection("creditCard")
                                                .doc(widget.customerID)
                                                .set(creditCard.toMap());
                                          }
                                          FirebaseFirestore.instance
                                              .collection("company")
                                              .where("CompanyID",
                                                  isEqualTo: widget.company?.Id)
                                              .get()
                                              .then((value) {
                                            value.docs.forEach((element) {
                                              FirebaseFirestore.instance
                                                  .collection("company")
                                                  .doc(element.id)
                                                  .collection("customer")
                                                  .doc(widget.customerID)
                                                  .set({
                                                'customerid':
                                                    customerModel.customerid,
                                                'Name': customerModel.name,
                                                'phoneNumber':
                                                    customerModel.phoneNumber,
                                                'email': customerModel.email,
                                                'schoolName':
                                                    customerModel.schoolName,
                                                'latitude':
                                                    customerModel.latitude,
                                                'longitude':
                                                    customerModel.longitude,
                                                'paymentMethod':
                                                    customerModel.paymentMethod,
                                                'neighbrhoods':
                                                    widget.neighbrhoods,
                                                'driverDropoff':
                                                    null,
                                                'driverPickup':
                                                    null,
                                                'CompanyID': widget.company?.Id
                                              });
                                            });
                                          });
                                          showDialog(
                                            barrierColor: Colors.black26,
                                            context: context,
                                            builder: (context) {
                                              return ReminderAlertDialog(
                                                  title: "Payment Confirmed",
                                                  description:
                                                      "Payment completed successfully You can now edit your schedule and view company information",
                                                  icon: Icons.done_all_outlined,
                                                  page: HomePage(
                                                      0,
                                                      widget.company,
                                                      customerModel,
                                                      FirebaseFirestore
                                                          .instance,
                                                      FirebaseAuth.instance));
                                            },
                                          );
                                        }
                                      }
                                    } else {
                                      if (isSwitchedCash == true) {
                                        setState(() {
                                          customerModel.pickUpDriver =
                                              null;
                                          customerModel.dropOfDriver =
                                              null;
                                        });
                                        print("customerModel.pickUpDriver" +
                                            this
                                                .customerModel
                                                .pickUpDriver
                                                .toString());
                                        firebaseFirestore
                                            .collection("customer")
                                            .doc(widget.customerID)
                                            .update({'paymentMethod': "cash"});
                                        customerModel.paymentMethod = "cash";

                                        FirebaseFirestore.instance
                                            .collection("company")
                                            .where("CompanyID",
                                                isEqualTo: widget.company?.Id)
                                            .get()
                                            .then((value) {
                                          value.docs.forEach((element) {
                                            FirebaseFirestore.instance
                                                .collection("company")
                                                .doc(element.id)
                                                .collection("customer")
                                                .doc(widget.customerID)
                                                .set({
                                              'customerid':
                                                  customerModel.customerid,
                                              'Name': customerModel.name,
                                              'phoneNumber':
                                                  customerModel.phoneNumber,
                                              'email': customerModel.email,
                                              'schoolName':
                                                  customerModel.schoolName,
                                              'latitude':
                                                  customerModel.latitude,
                                              'longitude':
                                                  customerModel.longitude,
                                              'paymentMethod':
                                                  customerModel.paymentMethod,
                                              'neighbrhoods':
                                                  widget.neighbrhoods,
                                              'driverDropoff':
                                                  null,
                                              'driverPickup':
                                                  null,
                                              'CompanyID': widget.company?.Id
                                            });
                                          });
                                        });
                                        showDialog(
                                          barrierColor: Colors.black26,
                                          context: context,
                                          builder: (context) {
                                            return ReminderAlertDialog(
                                                title: "Payment Confirmed",
                                                description:
                                                    "Payment completed successfully You can now edit your schedule and view company information",
                                                icon: Icons.done_all_outlined,
                                                page: HomePage(
                                                    0,
                                                    widget.company,
                                                    customerModel,
                                                    FirebaseFirestore.instance,
                                                    FirebaseAuth.instance));
                                          },
                                        );
                                      }
                                    }

                                    pushToCustomerCompany();
                                  },
                                  child: const Text(
                                    'Pay Now',
                                    style: TextStyle(letterSpacing: 2),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(243, 214, 35, 1),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 100, vertical: 15),
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                ),
                              )
                            ],
                          ),
                        )
                      : Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Card Number",
                                style: TextStyle(
                                    fontFamily: 'Microsoft_PhagsPa',
                                    fontSize: 18,
                                    color: isAbleColor),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 30, bottom: 20),
                                child: TextFormField(
                                  controller: _cardNumberField,
                                  validator: (value) {
                                    // RegExp regex =
                                    //     new RegExp("(?:0[4-9]|1[0-2])/[2-9][2-9]");

                                    if (value!.isEmpty) {
                                      return ("Card Number cannot be empty");
                                    }

                                    // if (!regex.hasMatch(value)) {
                                    //   return ("please Enter Valid expire Date");
                                    // }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    new LengthLimitingTextInputFormatter(16),
                                  ],
                                  keyboardType: TextInputType.number,
                                  enabled: isable,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 5),
                                    fillColor:
                                        Color.fromARGB(245, 245, 245, 245),
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
                              Text("Card Holder Name",
                                  style: TextStyle(
                                      fontFamily: 'Microsoft_PhagsPa',
                                      fontSize: 18,
                                      color: isAbleColor)),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 30,
                                ),
                                child: TextFormField(
                                  validator: (value) {
                                    // RegExp regex =
                                    //     new RegExp("(?:0[4-9]|1[0-2])/[2-9][2-9]");

                                    if (value!.isEmpty) {
                                      return ("Card Holder Name cannot be empty");
                                    }

                                    // if (!regex.hasMatch(value)) {
                                    //   return ("please Enter Valid expire Date");
                                    // }
                                    return null;
                                  },
                                  controller: _cardHolderNameField,
                                  inputFormatters: [
                                    // FilteringTextInputFormatter.allow(
                                    //     RegExp("[a-z^DA-Z]")),
                                    new LengthLimitingTextInputFormatter(16),
                                  ],
                                  enabled: isable,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 5),
                                    fillColor:
                                        Color.fromARGB(245, 245, 245, 245),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "CVV",
                                    style: TextStyle(
                                        fontFamily: 'Microsoft_PhagsPa',
                                        fontSize: 18,
                                        color: isAbleColor),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 80),
                                    child: Text(
                                      "Expire Date",
                                      style: TextStyle(
                                          fontFamily: 'Microsoft_PhagsPa',
                                          fontSize: 18,
                                          color: isAbleColor),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: TextFormField(
                                      validator: (value) {
                                        // RegExp regex =
                                        //     new RegExp("(?:0[4-9]|1[0-2])/[2-9][2-9]");

                                        if (value!.isEmpty) {
                                          return ("CVV cannot be empty");
                                        }

                                        // if (!regex.hasMatch(value)) {
                                        //   return ("please Enter Valid expire Date");
                                        // }
                                        return null;
                                      },
                                      controller: _CVVField,
                                      inputFormatters: [
                                        new LengthLimitingTextInputFormatter(3),
                                      ],
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                        signed: false,
                                        decimal: false,
                                      ),
                                      enabled: isable,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        fillColor:
                                            Color.fromARGB(245, 245, 245, 245),
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  245, 245, 245, 245),
                                              width: 30),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: TextFormField(
                                      controller: _ExpDateField,
                                      onChanged: (value) {
                                        setState(() {
                                          value = value.replaceAll(
                                              RegExp(r"\D"), "");
                                          switch (value.length) {
                                            case 0:
                                              _ExpDateField.text = "MM/YY";
                                              _ExpDateField.selection =
                                                  TextSelection.collapsed(
                                                      offset: 0);
                                              break;
                                            case 1:
                                              _ExpDateField.text =
                                                  "${value}M/YY";
                                              _ExpDateField.selection =
                                                  TextSelection.collapsed(
                                                      offset: 1);
                                              break;
                                            case 2:
                                              _ExpDateField.text = "$value/YY";
                                              _ExpDateField.selection =
                                                  TextSelection.collapsed(
                                                      offset: 2);
                                              break;
                                            case 3:
                                              _ExpDateField.text =
                                                  "${value.substring(0, 2)}/${value.substring(2)}Y";
                                              _ExpDateField.selection =
                                                  TextSelection.collapsed(
                                                      offset: 4);
                                              break;
                                            case 4:
                                              _ExpDateField.text =
                                                  "${value.substring(0, 2)}/${value.substring(2, 4)}";
                                              _ExpDateField.selection =
                                                  TextSelection.collapsed(
                                                      offset: 5);
                                              break;
                                          }
                                          if (value.length > 4) {
                                            _ExpDateField.text =
                                                "${value.substring(0, 2)}/${value.substring(2, 4)}";
                                            _ExpDateField.selection =
                                                TextSelection.collapsed(
                                                    offset: 5);
                                          }
                                        });
                                      },
                                      validator: (value) {
                                        CreditCardValidator _ccValidator =
                                            CreditCardValidator();

                                        var expDateResults =
                                            _ccValidator.validateExpDate(
                                                _ExpDateField.text);

                                        if (!expDateResults
                                            .isPotentiallyValid) {
                                          return "invalid Date";
                                        }
                                      },
                                      enabled: isable,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        fillColor:
                                            Color.fromARGB(245, 245, 245, 245),
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  245, 245, 245, 245),
                                              width: 30),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Save this Card",
                                      style: TextStyle(
                                          fontFamily: 'Microsoft_PhagsPa',
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.w900)),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Switch(
                                      value: isSwitchedCard,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitchedCard = value;
                                          print(isSwitchedCard);
                                        });
                                      },
                                      activeTrackColor:
                                          Color.fromRGBO(97, 120, 232, 1),
                                      activeColor:
                                          Color.fromRGBO(97, 120, 232, 1),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("I want to pay cash later",
                                      style: TextStyle(
                                        fontFamily: 'Microsoft_PhagsPa',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: Color.fromRGBO(114, 206, 243, 1),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Switch(
                                      value: isSwitchedCash,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitchedCash = value;
                                          if (isSwitchedCash == true) {
                                            isable = false;
                                            isSwitchedCard = false;
                                            isAbleColor = Color.fromARGB(
                                                255, 112, 112, 112);
                                          } else {
                                            isable = true;
                                            isSwitchedCard = true;
                                            isAbleColor =
                                                Color.fromARGB(255, 0, 0, 0);
                                          }
                                        });
                                      },
                                      activeTrackColor:
                                          Color.fromRGBO(97, 120, 232, 1),
                                      activeColor:
                                          Color.fromRGBO(97, 120, 232, 1),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (isSwitchedCash == false) {
                                      if (_formkey.currentState!.validate()) {
                                        if (isSwitchedCard) {
                                          setState(() {
                                            customerModel.pickUpDriver =
                                                null;
                                            customerModel.dropOfDriver =
                                                null;
                                          });
                                          print("customerModel.pickUpDriver" +
                                              this
                                                  .customerModel
                                                  .pickUpDriver
                                                  .toString());

                                          if (creditCard.cardNumber == null) {
                                            creditCard.cardNumber =
                                                _cardNumberField.text;
                                            creditCard.cardholdername =
                                                _cardHolderNameField.text;
                                            creditCard.expDate =
                                                _ExpDateField.text;
                                            creditCard.amount = 350;
                                            customerModel.paymentMethod =
                                                "creditcard";
                                            firebaseFirestore
                                                .collection("creditCard")
                                                .doc(widget.customerID)
                                                .set(creditCard.toMap());
                                          }
                                          firebaseFirestore
                                              .collection("customer")
                                              .doc(widget.customerID)
                                              .update({
                                            'paymentMethod': "creditCard"
                                          });
                                          customerModel.paymentMethod =
                                              "creditCard";
                                          FirebaseFirestore.instance
                                              .collection("company")
                                              .where("CompanyID",
                                                  isEqualTo: widget.company?.Id)
                                              .get()
                                              .then((value) {
                                            value.docs.forEach((element) {
                                              FirebaseFirestore.instance
                                                  .collection("company")
                                                  .doc(element.id)
                                                  .collection("customer")
                                                  .doc(widget.customerID)
                                                  .set({
                                                'customerid':
                                                    customerModel.customerid,
                                                'Name': customerModel.name,
                                                'phoneNumber':
                                                    customerModel.phoneNumber,
                                                'email': customerModel.email,
                                                'schoolName':
                                                    customerModel.schoolName,
                                                'latitude':
                                                    customerModel.latitude,
                                                'longitude':
                                                    customerModel.longitude,
                                                'paymentMethod':
                                                    customerModel.paymentMethod,
                                                'neighbrhoods':
                                                    widget.neighbrhoods,
                                                'driverDropoff':
                                                    null,
                                                'driverPickup':
                                                    null,
                                                'CompanyID': widget.company?.Id
                                              });
                                            });
                                          });
                                          showDialog(
                                            barrierColor: Colors.black26,
                                            context: context,
                                            builder: (context) {
                                              return ReminderAlertDialog(
                                                  title: "Payment Confirmed",
                                                  description:
                                                      "Payment completed successfully You can now edit your schedule and view company information",
                                                  icon: Icons.done_all_outlined,
                                                  page: HomePage(
                                                      0,
                                                      widget.company,
                                                      customerModel,
                                                      FirebaseFirestore
                                                          .instance,
                                                      FirebaseAuth.instance));
                                            },
                                          );
                                        }
                                      }
                                    } else {
                                      if (isSwitchedCash == true) {
                                        setState(() {
                                          customerModel.pickUpDriver =
                                              null;
                                          customerModel.dropOfDriver =
                                              null;
                                        });
                                        print("customerModel.pickUpDriver" +
                                            this
                                                .customerModel
                                                .pickUpDriver
                                                .toString());
                                        firebaseFirestore
                                            .collection("customer")
                                            .doc(widget.customerID)
                                            .update({'paymentMethod': "cash"});
                                        customerModel.paymentMethod = "cash";

                                        FirebaseFirestore.instance
                                            .collection("company")
                                            .where("CompanyID",
                                                isEqualTo: widget.company?.Id)
                                            .get()
                                            .then((value) {
                                          value.docs.forEach((element) {
                                            FirebaseFirestore.instance
                                                .collection("company")
                                                .doc(element.id)
                                                .collection("customer")
                                                .doc(widget.customerID)
                                                .set({
                                              'customerid':
                                                  customerModel.customerid,
                                              'Name': customerModel.name,
                                              'phoneNumber':
                                                  customerModel.phoneNumber,
                                              'email': customerModel.email,
                                              'schoolName':
                                                  customerModel.schoolName,
                                              'latitude':
                                                  customerModel.latitude,
                                              'longitude':
                                                  customerModel.longitude,
                                              'paymentMethod':
                                                  customerModel.paymentMethod,
                                              'neighbrhoods':
                                                  widget.neighbrhoods,
                                              'driverDropoff':
                                                  null,
                                              'driverPickup':
                                                  null,
                                              'CompanyID': widget.company?.Id
                                            });
                                          });
                                        });
                                        showDialog(
                                          barrierColor: Colors.black26,
                                          context: context,
                                          builder: (context) {
                                            return ReminderAlertDialog(
                                                title: "Payment Confirmed",
                                                description:
                                                    "Payment completed successfully You can now edit your schedule and view company information",
                                                icon: Icons.done_all_outlined,
                                                page: HomePage(
                                                    0,
                                                    widget.company,
                                                    customerModel,
                                                    FirebaseFirestore.instance,
                                                    FirebaseAuth.instance));
                                          },
                                        );
                                      }
                                    }

                                    pushToCustomerCompany();
                                  },
                                  child: const Text(
                                    'Pay Now',
                                    style: TextStyle(letterSpacing: 2),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Color.fromRGBO(243, 214, 35, 1),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 100, vertical: 15),
                                      textStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                ),
                              )
                            ],
                          ),
                        )),
            )
          ],
        ),
      ),
    );
  }

  pushToCustomerCompany() async {
    await firebaseFirestore
        .collection("customer-company")
        .doc(customerModel.customerid)
        .set({"companyID": widget.company?.Id});
  }
}

class ReminderAlertDialog extends StatefulWidget {
  const ReminderAlertDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.page,
  }) : super(key: key);

  final String title, description;
  final icon;
  final page;

  @override
  _ReminderAlertDialogState createState() => _ReminderAlertDialogState();
}

class _ReminderAlertDialogState extends State<ReminderAlertDialog> {
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
              color: Colors.green,
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => widget.page));
                },
                child: Center(
                  child: Text(
                    "Got it",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
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
