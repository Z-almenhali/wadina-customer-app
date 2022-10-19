import 'package:flutter/material.dart';
import 'package:wadina_app/model/company.dart';
import '../guestScreen/companyPage.dart';

class CompanyCard extends StatefulWidget {
  Company company;
  String? customerID;
  String neighbrhoods;

  CompanyCard(this.company, this.neighbrhoods,this.customerID);

  @override
  _CompanyCardState createState() => _CompanyCardState();
}

class _CompanyCardState extends State<CompanyCard> {
  @override
  Widget build(BuildContext context) {
    print("inside card");
    print(widget.company.name);
    return Padding(
      padding: const EdgeInsets.only(right: 50, left: 50),
      child: Column(
        children: [
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CompanyPage(widget.company, widget.neighbrhoods,widget.customerID)),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.company.imageUrl!,
                    width: 300,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 150, left: 20),
                width: 70,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(220, 255, 255, 255),
                        spreadRadius: 3),
                  ],
                ),
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      widget.company.rate!,
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 15),
                    Icon(Icons.star_border),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.company.name!,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ),
          Container(
              alignment: Alignment.centerRight,
              child: Text(
                "SR" + widget.company.price!,
                style: TextStyle(
                    color: Color.fromRGBO(97, 120, 232, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
          Container(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Color.fromARGB(112, 112, 112, 112),
                    size: 20,
                  ),
                  Text(
                    widget.company.address!,
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(191, 191, 191, 1)),
                  )
                ],
              )),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
