// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:majorpor/constants/shared_pref.dart';
import 'package:majorpor/screens/login/customer/entry_time_details.dart';
import 'package:majorpor/screens/login/customer/home_screen.dart';
import 'package:majorpor/widgets/button_loader.dart';
import 'package:majorpor/widgets/controllers.dart';
import 'package:majorpor/widgets/controllers.dart';
import 'package:majorpor/widgets/error_dialog.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../../widgets/custom_toast.dart';

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({super.key});

  @override
  State<CustomerLogin> createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  var flag = 0;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;

  late String _verificationId;
  var code = "";
  String _status = "";
  bool _loading = false;

  bool isCodeSent = false;
  bool isPhoneNumberSubmitted = false;
  bool isTimeOut = false;

  Timer? _timer;
  int _start = 60;

  auth.User? _firebaseUser;
  // auth.AuthCredential? _phoneAuthCredential;
  @override
  void initState() {
    super.initState();
    _getFirebaseUser();
  }

  Future<void> _getFirebaseUser() async {
    _firebaseUser = auth.FirebaseAuth.instance.currentUser;
    setState(() {
      _status =
          (_firebaseUser == null) ? 'Not Logged In\n' : 'Already LoggedIn';
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            isCodeSent = false;
            isTimeOut = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void _handleError(e) {
    //print(e.message);
    setState(() {
      _status += e.message + '\n';
    });
  }

  void _verifyPhoneNumber() {
    if (phoneNumberController.text.trim().length != 10) {
      setState(() {
        _loading = false;
      });
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Phone number should be 10 digit.",
            );
          });
    } else {
      Controller.num = phoneNumberController.text.trim();
      _firebaseAuth.verifyPhoneNumber(
          phoneNumber: "+91${phoneNumberController.text.toString().trim()}",
          verificationCompleted: (phoneAuthCredential) {},
          verificationFailed: (FirebaseAuthException exception) {
            print(exception.toString());
            customToast('verification Failed');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const CustomerLogin()),
                (route) => false);
            _handleError(exception);
          },
          codeSent: (String verificationId, int? resendToken) {
            if (flag == 0) {
              setState(() {
                flag = 1;
                _loading = false;
              });
            }
            _verificationId = verificationId;
            customToast("OTP sent");
            setState(() {
              _status += 'Code Sent\n';
              isCodeSent = true;
              startTimer();
              isPhoneNumberSubmitted = false;
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            customToast("Timeout");
            setState(() {
              _loading = false;
              isTimeOut = true;
              _status += 'codeAutoRetrievalTimeout\n';
            });
          });
    }
  }

  var dp = '';
  void _verifyOtp() async {
    // Controller.num = phoneNumberController.text.trim();
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: code,
      );
      await _firebaseAuth
          .signInWithCredential(credential)
          .then((authRes) async {
        _firebaseUser = authRes.user;
        _timer!.cancel();
        dp = 'go';
      }).catchError((e) {
        dp = '';
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "Authentication Failed.",
              );
            });

        print(e.toString());
        _handleError(e);
      });
      print('completeeeeeeeee');
      setState(() {
        _loading = false;
        _status += 'Signed In\n';
        print('signed IN');
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      dp = '';
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Authentication failed.",
            );
          });

      _handleError(e);
    }
    if (dp == 'go') {
      customToast('Logged in');
      try {
        await FirebaseFirestore.instance
            .collection("Users")
            .where('num', isEqualTo: phoneNumberController.text)
            .get()
            .then((value) {
          SharedPreferenceConstants.sharedPreferences!.setString(
              SharedPreferenceConstants.mob, value.docs.first['num']);
          SharedPreferenceConstants.sharedPreferences!.setString(
              SharedPreferenceConstants.fname, value.docs.first['firstName']);
          SharedPreferenceConstants.sharedPreferences!.setString(
              SharedPreferenceConstants.lname, value.docs.first['lastName']);
          SharedPreferenceConstants.sharedPreferences!.setString(
              SharedPreferenceConstants.uid, value.docs.first['uId']);
          SharedPreferenceConstants.sharedPreferences!.setString(
              SharedPreferenceConstants.mail, value.docs.first['userMail']);

          value.docs.isEmpty
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EntryTimeDetails()))
              : Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
        });
      } catch (e) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EntryTimeDetails()));
      }
    }
  }

  void logout() async {
    try {
      await auth.FirebaseAuth.instance.signOut();
      _firebaseUser = null;

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const CustomerLogin()),
          (route) => false);
      setState(() {
        _status += 'Signed out\n';
      });
    } catch (e) {
      _handleError(e);
    }
  }

  String _validateP(String val) {
    String error = '';

    if (val.trim().length != 10) error += 'Phone No. must be of 10 charaters\n';
    if (val.contains((RegExp(r'[a-zA-Z]'))) ||
        val.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      error += 'Phone No. must not contains alphabets/special charaters\n';
    }

    if (error != '') {
      return error;
    } else {
      return "";
    }
  }

  String _validate(String val) {
    String error = '';

    if (val.trim().length < 5) error += 'OTP must be more than 5 charaters\n';
    if (val.trim().length >= 7) {
      error += 'OTP must be smaller than 7 charater\n';
    }
    if (val.contains((RegExp(r'[a-zA-Z]'))) ||
        val.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      error += 'OTP must not contains alphabets/special charaters\n';
    }

    if (error != '') {
      return error;
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_status == "Already LoggedIn")
        ? const HomeScreen()
        : Scaffold(
            backgroundColor: const Color(0xFF576CD6),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text("Customer Login"),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        "assets/images/aqua4.gif",
                        height: 199,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        width: 267,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: const LinearGradient(colors: [
                              Color(0xFFE8ECFD),
                              Color(0xFF8898E3)
                            ])),
                        child: Form(
                          key: formKey,
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: phoneNumberController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "  Phone Number",
                                fillColor: Colors.transparent,
                                icon: Icon(
                                  Icons.phone,
                                  color: Color(0xFF576CD6),
                                )),
                            validator: (val) {
                              _validateP(val.toString());
                            },
                          ),
                        ),
                      ),
                      if (flag == 0) ...[
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _loading = true;
                            });
                            _verifyPhoneNumber();
                            setState(() {
                              isPhoneNumberSubmitted = true;
                            });
                          },
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
                            child: _loading
                                ? buttonLoader
                                : const Text("Verify Phone Number",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                          ),
                        )
                      ],
                      if (flag > 0) ...[
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: formKey2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 50, right: 55),
                            child: PinCodeTextField(
                                cursorColor: const Color(0xFF8898E3),
                                appContext: context,
                                length: 6,
                                obscureText: false,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 40,
                                    fieldWidth: 40,
                                    errorBorderColor: Colors.red,
                                    // disabledColor: Colors.green,
                                    activeFillColor: Colors
                                        .transparent, // enter k baad back color
                                    activeColor: const Color(
                                        0xFF8898E3), //enter ke baad border
                                    inactiveFillColor: const Color(
                                        0xFF8898E3), //inactive inner backgroung
                                    selectedColor: const Color(0xFF8898E3),
                                    inactiveColor:
                                        Colors.transparent, //inactive border
                                    selectedFillColor: Colors.transparent),
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                enableActiveFill: true,
                                controller: otpController,
                                onChanged: (v) {
                                  code = v;
                                },
                                validator: (val) {
                                  _validate(val.toString());
                                }),
                          ),
                        )
                      ],
                      if (flag == 1) ...[
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            if (flag == 0) {
                              setState(() {
                                flag = 1;
                              });
                            }
                            setState(() {
                              _loading = true;
                            });
                            _verifyOtp();
                          },
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
                            child: _loading
                                ? buttonLoader
                                : const Text("Verify OTP",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                          ),
                        ),
                        isCodeSent && !isTimeOut
                            ? Text(
                                "OTP valid till: $_start sec.",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              )
                            : Container(),
                        const SizedBox(
                          height: 10,
                        ),
                        isTimeOut
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isTimeOut = false;
                                    isCodeSent = false;
                                    isPhoneNumberSubmitted = true;
                                    _start = 60;
                                  });
                                  _verifyPhoneNumber();
                                },
                                child: const Text(
                                  "resend OTP",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              )
                            : Container()
                      ],
                    ]),
              ),
            ),
          );
  }
}
