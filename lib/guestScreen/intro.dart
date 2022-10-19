import 'package:flutter/material.dart';
import 'package:wadina_app/guestScreen/avalibleCompanies.dart';

import 'login.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  String dropdownvalue = 'Alfihaa';

  // List of items in our dropdown menu
  var neighbrhoods = [
    'Alfihaa',
    'Aljamaa',
    'Alnaseem',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(97, 120, 232, 1),
      body: Column(
        children: [
          Container(
              margin: EdgeInsets.only(top: 100),
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                  text: 'W',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontFamily: 'Arial',
                      fontWeight: FontWeight.bold),
                  children: const <TextSpan>[
                    TextSpan(
                        text: 'a',
                        style: TextStyle(
                            color: Color.fromRGBO(243, 214, 35, 1),
                            fontSize: 60,
                            fontFamily: 'Arial')),
                    TextSpan(
                        text: 'dina',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 60,
                            fontFamily: 'Arial')),
                  ],
                ),
              )),
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 50),
              child: Text.rich(
                TextSpan(
                  text: 'و',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  children: const <TextSpan>[
                    TextSpan(
                        text: 'دّ',
                        style: TextStyle(
                          color: Color.fromRGBO(243, 214, 35, 1),
                          fontSize: 30,
                        )),
                    TextSpan(
                        text: 'ينا',
                        style: TextStyle(color: Colors.white, fontSize: 30)),
                  ],
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Image.asset('assets/logo.png'),
          ),

          // Welocome container
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(40),
                  topRight: const Radius.circular(40)),
              boxShadow: [
                BoxShadow(color: Colors.white, spreadRadius: 3),
              ],
            ),
            margin: EdgeInsets.only(top: 30),
            width: MediaQuery.of(context).size.width,
            height: 380,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text("Welcome",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Microsoft_PhagsPa',
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 15),
                Text(
                    'We brings together school transport companies.Please choose your city first to review the companies.',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Microsoft_PhagsPa',
                        fontWeight: FontWeight.w200)),
                SizedBox(height: 30),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 214, 35,
                        1), //background color of dropdown button //border of dropdown button
                    borderRadius: BorderRadius.circular(
                        40), //border raiuds of dropdown button
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue,
                      hint: Text("Please select your nigebrhood"),

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: neighbrhoods.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items, style: TextStyle(fontSize: 18)),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => avalibleCompanies(dropdownvalue,null)));
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login(null,dropdownvalue,null)),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: '             or ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Microsoft_PhagsPa',
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Click here ',
                            style: TextStyle(
                              color: Color.fromRGBO(97, 120, 232, 1),
                              fontSize: 18,
                              fontFamily: 'Microsoft_PhagsPa',
                            )),
                        TextSpan(
                            text: 'to login',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: 'Microsoft_PhagsPa')),
                      ],
                    ),
                    key: const ValueKey("loginTap"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
