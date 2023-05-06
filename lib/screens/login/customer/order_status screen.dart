import 'package:flutter/material.dart';
import 'package:majorpor/screens/login/customer/home_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class OrderStatusScreen extends StatefulWidget {

   const OrderStatusScreen({super.key});

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: 270,
                padding: const EdgeInsets.all(15),
                child: SplashScreenView(
                  navigateRoute: const HomeScreen(),
                  imageSize: 200,
                  duration: 10000,
                  pageRouteTransition: PageRouteTransition.CupertinoPageRoute,
                  imageSrc: "assets/images/payment-successful2.gif",
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 140),
            Text(
              "Thank You!",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Order Placed Successfully",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
