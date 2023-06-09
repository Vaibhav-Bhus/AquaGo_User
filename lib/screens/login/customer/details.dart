import 'package:flutter/material.dart';
import 'package:majorpor/constants/shared_pref.dart';
import 'package:majorpor/screens/login/customer/address_screen.dart';
import 'package:majorpor/widgets/controllers.dart';
import 'package:majorpor/widgets/custom_toast.dart';

class DetailsPage extends StatefulWidget {
  final passedInfo;
  // var screenwidth;
  const DetailsPage({super.key, this.passedInfo});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.passedInfo.sellerUID);
  }

  int chilledJar = 0;
  int chilledBottle = 0;
  int normalJar = 0;
  int normalBottle = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xFF576CD6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 20, 4, 16),
          child: Column(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: widget.passedInfo.sellerAvatarUrl,
                    child: Image(
                      width: 250,
                      height: 200,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                      image: NetworkImage(widget.passedInfo.sellerAvatarUrl),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  widget.passedInfo.sellerName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14)),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              trailing: Container(
                                height: 40,
                                width: 102,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          if (chilledJar > 0) {
                                            setState(() {
                                              chilledJar--;
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          size: 30,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "$chilledJar",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          chilledJar++;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ),
                              title: const Text(
                                "Chilled Jar",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              leading: const CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    AssetImage('assets/images/jar.jpg'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14)),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              trailing: Container(
                                height: 40,
                                width: 102,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          if (normalJar > 0) {
                                            setState(() {
                                              normalJar--;
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          size: 30,
                                          color: Colors.white,
                                        )),
                                    Text(
                                      "$normalJar",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          normalJar++;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              title: const Text(
                                "Normal Jar",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              leading: const CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage:
                                      AssetImage('assets/images/jar.jpg')),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14)),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              trailing: Container(
                                height: 40,
                                width: 102,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          if (chilledBottle > 0) {
                                            setState(() {
                                              chilledBottle--;
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          size: 30,
                                          color: Colors.white,
                                        )),
                                    Text(
                                      "$chilledBottle",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          chilledBottle++;
                                        });
                                      },
                                      child: const Icon(Icons.add,
                                          size: 30, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              title: const Text(
                                "Chilled Bottle",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              leading: const CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage:
                                      AssetImage('assets/images/bottle.png')),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14)),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListTile(
                              trailing: Container(
                                height: 40,
                                width: 102,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          if (normalBottle > 0) {
                                            setState(() {
                                              normalBottle--;
                                            });
                                          }
                                        },
                                        child: const Icon(Icons.remove,
                                            size: 30, color: Colors.white)),
                                    Text(
                                      "$normalBottle",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          normalBottle++;
                                        });
                                      },
                                      child: const Icon(Icons.add,
                                          size: 30, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              title: const Text(
                                "Normal Bottle",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              leading: const CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                    AssetImage('assets/images/bottle.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (normalBottle > 0 ||
                      normalJar > 0 ||
                      chilledBottle > 0 ||
                      chilledJar > 0) {
                    Quantity.chilledBottle = chilledBottle;
                    Quantity.chilledJar = chilledJar;
                    Quantity.normalBottle = normalBottle;
                    Quantity.normalJar = normalJar;
                    SharedPreferenceConstants.sharedPreferences!.setString(
                        SharedPreferenceConstants.name,
                        widget.passedInfo.sellerName);
                    SharedPreferenceConstants.sharedPreferences!.setString(
                        SharedPreferenceConstants.selleruid,
                        widget.passedInfo.sellerUID);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddressScreen()),
                    );
                  } else {
                    customToast('Select quantity first.');
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
                  child: const Text("Place Order",
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
