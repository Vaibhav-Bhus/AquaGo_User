// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:majorpor/constants/shared_pref.dart';
import 'package:majorpor/screens/login/customer/entry_time_address.dart';
import 'package:majorpor/screens/login/customer/home_screen.dart';
import 'package:majorpor/widgets/controllers.dart';
import 'package:majorpor/widgets/custom_toast.dart';
import 'package:majorpor/widgets/error_dialog.dart';

class EntryTimeDetails extends StatefulWidget {
  const EntryTimeDetails({super.key});

  @override
  State<EntryTimeDetails> createState() => _EntryTimeDetailsState();
}

class _EntryTimeDetailsState extends State<EntryTimeDetails> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  // TextEditingController buisnessNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    // buisnessNameController.dispose();
    emailController.dispose();
    lastNameController.dispose();
    super.dispose();
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
          "Enter Personal Details",
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
              // SizedBox(
              //   height: 20,
              // ),
              // InkWell(
              //   onTap: () {
              //     _getImage();
              //   },
              //   child: CircleAvatar(
              //     radius: MediaQuery.of(context).size.width * 0.20,
              //     backgroundColor: Colors.white,
              //     backgroundImage: imageXFile == null
              //         ? null
              //         : FileImage(File(imageXFile!.path)),
              //     child: imageXFile == null
              //         ? Icon(
              //             Icons.add_photo_alternate,
              //             size: MediaQuery.of(context).size.width * 0.20,
              //             color: Colors.grey,
              //           )
              //         : null,
              //   ),
              // ),
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
                  controller: firstNameController,
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
                  controller: lastNameController,
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
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 25),
              //   padding: const EdgeInsets.symmetric(horizontal: 8),
              //   width: double.infinity,
              //   height: 48,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(6),
              //       gradient: const LinearGradient(
              //           colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
              //   child: TextFormField(
              //     controller: buisnessNameController,
              //     textDirection: TextDirection.ltr,
              //     decoration: const InputDecoration(
              //       border: InputBorder.none,
              //       hintText: "  Buisness Name",
              //       fillColor: Colors.transparent,
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
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
                  controller: emailController,
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
                  if (firstNameController.text.length < 1) {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorDialog(
                            message: "Please enter first name",
                          );
                        });
                  } else if (lastNameController.text.length < 1) {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorDialog(
                            message: "Please enter last name",
                          );
                        });
                  } else if (emailController.text.length < 1 ||
                      !validateEmail(emailController.text.trim())) {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorDialog(
                            message: "Please enter valid email id",
                          );
                        });
                  } else {
                    try {
                      await FirebaseFirestore.instance
                          .collection("Users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        "firstName": firstNameController.text,
                        'lastName': lastNameController.text,
                        // 'businessName': buisnessNameController.text,
                        'userMail': emailController.text,
                        'num': Controller.num,
                        'uId': FirebaseAuth.instance.currentUser!.uid
                      });
                      SharedPreferenceConstants.sharedPreferences!.setString(
                          SharedPreferenceConstants.mob, Controller.num);
                      SharedPreferenceConstants.sharedPreferences!.setString(
                          SharedPreferenceConstants.fname,
                          firstNameController.text.trim());
                      SharedPreferenceConstants.sharedPreferences!.setString(
                          SharedPreferenceConstants.lname,
                          lastNameController.text.trim());
                      SharedPreferenceConstants.sharedPreferences!.setString(
                          SharedPreferenceConstants.uid,
                          FirebaseAuth.instance.currentUser!.uid);
                      SharedPreferenceConstants.sharedPreferences!.setString(
                          SharedPreferenceConstants.mail,
                          emailController.text.trim());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EntryTimeAddress()));
                    } catch (e) {
                      customToast(e.toString());
                    }
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
                  child: const Text("Save and Continue",
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
