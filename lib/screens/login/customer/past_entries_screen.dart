import 'package:flutter/material.dart';
import 'package:majorpor/screens/login/customer/past_order_details.dart';

class PastEntries extends StatefulWidget {
  PastEntries({Key? key}) : super(key: key);

  @override
  State<PastEntries> createState() => _PastEntriesState();
}

class _PastEntriesState extends State<PastEntries> {
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
      // "uid": FirebaseAuth.instance.currentUser!.uid
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
      // "uid": FirebaseAuth.instance.currentUser!.uid
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
      // "uid": FirebaseAuth.instance.currentUser!.uid
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
      // "uid": FirebaseAuth.instance.currentUser!.uid
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
      // "uid": FirebaseAuth.instance.currentUser!.uid
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Order History"),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color(0xFF576CD6),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: info.length,
            itemBuilder: (context, index) {
              int qua = int.parse(info[index]["chilledBottle"].toString()) +
                  int.parse(info[index]["ChilledJar"].toString()) +
                  int.parse(info[index]["NarmalBottle"].toString()) +
                  int.parse(info[index]["NormalJar"].toString());
              return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(14)),
                child: Card(
                  color: Colors.transparent,
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      
                        title: Text(
                          info[index]["shopName"].toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        subtitle: Text(
                          info[index]["Date"].toString(),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        trailing: Text(
                          qua.toString(),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PastOrderDetails(
                                      passedInfo: info[index],
                                    )),
                          );
                        }),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
