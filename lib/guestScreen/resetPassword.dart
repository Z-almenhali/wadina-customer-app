import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wadina_app/guestScreen/PaymentCard.dart';
import 'package:wadina_app/guestScreen/login.dart';


class ResetPassword extends StatefulWidget {
  String neighbrhoods;
  ResetPassword(this.neighbrhoods);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _emailField = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(40),
                      bottomRight: const Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(97, 120, 232, 1),
                        spreadRadius: 3),
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          'assets/resetPassword.png',
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  child: Column(
                    children: [
                      Text("Forget Password? It's Ok",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: 'Microsoft_PhagsPa',
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1)),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Text(
                            "Please Enter Your password to send verficiation code",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Microsoft_PhagsPa',
                            ),
                            textAlign: TextAlign.center),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 60, right: 60),
                        child: TextFormField(
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please Enter Your Email");
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
                          controller: _emailField,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(179, 0, 0, 0),
                                fontFamily: 'Microsoft_PhagsPa'),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 3.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // -----------------------------------------------------
                      // Button
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            // auth.sendPasswordResetEmail(email: _emailField.text);
                            print(_emailField.text);
                            showDialog(
                              barrierColor: Colors.black26,
                              context: context,
                              builder: (context) {
                                return ReminderAlertDialog(
                                  title: "Woo hoo!",
                                  description: "Please check your email now!",
                                  icon: Icons.mark_email_read,
                                  page: Login(null,widget.neighbrhoods,null),
                                );
                              },
                            );
                          }
                        },
                        child: const Text(
                          'Send',
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
                      // Text
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
