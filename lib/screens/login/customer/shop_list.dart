import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:majorpor/constants/shared_pref.dart';
import 'package:majorpor/models/seller_details.dart';
import 'package:majorpor/screens/login/customer/details.dart';
import 'package:majorpor/screens/login/customer/drawer.dart';

class ShopList extends StatefulWidget {
  const ShopList({super.key});

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  TextEditingController quantityController = TextEditingController();

  String name =
      '${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.fname)} ${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.lname)}';
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 0), (Timer t) {
      setState(() {
        name =
            '${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.fname)} ${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.lname)}';
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(name),
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
                'Mobile Number',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('sellers')
                    .where('isRatesFilled', isEqualTo: 'true')
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
                                Seller model = Seller.fromJson(
                                  snapshot.data!.docs[index].data()!
                                      as Map<String, dynamic>,
                                );
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    color: Colors.transparent,
                                    elevation: 1,
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(8),
                                      leading: CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                            model.sellerAvatarUrl.toString()),
                                      ),
                                      tileColor: Colors.transparent,
                                      title: Text(
                                        '${model.sellerName}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      trailing: Text(
                                        '${model.phone}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        '${model.waterType}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (c) => DetailsPage(
                                                    passedInfo: model)));
                                      },
                                    ),
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
