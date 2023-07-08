import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:majorpor/constants/shared_pref.dart';
import 'package:majorpor/screens/login/customer/customer_login.dart';
import 'package:majorpor/screens/login/customer/user_profile.dart';
import 'package:majorpor/widgets/custom_toast.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final CustomerLogin cl = const CustomerLogin();

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const CustomerLogin()),
        (Route<dynamic> route) => false);
  }

  var num =
      '${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.mob)}';
  var name =
      '${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.fname)} ${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.lname)}';

  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 0), (Timer t) {
      setState(() {
        num =
            '${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.mob)}';
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
    return Drawer(
      backgroundColor: const Color(0xFF576CD6),
      elevation: 3,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: ListTile(
                  visualDensity: const VisualDensity(vertical: -4),
                  title: Text(
                    name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    num,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  leading: const Hero(
                      tag: '',
                      child: CircleAvatar(
                        radius: 25,
                        child: Icon(Icons.person),
                        backgroundColor: Colors.white,
                      )),
                  trailing: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserProfile()),
                    );
                  },
                )),
          ),
          ListTile(
            title: const Text(
              'Log Out',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            onTap: () async {
              await _logout();

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomerLogin()),
                  (route) => false);
              customToast("Logout successfully");

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
