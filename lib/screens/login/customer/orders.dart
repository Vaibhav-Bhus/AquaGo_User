import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majorpor/constants/shared_pref.dart';
import 'package:majorpor/models/bulk_order.dart';
import 'package:majorpor/screens/login/customer/order_details.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  var info = [
    {
      "Date": "12-11-22",
      "chilledBottle": "0",
      "ChilledJar": "2",
      "NormalJar": "0",
      "NarmalBottle": "1",
      "deliveredTo": "Amruta Arcade Solapur",
      "orderId": "001",
      "paymentStatus": "Paid",
      "shopName": "Krishna Jal",
      "totalAmount": "105",
      "uid": FirebaseAuth.instance.currentUser!.uid
    },
    {
      "Date": "12-11-22",
      "chilledBottle": "0",
      "ChilledJar": "2",
      "NormalJar": "0",
      "NarmalBottle": "1",
      "deliveredTo": "Amruta Arcade Solapur",
      "orderId": "001",
      "paymentStatus": "Paid",
      "shopName": "Krishna Jal",
      "totalAmount": "105",
      "uid": FirebaseAuth.instance.currentUser!.uid
    },
    {
      "Date": "12-11-22",
      "chilledBottle": "0",
      "ChilledJar": "2",
      "NormalJar": "0",
      "NarmalBottle": "1",
      "deliveredTo": "Amruta Arcade Solapur",
      "orderId": "001",
      "paymentStatus": "Paid",
      "shopName": "Krishna Jal",
      "totalAmount": "105",
      "uid": FirebaseAuth.instance.currentUser!.uid
    },
    {
      "Date": "12-11-22",
      "chilledBottle": "0",
      "ChilledJar": "2",
      "NormalJar": "0",
      "NarmalBottle": "1",
      "deliveredTo": "Amruta Arcade Solapur",
      "orderId": "001",
      "paymentStatus": "Paid",
      "shopName": "Krishna Jal",
      "totalAmount": "105",
      "uid": FirebaseAuth.instance.currentUser!.uid
    },
    {
      "Date": "12-11-22",
      "chilledBottle": "0",
      "ChilledJar": "2",
      "NormalJar": "0",
      "NarmalBottle": "1",
      "deliveredTo": "Amruta Arcade Solapur",
      "orderId": "001",
      "paymentStatus": "Paid",
      "shopName": "Krishna Jal",
      "totalAmount": "105",
      "uid": FirebaseAuth.instance.currentUser!.uid
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
      ),
      backgroundColor: const Color(0xFF576CD6),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("bulkOrders")
                  .where('custUid',
                      isEqualTo: SharedPreferenceConstants.sharedPreferences!
                          .getString(SharedPreferenceConstants.uid))
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
                          BulkOrders model = BulkOrders.fromJson(
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>,
                          );
                          // Seller model = Seller.fromJson(
                          //   snapshot.data!.docs[index].data()!
                          //       as Map<String, dynamic>,
                          // );
                          return Card(
                            color: Colors.transparent,
                            child: ListTile(
                              // leading: CircleAvatar(
                              //   radius: 30.0,
                              //   backgroundColor: Colors.white,
                              //   backgroundImage: NetworkImage(
                              //       model.sellerAvatarUrl.toString()),
                              // ),
                              title: Text('${model.shopName}'),
                              subtitle: Text(
                                  '${model.dateToDeliver!.substring(0, 11)}'),
                              trailing: Text('${model.amt}'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (c) =>
                                            OrderDetails(passedInfo: model)));
                              },
                            ),
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
              },
            ),
          ),
        ],
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: ListView.builder(
      //       itemCount: info.length,
      //       itemBuilder: (context, index) {
      //         return Container(
      //             decoration:
      //                 BoxDecoration(borderRadius: BorderRadius.circular(14)),
      //             child: Card(
      //               color: const Color(0xFF576CD6),
      //               elevation: 5,
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: ListTile(
      //                     title: Text(info[index]["shopName"].toString()),
      //                     subtitle: Text(info[index]["Date"].toString()),
      //                     trailing: Text(info[index]["totalAmount"].toString()),
      //                     onTap: () {
      //                       Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) => OrderDetails(
      //                                   passedInfo: info[index],
      //                                 )),
      //                       );
      //                     },
      //                     // leading: const Hero(
      //                     //   tag: '',
      //                     //   child: CircleAvatar(
      //                     //     radius: 20.0,
      //                     //     backgroundColor: Colors.white,
      //                     //     // backgroundImage:
      //                     //     //     NetworkImage(info[index]["images"].toString()),
      //                     //   ),
      //                     // ),
      //                   ),
      //                 ),
      //               ),
      //             );
      //       }),
      // ),
    );
  }
}
