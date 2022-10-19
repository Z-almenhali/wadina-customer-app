import 'package:flutter/material.dart';
import 'package:wadina_app/model/notify.dart';
import 'package:wadina_app/widgets/notificationCardItem.dart';



class notificationCard extends StatefulWidget {
notify? notification;
notificationCard(this.notification);
  @override
  _notificationCardState createState() => _notificationCardState();
}

class _notificationCardState extends State<notificationCard> {
  @override
  final notificationList = [];

  @override
  Widget build(BuildContext context) {
    notificationList.add(widget.notification);
    return Container(
        margin: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width - 60,
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.white, spreadRadius: 3),
          ],
        ),

        child: ListView.builder(
            padding: EdgeInsets.all(10),
            itemCount: notificationList.length,
            itemBuilder: (BuildContext context, int index) {
              return notificationCardItem(notificationList[index]);
            }));
  }
}