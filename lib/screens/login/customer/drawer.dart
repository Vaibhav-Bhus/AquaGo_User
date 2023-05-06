import 'package:cloud_firestore/cloud_firestore.dart';
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
    // FirebaseAuth _auth = ;
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomerLogin()),
    );
  }

  var name = '';
  var num = '';
  @override
  void initState() {
    super.initState();
    num =
        '${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.mob)}';
    name =
        '${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.fname)} ${SharedPreferenceConstants.sharedPreferences!.getString(SharedPreferenceConstants.lname)}';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF576CD6),
      elevation: 3,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  title: Text(name),
                  subtitle: Text(num),
                  leading: Hero(
                      tag: '',
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                      )),
                  trailing: Icon(
                    Icons.edit,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfile()),
                    );
                  },
                )),
          ),
          ListTile(
            title: const Text('Transtaction Details'),
            onTap: () {
              
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Log Out'),
            onTap: () {
              _logout();

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomerLogin()),
                  (route) => false).then((value) => setState(() {}));
              customToast("Logout successfully");
              
              Navigator.pop(context);
            },
          ),
          // ListTile(
          //   title: const Text('Test'),
          //   onTap: () async {
          //     await FirebaseFirestore.instance
          //         .collection("Users")
          //         .where('num', isEqualTo: '7719874955')
          //         .get()
          //         .then((value) {
          //       print(value.docs.first['num']);
                
          //     });
          //   },
          // ),
        ],
      ),

      // customButton(context, "Profile", UserProfile()),

      //   ],
      // ),
    );
  }
}
