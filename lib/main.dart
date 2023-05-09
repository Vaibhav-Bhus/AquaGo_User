import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:majorpor/constants/shared_pref.dart';
import 'package:majorpor/screens/login/customer/customer_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  fun() async {
    SharedPreferenceConstants.sharedPreferences =
        await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fun();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
            gradient: RadialGradient(
          colors: [
            Color(0xFF283855),
            Color(0xFF2E3F68),
            Color(0xFF3B5197),
          ],
        )),
        child: SplashScreenView(
          navigateRoute: const CustomerLogin(),
          duration: 4500,
          imageSize: 450,
          // speed: 1000,
          pageRouteTransition: PageRouteTransition.SlideTransition,
          imageSrc: "assets/images/animation.gif",
          text: 'Aqua Go',
          textType: TextType.ColorizeAnimationText,
          textStyle: const TextStyle(
            fontSize: 40,
            letterSpacing: 4,
          ),
          colors: const [
            Color(0xFF1cd5e0),
            Color(0xFF000046),
          ],
          backgroundColor: Colors.transparent,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'SplashScreen',
    );
  }
}
