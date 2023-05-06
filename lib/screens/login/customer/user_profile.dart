// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majorpor/widgets/controllers.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var fname, lname, email, business;

  getdetails() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value == null) {
        print("Not found");
      } else {
        setState(() {
          fname = value['firstName'].toString();
          lname = value['lastName'].toString();
          email = value['userMail'].toString();
          business = value['businessName'].toString();
        });
      }
    });
  }

  @override
  void initState() {
    getdetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF576CD6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 2.5,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Hero(
              tag: '',
              child: const CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                // backgroundImage:
                //     NetworkImage(info[index]["images"].toString()),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: 320,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(
                      colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
              child: TextFormField(
                controller: TextEditingController(text: fname ?? ""),
                onChanged: (String value) {
                  fname = value;
                },
                textDirection: TextDirection.ltr,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "  First Name",
                  fillColor: Colors.transparent,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: 320,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(
                      colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
              child: TextFormField(
                controller: TextEditingController(text: lname ?? ""),
                onChanged: (String value) {
                  lname = value;
                },
                textDirection: TextDirection.ltr,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "  Last Name",
                  fillColor: Colors.transparent,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: 320,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(
                      colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
              child: TextFormField(
                controller: TextEditingController(text: business ?? ""),
                onChanged: (String value) {
                  business = value;
                },
                textDirection: TextDirection.ltr,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "  Buisness Name",
                  fillColor: Colors.transparent,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: 320,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: const LinearGradient(
                      colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
              child: TextFormField(
                controller: TextEditingController(text: email ?? ""),
                onChanged: (String value) {
                  email = value;
                },
                textDirection: TextDirection.ltr,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "  Email",
                  fillColor: Colors.transparent,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .update({
                  "firstName": fname ?? "",
                  'lastName': lname ?? "",
                  'businessName': business ?? "",
                  'userMail': email ?? ""
                });
              },
              child: Container(
                width: 170,
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
                child: const Text("Save",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
