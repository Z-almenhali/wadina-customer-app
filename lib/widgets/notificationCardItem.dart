import 'package:flutter/material.dart';
import 'package:wadina_app/customerScreen/homePage.dart';
import 'package:wadina_app/model/notify.dart';

import 'ReminderAlertDialogForN.dart';

class notificationCardItem extends StatefulWidget {
  
  notify? notificationList;
  notificationCardItem(this.notificationList);

  @override
  _notificationCardItemState createState() => _notificationCardItemState();
}

class _notificationCardItemState extends State<notificationCardItem> {
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child:Column(children: [
 (widget.notificationList!=null)
        ? Column(
            children: [
              (widget.notificationList?.notType == "Daily Reminder")
                  ? InkWell(
                      onTap: () {
                        showDialog(
                          barrierColor: Colors.black26,
                          context: context,
                          builder: (context) {
                            return ReminderAlertDialogForN(
                              title: widget.notificationList?.notType,
                              description: widget.notificationList?.content,
                              Text1: "I'm coming tomorrow",
                              Text2: "Call Driver",
                              icon: widget.notificationList?.icon,
                            );
                          },
                        );
                      },
                      child: ListTile(
                        title: Text(widget.notificationList?.notType,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Microsoft_PhagsPa',
                              fontWeight: FontWeight.bold,
                            )),
                        leading: InkWell(
                          child: Icon(
                            widget.notificationList?.icon,
                            color: Color.fromRGBO(114, 206, 243, 1),
                            size: 40,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text("Read More",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Microsoft_PhagsPa',
                                )),
                            SizedBox(
                              width: 80,
                            ),
                            Icon(Icons.more_horiz)
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        showDialog(
                          barrierColor: Colors.black26,
                          context: context,
                          builder: (context) {
                            return ReminderAlertDialogForN(
                              title: widget.notificationList?.notType,
                              description: widget.notificationList?.content,
                              Text1: "Show Information",
                              Text2: "Cancel",
                              icon: widget.notificationList?.icon,
                            );
                          },
                        );
                      },
                      child: ListTile(
                        title: Text(widget.notificationList?.notType,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Microsoft_PhagsPa',
                              fontWeight: FontWeight.bold,
                            )),
                        leading: InkWell(
                          child: Icon(
                            widget.notificationList?.icon,
                            color: Color.fromRGBO(114, 206, 243, 1),
                            size: 40,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Text("Read More",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Microsoft_PhagsPa',
                                )),
                            SizedBox(
                              width: 80,
                            ),
                            Icon(Icons.more_horiz)
                          ],
                        ),
                      ),
                    )
            ],
          )
          :Column(children: [
            Text("There is no Notification")
          ],)
        ],)
       
      ,
          decoration: BoxDecoration(
              border: Border(
            bottom:
                BorderSide(width: 1, color: Color.fromARGB(112, 112, 112, 112)),
          ))),
    );
  }
}

