// import 'package:flutter/material.dart';
// import 'package:majorpor/screens/login/customer/customer_login.dart';
// import 'package:majorpor/widgets/login_button.dart';

// class MainLogin extends StatefulWidget {
//   const MainLogin({super.key});

//   @override
//   State<MainLogin> createState() => _MainLoginState();
// }

// class _MainLoginState extends State<MainLogin> {
//   TextEditingController usename = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF576CD6),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const SizedBox(
//                 height: 100,
//               ),
//               Container(
//                 height: 350,
//                 width: 250,
//                 decoration: BoxDecoration(
//                     color: const Color.fromARGB(255, 104, 126, 238)
//                         .withOpacity(0.8),
//                     borderRadius: BorderRadius.circular(150)),
//                 child: Image.asset(
//                   'assets/images/aqua2.png',
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(
//                 height: 45,
//               ),
//               customButton(context, "Customer", const CustomerLogin()),
//               const SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 height: 48,
//                 width: 276,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(6),
//                     gradient: const LinearGradient(
//                         colors: [
//                           Color(0xFF283855),
//                           Color(0xFF2E3F68),
//                           Color(0xFF3B5197)
//                         ],
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter)),
//                 child: GestureDetector(
//                     onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const CustomerLogin()),
//                         ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: const [
//                           Icon(
//                             Icons.person_add_alt_1_rounded,
//                             color: Colors.white,
//                           ),
//                           SizedBox(
//                             width: 60,
//                           ),
//                           Text(
//                             "Shopkeeper",
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     )),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 height: 48,
//                 width: 276,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(6),
//                     gradient: const LinearGradient(
//                         colors: [
//                           Color(0xFF283855),
//                           Color(0xFF2E3F68),
//                           Color(0xFF3B5197)
//                         ],
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter)),
//                 child: GestureDetector(
//                     onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const CustomerLogin()),
//                         ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: const [
//                           Icon(
//                             Icons.person_add_alt_1_rounded,
//                             color: Colors.white,
//                           ),
//                           SizedBox(
//                             width: 60,
//                           ),
//                           Text(
//                             "Delivery Boy",
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     )),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Container(
//                 alignment: Alignment.center,
//                 height: 48,
//                 width: 276,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(6),
//                     gradient: const LinearGradient(
//                         colors: [
//                           Color(0xFF283855),
//                           Color(0xFF2E3F68),
//                           Color(0xFF3B5197)
//                         ],
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter)),
//                 child: GestureDetector(
//                     onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const CustomerLogin()),
//                         ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: const [
//                           Icon(
//                             Icons.person_add_alt_1_rounded,
//                             color: Colors.white,
//                           ),
//                           SizedBox(
//                             width: 60,
//                           ),
//                           Text(
//                             "Admin",
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     )),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// // Container(
//               //   alignment: Alignment.center,
//               //   height: 48,
//               //   width: 276,
//               //   decoration: BoxDecoration(
//               //       borderRadius: BorderRadius.circular(6),
//               //       gradient: const LinearGradient(
//               //           colors: [
//               //             Color(0xFF283855),
//               //             Color(0xFF2E3F68),
//               //             Color(0xFF3B5197)
//               //           ],
//               //           begin: Alignment.bottomCenter,
//               //           end: Alignment.topCenter)),
//               //   child: GestureDetector(
//               //       onTap: () => Navigator.push(
//               //             context,
//               //             MaterialPageRoute(
//               //                 builder: (context) => const CustomerLogin()),
//               //           ),
//               //       child: Padding(
//               //         padding: const EdgeInsets.all(8.0),
//               //         child: Row(
//               //           children: const [
//               //             Icon(
//               //               Icons.person_add_alt_1_rounded,
//               //               color: Colors.white,
//               //             ),
//               //             SizedBox(
//               //               width: 60,
//               //             ),
//               //             Text(
//               //               "Customer",
//               //               style: TextStyle(fontSize: 18, color: Colors.white),
//               //             ),
//               //           ],
//               //         ),
//               //       )),
//               // ),