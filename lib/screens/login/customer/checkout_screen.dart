import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:majorpor/constants/shared_pref.dart';
import 'package:majorpor/screens/login/customer/address_screen.dart';
import 'package:majorpor/screens/login/customer/home_screen.dart';
import 'package:majorpor/screens/login/customer/order_status%20screen.dart';
import 'package:majorpor/widgets/custom_toast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:majorpor/razorpay/razor_key.dart' as razor;
import 'package:majorpor/widgets/controllers.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CheckoutScreen extends StatefulWidget {
  final floorNo;
  final address;

  const CheckoutScreen({super.key, this.floorNo, this.address});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var chilledJar = Quantity.chilledJar;
  var chilledBottle = Quantity.chilledBottle;
  var normaljar = Quantity.normalJar;
  var normalBottle = Quantity.normalBottle;
  var chilledJarRate = 0;
  var chilledBottleRate = 0;
  var normaljarRate = 0;
  var normalBottleRate = 0;
  var total = 0;
  var _onSelectionChanged;
  TextEditingController _date = TextEditingController();
  String payment = '';

  int value = 0;
  DateTime currentDate = DateTime.now();

  final _razorpay = Razorpay();

  var cfPaymentGatewayService = CFPaymentGatewayService();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    });

    cfPaymentGatewayService.setCallback(verifyPayment, onError, receivedEvent);
    getStoreData();

    super.initState();
  }

  getStoreData() async {
    var ui = SharedPreferenceConstants.sharedPreferences!
        .getString(SharedPreferenceConstants.selleruid);
    var res = await FirebaseFirestore.instance
        .collection("sellers")
        .doc(ui)
        .collection('JarRates')
        .doc('JarRates')
        .get();
    // print();
    setState(() {
      chilledJarRate = int.parse(res.data()!['chilledJarRate']);
      chilledBottleRate = int.parse(res.data()!['chilledBottleRate']);
      normaljarRate = int.parse(res.data()!['normalJarRate']);
      normalBottleRate = int.parse(res.data()!['normalBottleRate']);
    });

    // .then((value) {
    // print(value.data());

    // value.docs.isEmpty
    //     ? Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => const EntryTimeDetails()))
    //     : Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => const HomeScreen()));
    // });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    //print(response);
    verifySignature(
      signature: response.signature,
      paymentId: response.paymentId,
      orderId: response.orderId,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // print(response);
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message ?? ''),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    //print(response);
    // Do something when an external wallet is selected
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.walletName ?? ''),
      ),
    );
  }

// create order
  void createOrder() async {
    String username = razor.keyId;
    String password = razor.keySecret;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    Map<String, dynamic> body = {
      "amount": 100,
      "currency": "INR",
      "receipt": "rcptid_11"
    };
    var res = await http.post(
      Uri.https(
          "api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization': basicAuth,
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 200) {
      openGateway(jsonDecode(res.body)['id']);
    }
    //print(res.body);
  }

  openGateway(String orderId) {
    var options = {
      'key': razor.keyId,
      'amount': 100, //in the smallest currency sub-unit.
      'name': 'Aqua Go',
      'order_id': orderId, // Generate order_id using Orders API
      'description': 'Jar/Bottles',
      'timeout': 60 * 5, // in seconds // 5 minutes
      'prefill': {
        'contact': '7719874955',
        'email': 'vaibhavbhus01@gmail.com',
      }
    };
    _razorpay.open(options);
  }

  verifySignature({
    String? signature,
    String? paymentId,
    String? orderId,
  }) async {
    Map<String, dynamic> body = {
      'razorpay_signature': signature,
      'razorpay_payment_id': paymentId,
      'razorpay_order_id': orderId,
    };

    var parts = [];
    body.forEach((key, value) {
      parts.add('${Uri.encodeQueryComponent(key)}='
          '${Uri.encodeQueryComponent(value)}');
    });
    var formData = parts.join('&');
    var res = await http.post(
      Uri.https(
        "192.168.1.2", // my ip address , localhost
        "razorpay_signature_verify.php",
      ),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded", // urlencoded
      },
      body: formData,
    );

    if (res.statusCode == 200) {
      customToast(res.body);
    }
  }

  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners

    super.dispose();
  }

  // String? _selectedTime;
  // Future<void> _show() async {
  //   final TimeOfDay? result =
  //       await showTimePicker(context: context, initialTime: TimeOfDay.now());
  //   if (result != null) {
  //     setState(() {
  //       _selectedTime = result.format(context);
  //     });
  //   }
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    print(currentDate);
  }

  List slotList = ['9 to 12', '12 to 3', '3 to 6', '6 to 9'];
  String? slots;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF576CD6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Checkout",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 2.5,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(SharedPreferenceConstants.sharedPreferences!
                  .getString(SharedPreferenceConstants.name)
                  .toString()),
            ),
            // ElevatedButton(
            //     onPressed: _show, child: const Text('Show Time Picker')),
            normaljar > 0
                ? Row(
                    children: [
                      Container(
                        height: 50,
                        width: 280,
                        child: ListTile(
                          title: Text("Normal Jar"),
                          subtitle: Text(normaljarRate.toString()),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14)),
                            child: Card(
                              color: Colors.indigo[900],
                              elevation: 5,
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (normaljar > 0) {
                                          setState(() {
                                            normaljar--;
                                          });
                                        }
                                      },
                                      child: const Icon(Icons.remove)),
                                  Text("$normaljar"),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        normaljar++;
                                      });
                                    },
                                    child: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text((normaljar * normaljarRate).toString()),
                        ],
                      )
                    ],
                  )
                : const SizedBox(),
            normalBottle > 0
                ? Row(
                    children: [
                      Container(
                        height: 50,
                        width: 280,
                        child: ListTile(
                          title: Text("Normal Bottle"),
                          subtitle: Text(normalBottleRate.toString()),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14)),
                            child: Card(
                              color: Colors.indigo[900],
                              elevation: 5,
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (normalBottle > 0) {
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text((normalBottle * normalBottleRate).toString()),
                        ],
                      )
                    ],
                  )
                : const SizedBox(),
            chilledJar > 0
                ? Row(
                    children: [
                      Container(
                        height: 50,
                        width: 280,
                        child: ListTile(
                          title: Text("Chilled Jar"),
                          subtitle: Text(chilledJarRate.toString()),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14)),
                            child: Card(
                              color: Colors.indigo[900],
                              elevation: 5,
                              child: Row(
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text((chilledJar * chilledJarRate).toString()),
                        ],
                      )
                    ],
                  )
                : const SizedBox(),
            chilledBottle > 0
                ? Row(
                    children: [
                      Container(
                        height: 50,
                        width: 280,
                        child: ListTile(
                          title: Text("Chilled Bottle"),
                          subtitle: Text(chilledBottleRate.toString()),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14)),
                            child: Card(
                              color: Colors.indigo[900],
                              elevation: 5,
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        if (chilledBottle > 0) {
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text((chilledBottle * chilledBottleRate).toString()),
                        ],
                      )
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Card(
                elevation: 4,
                color: Color.fromARGB(255, 68, 91, 209),
                child: Column(
                  children: [
                    ListTile(
                      visualDensity: const VisualDensity(vertical: -4),
                      title: const Text("Item Total"),
                      trailing: Text(((chilledJar * chilledJarRate) +
                              (chilledBottle * chilledBottleRate) +
                              (normalBottle * normalBottleRate) +
                              (normaljar * normaljarRate))
                          .toString()),
                    ),
                    ListTile(
                      visualDensity: const VisualDensity(vertical: -4),
                      title: const Text("Charges"),
                      trailing:
                          Text((5 * int.parse(widget.floorNo)).toString()),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Divider(
                        color: Colors.white,
                        height: 10,
                      ),
                    ),
                    ListTile(
                      visualDensity: const VisualDensity(vertical: -4),
                      title: const Text("Grand Total"),
                      trailing: Text(((5 * int.parse(widget.floorNo)) +
                              (((chilledJar * chilledJarRate) +
                                  (chilledBottle * chilledBottleRate) +
                                  (normalBottle * normalBottleRate) +
                                  (normaljar * normaljarRate))))
                          .toString()),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 25,
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
                  child: InkWell(
                    onTap: (() {
                      _selectDate(context);
                    }),
                    child: Text(currentDate == null
                        ? 'Select Date'
                        : '${currentDate.day}/${currentDate.month}/${currentDate.year}'),
                  ),
                ),
                // Text(
                //     ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 25,
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
                  child: DropdownButton(
                    underline: SizedBox(),
                    value: slots,
                    isExpanded: true,
                    elevation: 8,
                    style: TextStyle(fontSize: 15),
                    hint: Text(
                      "9 AM - 12 PM",
                      style: TextStyle(
                          color: Color.fromARGB(255, 165, 160, 160),
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ), // Not necessary for Option 1
                    onChanged: (newValue) {
                      setState(() {
                        slots = newValue;
                      });
                    },
                    items: slotList.map((value) {
                      return DropdownMenuItem<String>(
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                        value: value,
                      );
                    }).toList(),
                    icon: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 32,
                    ),
                  ),
                ),
                // Text(slots ?? slotList[0]),
              ],
            ),
            Container(
              margin: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Card(
                elevation: 4,
                color: Color.fromARGB(255, 68, 91, 209),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: ListTile(
                    visualDensity: VisualDensity(vertical: -4),
                    title: Text("Delivery at Address"),
                    trailing: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddressScreen()),
                        );
                      },
                      child: Container(
                        width: 100,
                        height: 25,
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
                        child: Text("Change",
                            style: const TextStyle(
                                fontSize: 15, color: Colors.white)),
                      ),
                    ),
                    horizontalTitleGap: 0,
                    subtitle: Text(widget.address),
                    leading: SizedBox(
                      width: 5,
                      child: Icon(
                        size: 20,
                        Icons.location_on,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                pay();
                // pay();
                // createOrder();
              },
              child: Center(
                child: Container(
                  width: 276,
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
                  child: Text("Pay Online",
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                await getOrderId();
                payment = 'Cash On Delivery';
                await storeDetails();
              },
              child: Center(
                child: Container(
                  width: 276,
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
                  child: const Text("Pay On Delivery",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }

  void verifyPayment(String orderId) async {
    payment = 'paid';
    print(payment);

    await storeDetails();
    print("Verify Payment");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false);
  }

  void onError(CFErrorResponse errorResponse, String orderId) {
    print(errorResponse.getMessage());
    print("Error while making payment");
  }

  void receivedEvent(String event_name, Map<dynamic, dynamic> meta_data) {
    print(event_name);
    print(meta_data);
  }

  int orderId = 0;
  getOrderId() async {
    await FirebaseFirestore.instance.collection("orderID").get().then((value) {
      orderId = value.docs.first['orderID'];
    });
    await FirebaseFirestore.instance
        .collection("orderID")
        .doc('orderID')
        .update({'orderID': orderId + 1});
    print('update');
  }

  storeDetails() async {
    print('start');
    await FirebaseFirestore.instance.collection('bulkOrders').add({
      'timeToDeliver': slots ?? slotList[0],
      'dateToDeliver': currentDate.toString(),
      'storeUid': SharedPreferenceConstants.sharedPreferences!
          .getString(SharedPreferenceConstants.selleruid),
      'custUid': SharedPreferenceConstants.sharedPreferences!
          .getString(SharedPreferenceConstants.uid),
      'orderId': orderId + 1,
      'orderStatus': 'Pending',
      'paymentStatus': payment,
      'chilledJar': chilledJar,
      'normalJar': normaljar,
      'normalBottle': normalBottle,
      'chilledBottle': chilledBottle,
      'amt': amt,
      'floor': widget.floorNo,
      'address': widget.address,
      'shopName': SharedPreferenceConstants.sharedPreferences!
          .getString(SharedPreferenceConstants.name)
    });
    print('add');
  }

  double amt = 0;

  String paymentSessionId = "";
  String tokenData = '';
  CFEnvironment environment = CFEnvironment.SANDBOX;

  getPaymentSessionId() async {
    int abc = ((5 * int.parse(widget.floorNo)) +
        (((chilledJar * chilledJarRate) +
            (chilledBottle * chilledBottleRate) +
            (normalBottle * normalBottleRate) +
            (normaljar * normaljarRate))));
    amt = abc.toDouble();
    try {
      var res = await http.post(Uri.https("sandbox.cashfree.com", "/pg/orders"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-client-id': 'TEST376896c8285edc3bc2c6451572698673',
            'x-client-secret': 'TEST4099acc844b5b8841116c9793d4c3ab67763ab98',
            'x-api-version': '2022-09-01'
          },
          body: jsonEncode({
            "order_amount": amt,
            "order_id": "$orderId",
            "order_currency": 'INR',
            "customer_details": {
              "customer_id":
                  '${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.uid)}',
              "customer_name":
                  '${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.fname)} ${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.lname)}',
              "customer_email":
                  "${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.mail)}",
              "customer_phone":
                  "${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.mob)}"
            },
            "order_note": "some order note here",
          }));
      print(res.body);
      var jsonResponse = jsonDecode(res.body);
      print(jsonResponse);
      paymentSessionId = jsonResponse['payment_session_id'];

      // print('doneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');

      // print('hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    } catch (e) {
      customToast('Something went wrong. Please try again ');
      print(e.toString());
    }
  }

  CFSession? createSession() {
    try {
      var session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId('$orderId')
          .setOrderToken(tokenData)
          .setPaymentSessionId(paymentSessionId)
          .build();
      return session;
    } on CFException catch (e) {
      customToast('Something went wrong. Please try again ');

      print(e.message);
    }
    return null;
  }

  pay() async {
    await getOrderId();
    await getPaymentSessionId();
    await getAccessToken();
    try {
      var session = createSession();
      List<CFPaymentModes> components = <CFPaymentModes>[];
      var paymentComponent =
          CFPaymentComponentBuilder().setComponents(components).build();

      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#FF0000")
          .setPrimaryFont("Menlo")
          .setSecondaryFont("Futura")
          .build();

      var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
          .setSession(session!)
          .setPaymentComponent(paymentComponent)
          .setTheme(theme)
          .build();

      cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
      flag = true;
    } on CFException catch (e) {
      customToast('Something went wrong. Please try again ');

      print(e.message);
    }
  }

  var flag = false;

  // void cashFreePayment() {
  //   getAccessToken(1, 1001).then((tokenData) {
  //     print(tokenData);
  //     print('+++++++++++++++++++++');
  //     Map<String, String> _param = {
  //       'stage': 'TEST',
  //       'orderAmount': '1',
  //       'orderId': '1001',
  //       'orderCurrency': 'INR',
  //       'customerName': 'Vaibhav Bhus',
  //       'customerPhone': '7719874955',
  //       'customerEmail': 'vaibhavbhus01@gmail.com',
  //       'tokenData': tokenData,
  //       'appId': 'TEST376896c8285edc3bc2c6451572698673'
  //     };
  //     // cfPaymentGatewayService.doPayment(_param)
  //   });
  // }

  getAccessToken() async {
    try {
      var res = await http.post(
          Uri.https("test.cashfree.com", "api/v2/cftoken/order"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-client-id': 'TEST376896c8285edc3bc2c6451572698673',
            'x-client-secret': 'TEST4099acc844b5b8841116c9793d4c3ab67763ab98'
          },
          body: jsonEncode({
            "orderAmount": 1.00,
            "orderId": "$orderId",
            "orderCurrency": 'INR',
            "customerName": "Vaibhav Bhus",
            "customerEmail": "vaibhavbhus01@gmail.com",
            "customerPhone": "7719874955",
            "notifyUrl": "https://test.cashfree.com",
            "orderNote": "some order note here",
          }));
      print(res.body);
      if (res.statusCode == 200) {
        var jsonResponse = jsonDecode(res.body);
        if (jsonResponse['status'] == 'OK') {
          tokenData = jsonResponse['cftoken'];
        }
      }
    } catch (e) {
      customToast('Something went wrong. Please try again ');

      print(e.toString());
    }
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
