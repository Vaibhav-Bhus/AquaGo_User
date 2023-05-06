// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:majorpor/widgets/custom_toast.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:majorpor/razorpay/razor_key.dart' as razor;

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({Key? key}) : super(key: key);

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   final _razorpay = Razorpay();

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//       _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//       _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//     });
//     super.initState();
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // Do something when payment succeeds
//     //print(response);
//     verifySignature(
//       signature: response.signature,
//       paymentId: response.paymentId,
//       orderId: response.orderId,
//     );
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     // print(response);
//     // Do something when payment fails
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(response.message ?? ''),
//       ),
//     );
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     //print(response);
//     // Do something when an external wallet is selected
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(response.walletName ?? ''),
//       ),
//     );
//   }

// // create order
//   void createOrder() async {
//     String username = razor.keyId;
//     String password = razor.keySecret;
//     String basicAuth =
//         'Basic ${base64Encode(utf8.encode('$username:$password'))}';

//     Map<String, dynamic> body = {
//       "amount": 100,
//       "currency": "INR",
//       "receipt": "rcptid_11"
//     };
//     var res = await http.post(
//       Uri.https(
//           "api.razorpay.com", "v1/orders"), //https://api.razorpay.com/v1/orders
//       headers: <String, String>{
//         "Content-Type": "application/json",
//         'authorization': basicAuth,
//       },
//       body: jsonEncode(body),
//     );

//     if (res.statusCode == 200) {
//       openGateway(jsonDecode(res.body)['id']);
//     }
//     //print(res.body);
//   }

//   openGateway(String orderId) {
//     var options = {
//       'key': razor.keyId,
//       'amount': 100, //in the smallest currency sub-unit.
//       'name': 'Aqua Go',
//       'order_id': orderId, // Generate order_id using Orders API
//       'description': 'Jar/Bottles',
//       'timeout': 60 * 5, // in seconds // 5 minutes
//       'prefill': {
//         'contact': '7719874955',
//         'email': 'vaibhavbhus01@gmail.com',
//       }
//     };
//     _razorpay.open(options);
//   }

//   verifySignature({
//     String? signature,
//     String? paymentId,
//     String? orderId,
//   }) async {
//     Map<String, dynamic> body = {
//       'razorpay_signature': signature,
//       'razorpay_payment_id': paymentId,
//       'razorpay_order_id': orderId,
//     };

//     var parts = [];
//     body.forEach((key, value) {
//       parts.add('${Uri.encodeQueryComponent(key)}='
//           '${Uri.encodeQueryComponent(value)}');
//     });
//     var formData = parts.join('&');
//     var res = await http.post(
//       Uri.https(
//         "192.168.1.2", // my ip address , localhost
//         "razorpay_signature_verify.php",
//       ),
//       headers: {
//         "Content-Type": "application/x-www-form-urlencoded", // urlencoded
//       },
//       body: formData,
//     );

//     if (res.statusCode == 200) {
//       customToast(res.body);
//     }
//   }

//   @override
//   void dispose() {
//     _razorpay.clear(); // Removes all listeners

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF576CD6),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: const Text("Payment Screen"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 createOrder();
//               },
//               child: const Text("Pay Rs. 1"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

