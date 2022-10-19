import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:wadina_app/model/company.dart';
import 'package:wadina_app/widgets/basicInfo.dart';
import 'package:wadina_app/widgets/daysCard.dart';
import 'package:wadina_app/widgets/profile.dart';
import '../guestScreen/PaymentCard.dart';
import '../guestScreen/splash.dart';
import '../model/customer.dart';
import '../model/notify.dart';
import '../widgets/ReminderAlertDialogForN.dart';

class HomePage extends StatefulWidget {
  Company? company;
  Customer? customer;
  var index;
  FirebaseFirestore firebaseFirestore;
  FirebaseAuth firebaseAuth;

  HomePage(this.index, this.company, this.customer, this.firebaseFirestore,
      this.firebaseAuth);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FlutterLocalNotificationsPlugin flutterNotification;
  notify? notification;

  // for testing use
  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  void initNotification() async {
    AndroidInitializationSettings androidInitialize =
        new AndroidInitializationSettings('app_icon');
    IOSInitializationSettings iOSInitialize = new IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);

    flutterNotification = new FlutterLocalNotificationsPlugin();

    InitializationSettings initializationsSettings = new InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);

    flutterNotification.initialize(initializationsSettings,
        onSelectNotification: notificationSelected);

    await flutterNotification.initialize(initializationsSettings);
    // ---------------------------------
  }

  @override
  initState() {
    super.initState();

    initFirebase();

    initNotification();

    User? customer = widget.firebaseAuth.currentUser;

    widget.firebaseFirestore.collection('company').get().then((value) {
      value.docs.forEach((elements) {
        FirebaseFirestore.instance
            .collection("company")
            .doc(elements.id)
            .collection("customer")
            .where("customerid", isEqualTo: widget.customer?.customerid)
            .get()
            .then((value) => value.docs.forEach((element) {
                  widget.customer = Customer.fromMapForCompany(element.data());
                }));
      });
    });
  }

  Future showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer",
        channelDescription: "This is my channel", importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    var scheduledTime = DateTime.now().add(Duration(seconds: 30));
    flutterNotification.schedule(
        1,
        "Hey you!! ",
        "Are you coming? please let us know",
        scheduledTime,
        generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    showNotification();

    final Containers1 = [
      basicInfo(widget.company, widget.customer),
      DaysCardCustomer(),
      Profile(widget.company, widget.customer),
    ];

    if (widget.index == null) {
      widget.index = widget.index;
    }

    final isClicked = MediaQuery.of(context).viewInsets.bottom > 5;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // App Bar
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(50),
                  bottomRight: const Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(97, 120, 232, 1).withOpacity(0.6),
                    spreadRadius: 3),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 40),
              child: Row(children: [
                Text(
                  "Hey, ",
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Microsoft_PhagsPa',
                      fontWeight: FontWeight.w200),
                ),
                Text('${widget.customer?.name?.split(" ")[0]}!',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Microsoft_PhagsPa',
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.waving_hand,
                  color: Color.fromRGBO(243, 214, 35, 1),
                ),
                SizedBox(
                  width: 90,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    size: 30,
                  ),
                  onPressed: () {
                    showDialog(
                      barrierColor: Colors.black26,
                      context: context,
                      builder: (context) {
                        return ReminderAlertDialog(
                          title: "Logout",
                          description: "are you sure you want to logout?",
                          icon: Icons.logout,
                          page: Splash(),
                        );
                        // ignore: dead_code
                        FirebaseAuth.instance.signOut();
                      },
                    );
                  },
                ),
              ]),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Containers1[widget.index],
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.schedule,
              ),
              onPressed: () {
                setState(() {
                  widget.index = 1;
                });
              },
            ),
            SizedBox(width: 0.0),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                setState(() {
                  widget.index = 2;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (MediaQuery.of(context).viewInsets.bottom > 5)
          ? null
          : FloatingActionButton(
              backgroundColor: Color.fromRGBO(243, 214, 35, 1),
              child: Icon(Icons.home),
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                              0,
                              widget.company,
                              widget.customer,
                              widget.firebaseFirestore,
                              widget.firebaseAuth)));
                });
              },
            ),
    );
  }

  Future notificationSelected(String? payload) async {
    showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return ReminderAlertDialogForN(
          title: "Daily Reminder",
          description: "If you will not come tomorrow please tell your driver",
          Text1: "I'm coming tomorrow",
          Text2: "Call Driver",
          icon: Icons.timelapse,
          company: widget.company,
          customer: widget.customer,
        );
      },
    );
    setState(() {
      widget.index = 0;
    });
  }
}

class DaysCardCustomer extends StatefulWidget {
  @override
  _DaysCardCustomerState createState() => _DaysCardCustomerState();
}

class _DaysCardCustomerState extends State<DaysCardCustomer> {
  @override
  Widget build(BuildContext context) {
    print("days");
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
      child: DaysCard(),
    );
  }
}
