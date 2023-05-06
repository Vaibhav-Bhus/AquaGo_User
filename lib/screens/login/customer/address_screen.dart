import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majorpor/screens/login/customer/checkout_screen.dart';
import 'package:majorpor/screens/login/customer/home_screen.dart';
import 'package:majorpor/widgets/controllers.dart';
import 'package:majorpor/widgets/custom_toast.dart';

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
        elevation: 1,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Address",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 1.5,
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
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8.0),
                  width: 320,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
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
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8.0),
                  width: 320,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
                  child: TextFormField(
                    controller: TextEditingController(text: houseNo ?? ""),
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
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8.0),
                  width: 320,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
                  child: TextFormField(
                    controller: TextEditingController(text: buildingName ?? ""),
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
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8.0),
                  width: 320,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
                  child: TextFormField(
                    controller: TextEditingController(text: streetName ?? ""),
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
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8.0),
                  width: 320,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
                  child: TextFormField(
                    controller: TextEditingController(text: areaName ?? ""),
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
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8.0),
                  width: 320,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
                  child: TextFormField(
                    controller: TextEditingController(text: cityName ?? ""),
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
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(8.0),
                  width: 320,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFE8ECFD), Color(0xFF8898E3)])),
                  child: TextFormField(
                    controller: TextEditingController(text: pinCode ?? ""),
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
              InkWell(
                onTap: () async {
                  if (areaName.length > 1 &&
                      cityName.length > 1 &&
                      streetName.length > 1 &&
                      buildingName.length > 1 &&
                      houseNo.length > 1 &&
                      pinCode.length > 1) {
                    try {
                      await FirebaseFirestore.instance
                          .collection("Addresses")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set({
                        "AreaName": areaName,
                        'cityName': cityName,
                        'streetName': streetName,
                        'buildingName': buildingName,
                        'houseNo': houseNo,
                        'pinCode': pinCode,
                        'uId': FirebaseAuth.instance.currentUser!.uid,
                        'floorNo': floorNo ?? '0'
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckoutScreen(
                                    floorNo: floorNo ?? 0,
                                    address:
                                        '${houseNo}, ${buildingName}, ${areaName}, ${streetName}, ${cityName},  ${pinCode}',
                                  )));
                    } catch (e) {
                      customToast(e.toString());
                    }
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
                  child: const Text("Proceed to Checkout",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
