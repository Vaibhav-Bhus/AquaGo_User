import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:majorpor/models/seller_details.dart';
import 'package:majorpor/screens/login/customer/details.dart';
import 'package:majorpor/screens/login/customer/drawer.dart';

class ShopList extends StatefulWidget {
  const ShopList({super.key});

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  var info = [
    {
      "id": "1",
      "name": "Restaurant 1",
      "images": "https://images.freekaamaal.com/post_images/1606817930.jpg",
      "decs":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc risus lectus, feugiat sit amet nulla vitae, imperdiet pulvinar nunc. Maecenas laoreet ex ac lacus efficitur, ut tincidunt ante eleifend. Etiam luctus tortor in turpis aliquam, non feugiat magna feugiat. Sed lacinia felis nec commodo posuere. In eleifend justo eu sapien accumsan, ut tempus tellus semper. Cras fermentum, erat sed condimentum rhoncus, quam nisi imperdiet velit, quis suscipit lorem erat ut ex. Duis fringilla erat ut velit viverra, sed fringilla nisl aliquet. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      "items": [
        "Normal Jar",
        "Chilled Jar",
        "Normal Bottle",
        "Chilled Bottle",
      ]
    },
    {
      "id": "2",
      "name": "Restaurant 2",
      "images":
          "https://img.etimg.com/thumb/msid-75176755,width-640,resizemode-4,imgsize-612672/effect-of-coronavirus-on-food.jpg",
      "decs":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc risus lectus, feugiat sit amet nulla vitae, imperdiet pulvinar nunc. Maecenas laoreet ex ac lacus efficitur, ut tincidunt ante eleifend. Etiam luctus tortor in turpis aliquam, non feugiat magna feugiat. Sed lacinia felis nec commodo posuere. In eleifend justo eu sapien accumsan, ut tempus tellus semper. Cras fermentum, erat sed condimentum rhoncus, quam nisi imperdiet velit, quis suscipit lorem erat ut ex. Duis fringilla erat ut velit viverra, sed fringilla nisl aliquet. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      "items": [
        "Normal Jar",
        "Chilled Jar",
        "Normal Bottle",
        "Chilled Bottle",
      ]
    },
    {
      "id": "3",
      "name": "Restaurant 3",
      "images":
          "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mjl8fHxlbnwwfHx8&w=1000&q=80",
      "decs":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc risus lectus, feugiat sit amet nulla vitae, imperdiet pulvinar nunc. Maecenas laoreet ex ac lacus efficitur, ut tincidunt ante eleifend. Etiam luctus tortor in turpis aliquam, non feugiat magna feugiat. Sed lacinia felis nec commodo posuere. In eleifend justo eu sapien accumsan, ut tempus tellus semper. Cras fermentum, erat sed condimentum rhoncus, quam nisi imperdiet velit, quis suscipit lorem erat ut ex. Duis fringilla erat ut velit viverra, sed fringilla nisl aliquet. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      "items": [
        "Normal Jar",
        "Chilled Jar",
        "Normal Bottle",
        "Chilled Bottle",
      ]
    },
    {
      "id": "4",
      "name": "Restaurant 4",
      "images":
          "https://c.ndtvimg.com/2020-04/dih4ifhg_pasta_625x300_22_April_20.jpg",
      "decs":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc risus lectus, feugiat sit amet nulla vitae, imperdiet pulvinar nunc. Maecenas laoreet ex ac lacus efficitur, ut tincidunt ante eleifend. Etiam luctus tortor in turpis aliquam, non feugiat magna feugiat. Sed lacinia felis nec commodo posuere. In eleifend justo eu sapien accumsan, ut tempus tellus semper. Cras fermentum, erat sed condimentum rhoncus, quam nisi imperdiet velit, quis suscipit lorem erat ut ex. Duis fringilla erat ut velit viverra, sed fringilla nisl aliquet. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      "items": [
        "Normal Jar",
        "Chilled Jar",
        "Normal Bottle",
        "Chilled Bottle",
      ]
    },
    {
      "id": "5",
      "name": "Restaurant 5",
      "images":
          "https://i1.wp.com/www.eatthis.com/wp-content/uploads/2019/09/spaghetti-meatballs.jpg?fit=1200%2C879&ssl=1",
      "decs":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc risus lectus, feugiat sit amet nulla vitae, imperdiet pulvinar nunc. Maecenas laoreet ex ac lacus efficitur, ut tincidunt ante eleifend. Etiam luctus tortor in turpis aliquam, non feugiat magna feugiat. Sed lacinia felis nec commodo posuere. In eleifend justo eu sapien accumsan, ut tempus tellus semper. Cras fermentum, erat sed condimentum rhoncus, quam nisi imperdiet velit, quis suscipit lorem erat ut ex. Duis fringilla erat ut velit viverra, sed fringilla nisl aliquet. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      "items": [
        "Normal Jar",
        "Chilled Jar",
        "Normal Bottle",
        "Chilled Bottle",
      ]
    },
    {
      "id": "6",
      "name": "Restaurant 6",
      "images":
          "https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/quizzes/fast_food_smarts_rmq/650x350_fast_food_smarts_rmq.jpg?resize=692px:*",
      "decs":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc risus lectus, feugiat sit amet nulla vitae, imperdiet pulvinar nunc. Maecenas laoreet ex ac lacus efficitur, ut tincidunt ante eleifend. Etiam luctus tortor in turpis aliquam, non feugiat magna feugiat. Sed lacinia felis nec commodo posuere. In eleifend justo eu sapien accumsan, ut tempus tellus semper. Cras fermentum, erat sed condimentum rhoncus, quam nisi imperdiet velit, quis suscipit lorem erat ut ex. Duis fringilla erat ut velit viverra, sed fringilla nisl aliquet. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      "items": [
        "Normal Jar",
        "Chilled Jar",
        "Normal Bottle",
        "Chilled Bottle",
      ]
    },
    {
      "id": "7",
      "name": "Restaurant 7",
      "images":
          "https://images.everydayhealth.com/images/healthy-foods-that-are-great-sources-of-iron-03-1440x810.jpg",
      "decs":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc risus lectus, feugiat sit amet nulla vitae, imperdiet pulvinar nunc. Maecenas laoreet ex ac lacus efficitur, ut tincidunt ante eleifend. Etiam luctus tortor in turpis aliquam, non feugiat magna feugiat. Sed lacinia felis nec commodo posuere. In eleifend justo eu sapien accumsan, ut tempus tellus semper. Cras fermentum, erat sed condimentum rhoncus, quam nisi imperdiet velit, quis suscipit lorem erat ut ex. Duis fringilla erat ut velit viverra, sed fringilla nisl aliquet. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      "items": [
        "Normal Jar",
        "Chilled Jar",
        "Normal Bottle",
        "Chilled Bottle",
      ]
    },
    {
      "id": "8",
      "name": "Restaurant 8",
      "images":
          "https://www.indianhealthyrecipes.com/wp-content/uploads/2020/07/dosa-recipe-500x500.jpg",
      "decs":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc risus lectus, feugiat sit amet nulla vitae, imperdiet pulvinar nunc. Maecenas laoreet ex ac lacus efficitur, ut tincidunt ante eleifend. Etiam luctus tortor in turpis aliquam, non feugiat magna feugiat. Sed lacinia felis nec commodo posuere. In eleifend justo eu sapien accumsan, ut tempus tellus semper. Cras fermentum, erat sed condimentum rhoncus, quam nisi imperdiet velit, quis suscipit lorem erat ut ex. Duis fringilla erat ut velit viverra, sed fringilla nisl aliquet. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
      "items": [
        "Normal Jar",
        "Chilled Jar",
        "Normal Bottle",
        "Chilled Bottle",
      ]
    }
  ];

  // fun() async {

  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fun();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.transparent,
      ),
      drawer: const DrawerScreen(),
      backgroundColor: Color(0xFF576CD6),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("sellers").snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Padding(
                        padding: EdgeInsets.all(8),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(16),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Seller model = Seller.fromJson(
                            snapshot.data!.docs[index].data()!
                                as Map<String, dynamic>,
                          );
                          print(snapshot.data!.docs.length);
                          // print(snapshot.data!.docs[1]);
                          // print(snapshot.data!.docs[2]);

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 1,
                              child: ListTile(
                                contentPadding: EdgeInsets.all(8),
                                leading: CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      model.sellerAvatarUrl.toString()),
                                ),
                                // tileColor: Colors.transparent,
                                title: Text(
                                  '${model.sellerName}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                subtitle: Text(
                                  '${model.waterType}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) =>
                                              DetailsPage(passedInfo: model)));
                                },
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
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: ListView.builder(
      //       itemCount: info.length,
      //       itemBuilder: (context, index) {
      //         return Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: ListTile(
      //             title: Text(info[index]["name"].toString()),
      //             onTap: () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                   builder: (context) => DetailsPage(
      //                     passedInfo: info[index],
      //                   ),
      //                 ),
      //               );
      //             },
      //             leading: Hero(
      //               tag: info[index]["images"]!,
      //               child: const CircleAvatar(
      //                 radius: 30.0,
      //                 backgroundColor: Colors.white,
      //                 // backgroundImage:
      //                 //     NetworkImage(info[index]["images"].toString()),
      //               ),
      //             ),
      //           ),
      //         );
      //       }),
      // ),
    );
  }
}
