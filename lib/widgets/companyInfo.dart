import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wadina_app/model/company.dart';

import 'companyCard.dart';

// ignore: must_be_immutable
class CompanyInfo extends StatefulWidget {
  String? customerID;
  String neighbrhoods;
  CompanyInfo(this.neighbrhoods,this.customerID);

  @override
  _CompanyInfoState createState() => _CompanyInfoState();
}

class _CompanyInfoState extends State<CompanyInfo> {
  Company company = Company();

  List<Company> companies = [];

  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('company').get().then((value) {
      value.docs.forEach(
        (element) {
          company = Company.fromMap(element.data());
          companies.add(company);
          print(element.data());
        },
      );
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 30),
        itemCount: companies.length,
        itemBuilder: (BuildContext context, int index) {
          return CompanyCard(companies[index], widget.neighbrhoods,widget.customerID);
        });
  }
}
