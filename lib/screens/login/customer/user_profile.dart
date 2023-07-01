// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:majorpor/constants/shared_pref.dart';

import '../../../widgets/error_dialog.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var fname, lname, email, sellerImageUrl;

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
        });
      }
    });
  }

  @override
  void initState() {
    getdetails();

    super.initState();
  }

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity,
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
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity,
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
                margin: const EdgeInsets.symmetric(horizontal: 25),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity,
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
                  if (fname.trim().length < 1) {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorDialog(
                            message: "Please enter first name",
                          );
                        });
                  } else if (lname.trim().length < 1) {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorDialog(
                            message: "Please enter last name",
                          );
                        });
                  } else if (email.trim().length < 1 ||
                      !validateEmail(email.trim())) {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorDialog(
                            message: "Please enter last name",
                          );
                        });
                  } else {
                    await FirebaseFirestore.instance
                        .collection("Users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update({
                      "firstName": fname ?? "",
                      'lastName': lname ?? "",
                      'avatar': sellerImageUrl,
                      // 'businessName': business ?? "",
                      'userMail': email ?? ""
                    });
                    setState(() {
                      SharedPreferenceConstants.sharedPreferences!
                          .setString(SharedPreferenceConstants.fname, fname);
                      SharedPreferenceConstants.sharedPreferences!
                          .setString(SharedPreferenceConstants.lname, lname);
                      SharedPreferenceConstants.sharedPreferences!
                          .setString(SharedPreferenceConstants.mail, email);
                    });
                    Navigator.of(context).pop();
                  }
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
      ),
    );
  }

  bool validateEmail(String email) {
    if (email.isEmpty) {
      return false;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return false;
    }

    return true;
  }
}
