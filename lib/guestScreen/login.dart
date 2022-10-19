import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wadina_app/constants.dart';
import 'package:wadina_app/guestScreen/avalibleCompanies.dart';
import 'package:wadina_app/guestScreen/current_location.dart';
import 'package:wadina_app/guestScreen/intro.dart';
import 'package:wadina_app/guestScreen/resetPassword.dart';
import 'package:wadina_app/guestScreen/signup.dart';
import '../customerScreen/homePage.dart';
import '../model/company.dart';
import '../model/customer.dart';

class EmailValidator {
  static String validate(String email) {
    if (email.isEmpty) {
      return ("Please Enter Your Email");
    }

    //reg exp
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(email)) {
      return ("Please Enter valid Email");
    }
    return "";
  }
}

class PasswordValidator {
  static String validate(String password) {
    if (password.isEmpty) {
      return ("please Enter Your Password");
    }

    return "";
  }
}

class Login extends StatefulWidget {
  Company? company;
  String? customerid;
  String neighbrhoods;

  Login(this.company, this.neighbrhoods, this.customerid);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<Login> {
  //-------------------------------------------------------------------------
  TextEditingController _passwordField = TextEditingController();
  TextEditingController _emailField = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  Customer customerModel = new Customer();
  var isLoading = true;

  //-------------------------------------------------------------------------
  // @override
  // void initState() {
  //   readinfCustomers('wgI0FsyM6tXgAiICAmVbYVTO2Yh2');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(97, 120, 232, 1),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                if (widget.customerid != null) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              avalibleCompanies(
                                                  widget.neighbrhoods,
                                                  widget.customerid)));
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Intro()));
                                }
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: 30,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 85),
                              child: Text(
                                "Welcome!",
                                style: TextStyle(
                                    fontSize: 35,
                                    fontFamily: 'Microsoft_PhagsPa',
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Please sign in to continue",
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: 'Microsoft_PhagsPa',
                          ),
                        ),
                        SizedBox(height: 40),
                        Image.asset('assets/logo.png'),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: TextFormField(
                            key: ValueKey("email"),
                            autofocus: false,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) =>
                                (EmailValidator.validate(value!) == ""
                                    ? null
                                    : EmailValidator.validate(value)),
                            onSaved: (value) {
                              _emailField.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            controller: _emailField,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white70,
                              ),
                              labelText: ' Enter your email',
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
                        SizedBox(height: 20),
                        // ---------------------------------------------------------------
                        // Password Text Field

                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: TextFormField(
                            key: ValueKey("password"),
                            obscureText: true,
                            autofocus: false,
                            validator: (value) =>
                                (PasswordValidator.validate(value!) == ""
                                    ? null
                                    : PasswordValidator.validate(value)),
                            controller: _passwordField,
                            onSaved: (value) {
                              _passwordField.text = value!;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.white70,
                              ),
                              labelText: ' Enter your password',
                              labelStyle: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Micrrdosoft_PhagsPa'),
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

                        SizedBox(height: 40),
                        // -----------------------------------------------------
                        // Button

                        ElevatedButton(
                          key: ValueKey("loginBtn"),
                          onPressed: () async {
                            login(
                                _emailField.text, _passwordField.text, context);
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
                        // Text
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ResetPassword(widget.neighbrhoods)),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text.rich(
                              TextSpan(
                                text: 'Forget password? ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Microsoft_PhagsPa',
                                    fontWeight: FontWeight.bold),
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: ' Reset password',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(114, 206, 243, 1),
                                          fontSize: 18,
                                          fontFamily: 'Microsoft_PhagsPa',
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Signup(widget.neighbrhoods)),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text.rich(
                                TextSpan(
                                  text: 'Dont have an account yet? ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Microsoft_PhagsPa',
                                      fontWeight: FontWeight.bold),
                                  children: const <TextSpan>[
                                    TextSpan(
                                        text: ' sign up',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                114, 206, 243, 1),
                                            fontSize: 18,
                                            fontFamily: 'Microsoft_PhagsPa',
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

// entsaar@gmail.com to home page
// zehar@gmail.com to avalible companies
// passwords AMAMAM

// Login method
  void login(String email, String password, BuildContext context) async {
    try {
      print("inside method");
      showSnackBar("Welcome Back", context, Colors.green);
      if (_formkey.currentState!.validate()) {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then(
          (value) async {
            widget.customerid = value.user?.uid;
            readingCustomers(widget.customerid);
          },
        ).catchError((e) {
          showSnackBar("invalid email or password", context, Colors.red);
          print("Error");
        });
      }
    } catch (e) {
      showSnackBar("invalid email or password", context, Colors.red);
    }
  }

  // retrive customer data
  readingCustomers(String? cusId) async {
    // get customer company ref
    final customerCompanyRef = await FirebaseFirestore.instance
        .collection("customer-company")
        .doc(cusId)
        .get();

    // check if new customer
    if (customerCompanyRef["companyID"].trim() == "") {
      navigateToCompaniesPage();
    }

    // get company by id
    final company = await FirebaseFirestore.instance
        .collection('company')
        .doc(customerCompanyRef["companyID"].trim())
        .get();

    // set to variable
    widget.company = Company.fromMap(company);

    // get customer from company
    final customer = await FirebaseFirestore.instance
        .collection('company')
        .doc(customerCompanyRef["companyID"].trim())
        .collection('customer')
        .doc(cusId)
        .get();

    print(customer["Name"]);
    this.customerModel = Customer.fromMapForCompany(customer);

    if (customer.data() != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(0, widget.company, customerModel,
                  FirebaseFirestore.instance, FirebaseAuth.instance)));
    } else if (widget.company == null) {
      navigateToCompaniesPage();
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CurrentLocation(widget.company, widget.neighbrhoods, false)));
    }
  }

  void navigateToCompaniesPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                avalibleCompanies(widget.neighbrhoods, widget.customerid)));
  }
}
