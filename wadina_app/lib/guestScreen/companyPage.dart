import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wadina_app/guestScreen/avalibleCompanies.dart';
import 'package:wadina_app/guestScreen/companyContract.dart';
import '../model/company.dart';

// ignore: must_be_immutable
class CompanyPage extends StatefulWidget {
  String neighbrhoods;
  String? customerID;
  Company company;
  CompanyPage(this.company, this.neighbrhoods, this.customerID);

  @override
  _CompanyState createState() => _CompanyState();
}

class _CompanyState extends State<CompanyPage> {
  var isableColor = Color.fromRGBO(243, 214, 35, 1);
  void initState() {
    super.initState();
    // FirebaseFirestore.instance
    //     .collection('company')
    //     .doc(widget.company.Id)
    //     .get()
    //     .then((value) {
    //   setState(() {
    //     widget.company = Company.fromMap(value.data());

    //   });
    // });
    if (widget.company.registerStatus == false) {
      isableColor = Color.fromARGB(255, 207, 206, 198);
    } else {
      isableColor = Color.fromRGBO(243, 214, 35, 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("company company");
    print(widget.company.Id);
    return Scaffold(
      body: Stack(children: [
        Image.network(
          widget.company.imageUrl!,
          color: Colors.white.withOpacity(0.8),
          colorBlendMode: BlendMode.modulate,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70, left: 40),
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          avalibleCompanies(widget.neighbrhoods,widget.customerID)));
            },
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
                padding: const EdgeInsets.only(right: 225, top: 40),
                child: Text(widget.company.name!,
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
                      width: 110,
                    ),
                  
                    Icon(
                      Icons.phone,
                      size: 30,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    InkWell(
                      onTap: () async {
                         final Uri launchUri = Uri(
                      scheme: 'tel',
                                path: widget.company.phoneNumber,
                              );
                            await launch(launchUri.toString());
                      },
                      child: Text(widget.company.phoneNumber!,style: 
                      TextStyle(fontSize: 18,color: Color.fromRGBO(97, 120, 232, 1),fontWeight: FontWeight.bold),),
                    ),
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
              SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 35, right: 35),
                    child: Text("${widget.company.description}",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Microsoft_PhagsPa',
                            letterSpacing: 1,
                            height: 1.8)),
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  print(widget.customerID);
                  if (widget.company.registerStatus != false) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompanyContact(
                                widget.company, widget.neighbrhoods,widget.customerID)));
                  } else {
                    null;
                  }
                },
                child: const Text(
                  'Subscribe Now',
                  style: TextStyle(letterSpacing: 2),
                ),
                style: ElevatedButton.styleFrom(
                    primary: isableColor,
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
