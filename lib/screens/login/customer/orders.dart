import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:majorpor/constants/shared_pref.dart';
import 'package:majorpor/models/bulk_order.dart';
import 'package:majorpor/screens/login/customer/drawer.dart';
import 'package:majorpor/screens/login/customer/order_details.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.transparent,
        title: const Text("Order History"),
      ),
      drawer: const DrawerScreen(),
      backgroundColor: const Color(0xFF576CD6),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const ListTile(
              title: Text(
                'Store Name',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              trailing: Text(
                'Order value',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("bulkOrders")
                    .where('custUid',
                        isEqualTo: SharedPreferenceConstants.sharedPreferences!
                            .getString(SharedPreferenceConstants.uid))
                    .orderBy('orderId', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? const Padding(padding: EdgeInsets.all(8))
                      : Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: ((context, index) {
                                BulkOrders model = BulkOrders.fromJson(
                                  snapshot.data!.docs[index].data()!
                                      as Map<String, dynamic>,
                                );
                                return Card(
                                  color: Colors.transparent,
                                  child: ListTile(
                                    // ),
                                    title: Text(
                                      '${model.shopName}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),

                                    trailing: Text(
                                      '${model.amt}',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (c) => OrderDetails(
                                                  passedInfo: model)));
                                    },
                                  ),
                                );
                              })),
                        );
                })
          ],
        ),
      )),
    );
  }
}
