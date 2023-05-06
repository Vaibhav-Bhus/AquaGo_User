import 'package:flutter/material.dart';
import 'package:majorpor/constants/shared_pref.dart';
import 'package:majorpor/screens/login/customer/home_screen.dart';
import 'package:majorpor/screens/login/customer/address_screen.dart';
import 'package:majorpor/widgets/controllers.dart';

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
    // var screenheight = MediaQuery.of(context).size.height;

    List<String> itemsAvailable = [
      "Normal Jar",
      "Chilled Jar",
      "Normal Bottle",
      "Chilled Bottle",
    ];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 97, 112, 186),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.passedInfo.sellerAvatarUrl,
                  child: Image(
                    height: 360,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    image: NetworkImage(widget.passedInfo.sellerAvatarUrl),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 40, left: 10),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                widget.passedInfo.sellerName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                        color: const Color(0xFF576CD6),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            trailing: Container(
                              height: 25,
                              width: 90,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (chilledJar > 0) {
                                          setState(() {
                                            chilledJar--;
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.remove)),
                                  Text("$chilledJar"),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        chilledJar++;
                                      });
                                    },
                                    child: const Icon(Icons.add),
                                  )
                                ],
                              ),
                            ),
                            title: const Text("Chilled Jar"),
                            leading: const CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  "https://media1.s-nbcnews.com/i/newscms/2019_21/2870431/190524-classic-american-cheeseburger-ew-207p_d9270c5c545b30ea094084c7f2342eb4.jpg"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14)),
                      child: Card(
                        color: const Color(0xFF576CD6),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            trailing: Container(
                              height: 25,
                              width: 90,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (chilledJar > 0) {
                                          setState(() {
                                            normalJar--;
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.remove)),
                                  Text("$normalJar"),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        normalJar++;
                                      });
                                    },
                                    child: const Icon(Icons.add),
                                  )
                                ],
                              ),
                            ),
                            title: const Text("Normal Jar"),
                            leading: const CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  "https://media1.s-nbcnews.com/i/newscms/2019_21/2870431/190524-classic-american-cheeseburger-ew-207p_d9270c5c545b30ea094084c7f2342eb4.jpg"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14)),
                      child: Card(
                        color: const Color(0xFF576CD6),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            trailing: Container(
                              height: 25,
                              width: 90,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (chilledJar > 0) {
                                          setState(() {
                                            chilledBottle--;
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.remove)),
                                  Text("$chilledBottle"),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        chilledBottle++;
                                      });
                                    },
                                    child: const Icon(Icons.add),
                                  )
                                ],
                              ),
                            ),
                            title: const Text("Chilled Bottle"),
                            leading: const CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  "https://media1.s-nbcnews.com/i/newscms/2019_21/2870431/190524-classic-american-cheeseburger-ew-207p_d9270c5c545b30ea094084c7f2342eb4.jpg"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14)),
                      child: Card(
                        color: const Color(0xFF576CD6),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            trailing: Container(
                              height: 25,
                              width: 90,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (chilledJar > 0) {
                                          setState(() {
                                            normalBottle--;
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.remove)),
                                  Text("$normalBottle"),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        normalBottle++;
                                      });
                                    },
                                    child: const Icon(Icons.add),
                                  )
                                ],
                              ),
                            ),
                            title: const Text("Normal Bottle"),
                            leading: const CircleAvatar(
                              radius: 30.0,
                              backgroundImage: NetworkImage(
                                  "https://media1.s-nbcnews.com/i/newscms/2019_21/2870431/190524-classic-american-cheeseburger-ew-207p_d9270c5c545b30ea094084c7f2342eb4.jpg"),
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
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
