import 'package:flutter/material.dart';
import 'package:wadina_app/guestScreen/companyPage.dart';
import 'package:wadina_app/guestScreen/current_location.dart';
import 'package:wadina_app/guestScreen/login.dart';
import '../model/company.dart';

class CompanyContact extends StatefulWidget {
  String neighbrhoods;
  String? customerId;
  Company company;
  CompanyContact(
    this.company,
    this.neighbrhoods,
    this.customerId
  );

  @override
  _CompanyState createState() => _CompanyState();
}

class _CompanyState extends State<CompanyContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.network(
          "${widget.company.imageUrl}",
          color: Colors.white.withOpacity(0.8),
          colorBlendMode: BlendMode.modulate,
        ),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CompanyPage(widget.company, widget.neighbrhoods,widget.customerId)));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 70, left: 40),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(color: Colors.black, spreadRadius: 3),
                ],
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 190),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(40),
                topRight: const Radius.circular(40)),
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 3),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 225, top: 50),
                child: Text("${widget.company.name}",
                    style: TextStyle(
                      fontSize: 26,
                      fontFamily: 'Microsoft_PhagsPa',
                      fontWeight: FontWeight.w600,
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 30,
                    ),
                    Text("${widget.company.rate}",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Microsoft_PhagsPa',
                          letterSpacing: 2,
                        )),
                    SizedBox(
                      width: 130,
                    ),
                    Icon(
                      Icons.payments_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.credit_card,
                      size: 30,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 30,
                    ),
                    Text("${widget.company.address}",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Microsoft_PhagsPa',
                          letterSpacing: 2,
                        )),
                    SizedBox(
                      width: 55,
                    ),
                    Icon(
                      Icons.price_change,
                      size: 30,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "SR" + "${widget.company.price}" + "/month",
                      style: TextStyle(
                          color: Color.fromRGBO(97, 120, 232, 1),
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Terms and Conditins",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Microsoft_PhagsPa',
                            letterSpacing: 1,
                            fontWeight: FontWeight.w900)),
                    SizedBox(height: 15),
                    Text("${widget.company.contract}",
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Microsoft_PhagsPa',
                            letterSpacing: 1,
                            height: 2)),
                  ],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  print(widget.customerId);
                  if (widget.customerId == null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login(widget.company,
                                widget.neighbrhoods, widget.customerId)));
                  } else {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CurrentLocation(
                                widget.company, widget.neighbrhoods, false)));
                  }
                },
                child: const Text(
                  'Agree & Continue',
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
              )
            ],
          ),
        )
      ]),
    );
  }
}
