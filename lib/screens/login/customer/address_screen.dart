import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majorpor/screens/login/customer/checkout_screen.dart';
import 'package:majorpor/screens/login/customer/home_screen.dart';
import 'package:majorpor/widgets/button_loader.dart';
import 'package:majorpor/widgets/controllers.dart';
import 'package:majorpor/widgets/custom_toast.dart';
import 'package:majorpor/widgets/error_dialog.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  var areaName, buildingName, cityName, houseNo, pinCode, streetName, floorNo;

  getdetails() async {
    await FirebaseFirestore.instance
        .collection("Addresses")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value == null) {
        print("Not found");
      } else {
        setState(() {
          areaName = value['AreaName'].toString();
          buildingName = value['buildingName'].toString();
          cityName = value['cityName'].toString();
          houseNo = value['houseNo'].toString();
          pinCode = value['pinCode'].toString();
          streetName = value['streetName'].toString();
          floorNo = value['floorNo'].toString();
        });
      }
    });
    setState(() {
      loading = false;
      screenLoading = false;
    });
  }

  bool screenLoading = false;
  bool loading = false;
  @override
  void initState() {
    getdetails();
    setState(() {
      screenLoading = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF576CD6),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Address",
          style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: screenLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 26, 8, 8),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: const LinearGradient(colors: [
                              Color(0xFFE8ECFD),
                              Color(0xFF8898E3)
                            ])),
                        child: TextFormField(
                          controller: TextEditingController(text: floorNo),
                          onChanged: (String value) {
                            floorNo = value;
                          },
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
                            gradient: const LinearGradient(colors: [
                              Color(0xFFE8ECFD),
                              Color(0xFF8898E3)
                            ])),
                        child: TextFormField(
                          controller:
                              TextEditingController(text: houseNo ?? ""),
                          onChanged: (String value) {
                            houseNo = value;
                          },
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
                            gradient: const LinearGradient(colors: [
                              Color(0xFFE8ECFD),
                              Color(0xFF8898E3)
                            ])),
                        child: TextFormField(
                          controller:
                              TextEditingController(text: buildingName ?? ""),
                          onChanged: (String value) {
                            buildingName = value;
                          },
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
                            gradient: const LinearGradient(colors: [
                              Color(0xFFE8ECFD),
                              Color(0xFF8898E3)
                            ])),
                        child: TextFormField(
                          controller:
                              TextEditingController(text: streetName ?? ""),
                          onChanged: (String value) {
                            streetName = value;
                          },
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
                            gradient: const LinearGradient(colors: [
                              Color(0xFFE8ECFD),
                              Color(0xFF8898E3)
                            ])),
                        child: TextFormField(
                          controller:
                              TextEditingController(text: areaName ?? ""),
                          onChanged: (String value) {
                            areaName = value;
                          },
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
                            gradient: const LinearGradient(colors: [
                              Color(0xFFE8ECFD),
                              Color(0xFF8898E3)
                            ])),
                        child: TextFormField(
                          controller:
                              TextEditingController(text: cityName ?? ""),
                          onChanged: (String value) {
                            cityName = value;
                          },
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
                            gradient: const LinearGradient(colors: [
                              Color(0xFFE8ECFD),
                              Color(0xFF8898E3)
                            ])),
                        child: TextFormField(
                          controller:
                              TextEditingController(text: pinCode ?? ""),
                          onChanged: (String value) {
                            pinCode = value;
                          },
                          textDirection: TextDirection.ltr,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "  Pin Code",
                            fillColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    InkWell(
                        onTap: () async {
                          setState(() {
                            loading = true;
                          });
                          print('setup');

                          print('if');

                          if (pinCode.trim().length != 6) {
                            setState(() {
                              loading = false;
                            });
                            showDialog(
                                context: context,
                                builder: (c) {
                                  return ErrorDialog(
                                    message: "Pin code should be 6 digit.",
                                  );
                                });
                          } else if (pinCode
                                  .trim()
                                  .contains(RegExp(r'[a-z]')) ||
                              floorNo.trim().contains(RegExp(r'[a-z]'))) {
                            setState(() {
                              loading = false;
                            });

                            showDialog(
                                context: context,
                                builder: (c) {
                                  return ErrorDialog(
                                    message:
                                        "Pin code and floor no should be in digits.",
                                  );
                                });
                          } else if (areaName.length > 0 &&
                              cityName.length > 0 &&
                              streetName.length > 0 &&
                              buildingName.length > 0 &&
                              houseNo.length > 0 &&
                              pinCode.length == 6) {
                            try {
                              await FirebaseFirestore.instance
                                  .collection("Addresses")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                "AreaName": areaName,
                                'cityName': cityName,
                                'streetName': streetName,
                                'buildingName': buildingName,
                                'houseNo': houseNo,
                                'pinCode': pinCode,
                                'uId': FirebaseAuth.instance.currentUser!.uid,
                                'floorNo': floorNo
                              });

                              setState(() {
                                loading = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckoutScreen(
                                            address:
                                                '$houseNo, $buildingName $streetName $areaName, $cityName, $pinCode',
                                            floorNo: floorNo,
                                          )));
                            } catch (e) {
                              customToast(e.toString());
                            }
                          } else {
                            setState(() {
                              loading = false;
                            });

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
                          width: 210,
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
                          child: loading
                              ? buttonLoader
                              : const Text("Proceed to Checkout",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white)),
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}
