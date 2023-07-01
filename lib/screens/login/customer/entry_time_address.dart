import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majorpor/screens/login/customer/home_screen.dart';
import 'package:majorpor/widgets/custom_toast.dart';
import 'package:majorpor/widgets/error_dialog.dart';

class EntryTimeAddress extends StatefulWidget {
  const EntryTimeAddress({super.key});

  @override
  State<EntryTimeAddress> createState() => _EntryTimeAddressState();
}

class _EntryTimeAddressState extends State<EntryTimeAddress> {
  TextEditingController floorNoController = TextEditingController();
  TextEditingController areaNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController houseNoController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   floorNoController.dispose();
  //   areaNameController.dispose();
  //   cityNameController.dispose();
  //   buildingNameController.dispose();
  //   houseNoController.dispose();
  //   pinCodeController.dispose();
  //   streetNameController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF576CD6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Address",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
                  child: TextFormField(
                    controller: floorNoController,
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "  Floor No",
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
                  child: TextFormField(
                    controller: houseNoController,
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "  House No",
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
                  child: TextFormField(
                    controller: buildingNameController,
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "  Building Name",
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
                  child: TextFormField(
                    controller: streetNameController,
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "  Street Name",
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
                  child: TextFormField(
                    controller: areaNameController,
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "  Area Name",
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
                  child: TextFormField(
                    controller: cityNameController,
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "  City Name",
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
                  child: TextFormField(
                    controller: pinCodeController,
                    textDirection: TextDirection.ltr,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "  Pin Code",
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (pinCodeController.text.trim().length != 6) {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorDialog(
                            message: "Pin code should be 6 digit.",
                          );
                        });
                  } else if (pinCodeController.text
                          .trim()
                          .contains(RegExp(r'[a-z]')) ||
                      floorNoController.text
                          .trim()
                          .contains(RegExp(r'[a-z]'))) {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorDialog(
                            message:
                                "Pin code and floor no should be in digits.",
                          );
                        });
                  } else if (floorNoController.text.trim().length < 1) {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorDialog(
                            message: "Floor number can't be empty.",
                          );
                        });
                  } else if (areaNameController.text.length > 0 &&
                      cityNameController.text.length > 0 &&
                      streetNameController.text.length > 0 &&
                      buildingNameController.text.length > 0 &&
                      houseNoController.text.length > 0 &&
                      pinCodeController.text.length == 6) {
                    try {
                      await FirebaseFirestore.instance
                          .collection("Addresses")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        "AreaName": areaNameController.text,
                        'cityName': cityNameController.text,
                        'streetName': streetNameController.text,
                        'buildingName': buildingNameController.text,
                        'houseNo': houseNoController.text,
                        'pinCode': pinCodeController.text,
                        'uId': FirebaseAuth.instance.currentUser!.uid,
                        'floorNo': floorNoController.text
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    } catch (e) {
                      customToast(e.toString());
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorDialog(
                            message: "Please check all fields.",
                          );
                        });
                  }
                },
                child: Container(
                  width: 190,
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
                  child: const Text("Save Address Details",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
