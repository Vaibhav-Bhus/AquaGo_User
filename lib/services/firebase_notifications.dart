import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
    // getToken();
    // initInfo();
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User Granted Permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User permission Provisional permission');
    } else {
      print('user Declined or has no granted permission');
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Messaging Screen"),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: textEditingController1,
            ),
            TextFormField(
              controller: textEditingController1,
            ),
            TextFormField(
              controller: textEditingController1,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: 276,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xFF283855),
                          Color(0xFF2E3F68),
                          Color(0xFF3B5197)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter)),
                child: const Text("Button",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
