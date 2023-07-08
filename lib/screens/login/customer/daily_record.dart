// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majorpor/constants/shared_pref.dart';
import 'package:majorpor/screens/login/customer/drawer.dart';
import 'package:majorpor/screens/login/customer/past_entries_screen.dart';

import '../../../models/daily_orders.dart';

class DailyRecord extends StatefulWidget {
  const DailyRecord({super.key});

  @override
  State<DailyRecord> createState() => _DailyRecordState();
}

class _DailyRecordState extends State<DailyRecord> {
  getData() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        isdaily = value.data()!['dailyUser'];
        sellerUid = value.data()!['dailySellerUid'];
      });

      print(isdaily);
    });

    await FirebaseFirestore.instance
        .collection('sellers')
        .doc(sellerUid)
        .collection('dailyUser')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        jarFrequency = value.data()!['jarFrequency'];
        print(value.data());
        print(jarFrequency);
        print('++++++++++++++++++++++++++++++++++++++++++');
      });

      print(isdaily);
    });
  }

  bool isdaily = false;
  String? sellerUid;
  int? jarFrequency;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  var b = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 1,
        ),
        backgroundColor: const Color(0xFF576CD6),
        drawer: const DrawerScreen(),
        body: isdaily
            ? CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Card(
                        margin: const EdgeInsets.all(20),
                        color: Colors.transparent,
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 8, 25, 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Icon(
                                        Icons.fire_truck,
                                        color: Colors.white,
                                        size: 60,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Daily Delivery",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            wordSpacing: 3.5,
                                            letterSpacing: 1.5,
                                            color: Colors.white,
                                            fontSize: 19),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PastEntries()),
                                              );
                                            },
                                            child: const Text(
                                              "Past Entries",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Divider(
                                  height: 5,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            b = !b;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFFE8ECFD),
                                                    Color(0xFF8898E3)
                                                  ])),
                                          width: 300,
                                          height: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Text("Balance you have"),
                                                const SizedBox(
                                                  width: 150,
                                                ),
                                                Text(jarFrequency.toString()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (b) ...[
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFFE8ECFD),
                                                    Color(0xFF8898E3)
                                                  ])),
                                          width: 300,
                                          height: 30,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                b = !b;
                                              });
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text("Cool"),
                                                  SizedBox(
                                                    width: 230,
                                                  ),
                                                  Text("1"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("dailyOrders")
                          .where('num',
                              isEqualTo: SharedPreferenceConstants
                                  .sharedPreferences!
                                  .getString(SharedPreferenceConstants.mob))
                          .snapshots(),
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? const Padding(
                                padding: EdgeInsets.all(8),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  DailyHistory model = DailyHistory.fromJson(
                                    snapshot.data!.docs[index].data()!
                                        as Map<String, dynamic>,
                                  );
                                  print(model.time);

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Colors.transparent,
                                      elevation: 1,
                                      child: ListTile(
                                        title: Text(
                                          '${model.name}',
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                        subtitle: Text(
                                          model.time
                                              .toString()
                                              .substring(0, 16),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                        // subtitle: Text('${model.waterType}'),
                                        trailing: Text(
                                          model.jarFrequency.toString(),
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white),
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                  );
                                },
                                itemCount: snapshot.data!.docs.length,
                              );
                      },
                    ),
                  ),
                ],
              )
            // ?  Center(
            //   child: Column(
            //     children: [

            //       // GridView.count(
            //       //   physics: const BouncingScrollPhysics(),
            //       //   primary: false,
            //       //   shrinkWrap: true,
            //       //   padding: const EdgeInsets.all(10),
            //       //   crossAxisSpacing: 10,
            //       //   mainAxisSpacing: 10,
            //       //   crossAxisCount: 2,
            //       //   children: [
            //       //     Container(
            //       //       decoration: BoxDecoration(
            //       //         borderRadius: BorderRadius.circular(14),
            //       //       ),
            //       //       padding: const EdgeInsets.all(8),
            //       //       child: Card(
            //       //         elevation: 1,
            //       //         color: Colors.transparent,
            //       //         child: Padding(
            //       //           padding: const EdgeInsets.all(2.0),
            //       //           child: Column(
            //       //             children: [
            //       //               const SizedBox(
            //       //                 height: 5,
            //       //               ),
            //       //               const Hero(
            //       //                 tag: 'abc',
            //       //                 child: CircleAvatar(
            //       //                   radius: 20.0,
            //       //                   backgroundColor: Colors.white,
            //       //                 ),
            //       //               ),
            //       //               const SizedBox(
            //       //                 height: 5,
            //       //               ),
            //       //               const Center(
            //       //                 child: Text(
            //       //                   "Last Month Due Amount",
            //       //                   style: TextStyle(color: Colors.white),
            //       //                 ),
            //       //               ),
            //       //               const Text(
            //       //                 "Rs.0",
            //       //                 style: TextStyle(color: Colors.white),
            //       //               ),
            //       //               const SizedBox(
            //       //                 height: 5,
            //       //               ),
            //       //               InkWell(
            //       //                 onTap: () {},
            //       //                 child: Container(
            //       //                   width: 100,
            //       //                   height: 30,
            //       //                   alignment: Alignment.center,
            //       //                   decoration: BoxDecoration(
            //       //                       borderRadius:
            //       //                           BorderRadius.circular(3),
            //       //                       gradient: const LinearGradient(
            //       //                           colors: [
            //       //                             Color(0xFF283855),
            //       //                             Color(0xFF2E3F68),
            //       //                             Color(0xFF3B5197)
            //       //                           ],
            //       //                           begin: Alignment.bottomCenter,
            //       //                           end: Alignment.topCenter)),
            //       //                   child: const Text("Custom Amount",
            //       //                       style: TextStyle(
            //       //                           fontSize: 10,
            //       //                           color: Colors.white)),
            //       //                 ),
            //       //               ),
            //       //               const SizedBox(
            //       //                 height: 5,
            //       //               ),
            //       //               InkWell(
            //       //                 onTap: () {},
            //       //                 child: Container(
            //       //                   width: 100,
            //       //                   height: 30,
            //       //                   alignment: Alignment.center,
            //       //                   decoration: BoxDecoration(
            //       //                       borderRadius:
            //       //                           BorderRadius.circular(3),
            //       //                       gradient: const LinearGradient(
            //       //                           colors: [
            //       //                             Color(0xFF283855),
            //       //                             Color(0xFF2E3F68),
            //       //                             Color(0xFF3B5197)
            //       //                           ],
            //       //                           begin: Alignment.bottomCenter,
            //       //                           end: Alignment.topCenter)),
            //       //                   child: const Text("Payment Details",
            //       //                       style: TextStyle(
            //       //                           fontSize: 10,
            //       //                           color: Colors.white)),
            //       //                 ),
            //       //               ),
            //       //             ],
            //       //           ),
            //       //         ),
            //       //       ),
            //       //     ),
            //       //     Container(
            //       //       decoration: BoxDecoration(
            //       //         borderRadius: BorderRadius.circular(14),
            //       //       ),
            //       //       padding: const EdgeInsets.all(8),
            //       //       child: const Card(
            //       //         elevation: 1,
            //       //         color: Colors.transparent,
            //       //         child: Padding(
            //       //           padding: EdgeInsets.all(2.0),
            //       //           child: Column(
            //       //             children: [
            //       //               SizedBox(
            //       //                 height: 20,
            //       //               ),
            //       //               Hero(
            //       //                 tag: 'cde',
            //       //                 child: CircleAvatar(
            //       //                   radius: 30.0,
            //       //                   backgroundColor: Colors.white,
            //       //                 ),
            //       //               ),
            //       //               SizedBox(
            //       //                 height: 10,
            //       //               ),
            //       //               Text(
            //       //                 "Bills & Ledger",
            //       //                 style: TextStyle(color: Colors.white),
            //       //               ),
            //       //             ],
            //       //           ),
            //       //         ),
            //       //       ),
            //       //     ),
            //       //     Container(
            //       //       decoration: BoxDecoration(
            //       //         borderRadius: BorderRadius.circular(14),
            //       //       ),
            //       //       padding: const EdgeInsets.all(8),
            //       //       child: const Card(
            //       //         elevation: 1,
            //       //         color: Colors.transparent,
            //       //         child: Padding(
            //       //           padding: EdgeInsets.all(2.0),
            //       //           child: Column(
            //       //             children: [
            //       //               SizedBox(
            //       //                 height: 20,
            //       //               ),
            //       //               Hero(
            //       //                 tag: 'asd',
            //       //                 child: CircleAvatar(
            //       //                   radius: 30.0,
            //       //                   backgroundColor: Colors.white,
            //       //                 ),
            //       //               ),
            //       //               SizedBox(
            //       //                 height: 10,
            //       //               ),
            //       //               Text(
            //       //                 "Set Off Days",
            //       //                 style: TextStyle(color: Colors.white),
            //       //               ),
            //       //             ],
            //       //           ),
            //       //         ),
            //       //       ),
            //       //     ),
            //       //     Container(
            //       //       decoration: BoxDecoration(
            //       //         borderRadius: BorderRadius.circular(14),
            //       //       ),
            //       //       padding: const EdgeInsets.all(8),
            //       //       child: Card(
            //       //         elevation: 1,
            //       //         color: Colors.transparent,
            //       //         child: Padding(
            //       //           padding: const EdgeInsets.all(2.0),
            //       //           child: Column(
            //       //             children: [
            //       //               const SizedBox(
            //       //                 height: 15,
            //       //               ),
            //       //               const Hero(
            //       //                 tag: 'lkj',
            //       //                 child: CircleAvatar(
            //       //                   radius: 20.0,
            //       //                   backgroundColor: Colors.white,
            //       //                 ),
            //       //               ),
            //       //               const SizedBox(
            //       //                 height: 10,
            //       //               ),
            //       //               const Center(
            //       //                 child: Text(
            //       //                   "Changes in Delivery",
            //       //                   style: TextStyle(color: Colors.white),
            //       //                 ),
            //       //               ),
            //       //               const SizedBox(
            //       //                 height: 5,
            //       //               ),
            //       //               Padding(
            //       //                 padding: const EdgeInsets.fromLTRB(
            //       //                     20, 0, 20, 0),
            //       //                 child: Container(
            //       //                   padding: const EdgeInsets.fromLTRB(
            //       //                       10, 1, 8, 1),
            //       //                   decoration: BoxDecoration(
            //       //                       border: Border.all(
            //       //                           color: Colors.white, width: 2)),
            //       //                   child: const Row(
            //       //                     children: [
            //       //                       Icon(
            //       //                         Icons.flutter_dash_rounded,
            //       //                         color: Colors.white,
            //       //                       ),
            //       //                       SizedBox(
            //       //                         width: 50,
            //       //                       ),
            //       //                       Text(
            //       //                         "0",
            //       //                         style: TextStyle(
            //       //                             color: Colors.white),
            //       //                       )
            //       //                     ],
            //       //                   ),
            //       //                 ),
            //       //               ),
            //       //               Padding(
            //       //                 padding: const EdgeInsets.fromLTRB(
            //       //                     20, 0, 20, 0),
            //       //                 child: Container(
            //       //                   padding: const EdgeInsets.fromLTRB(
            //       //                       10, 1, 8, 1),
            //       //                   decoration: BoxDecoration(
            //       //                       border: Border.all(
            //       //                           color: Colors.white, width: 2)),
            //       //                   child: const Row(
            //       //                     children: [
            //       //                       Icon(
            //       //                         Icons.flutter_dash_rounded,
            //       //                         color: Colors.white,
            //       //                       ),
            //       //                       SizedBox(
            //       //                         width: 50,
            //       //                       ),
            //       //                       Text(
            //       //                         "0",
            //       //                         style: TextStyle(
            //       //                             color: Colors.white),
            //       //                       )
            //       //                     ],
            //       //                   ),
            //       //                 ),
            //       //               )
            //       //             ],
            //       //           ),
            //       //         ),
            //       //       ),
            //       //     ),
            //       //   ],
            //       // )
            //     ],
            //   ),
            // )
            : Container(
                child: const Center(
                    child: Text(
                  'You are not registered as daily customer',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                )),
              ));
  }
}
