import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiokee/screens/signup_screen.dart';
import 'package:jiokee/widgets/custom_button.dart';
import 'package:jiokee/widgets/text_input.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jiokee/utilities/shared_preference.dart';
import 'package:http/http.dart' as http;

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  String code;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();


  void showToast() {
    Fluttertoast.showToast(
        msg: "Email is Verified",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void noToast() {
    Fluttertoast.showToast(
        msg: "Email is Not Verified!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: ListView(
                children: <Widget>[
                  Container(height: size.height * 0.22),
                  Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 8),
                    child: Text(
                      'Jiokee',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 25,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(2, 1),
                                blurRadius: 6.0,
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'Verification',
                                        style: TextStyle(
                                            fontSize: 20,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                SizedBox(height: 15),
                                CustomButton(
                                  label: 'Verify Code',
                                  onPress: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      //FirebaseAuth auth = FirebaseAuth.instance;
                                      try {
                                        // await auth.checkActionCode(code);
                                        // await auth.applyActionCode(code);
                                        // // If successful, reload the user:
                                        // auth.currentUser.reload();
                                        final _auth = FirebaseAuth.instance;
                                        String email = await sharedPreference
                                            .getEmail();
                                        var user = _auth.currentUser;
                                        if (user.emailVerified) {
                                          Navigator.pushNamed(context, 'home');
                                          showToast();
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'invalid-action-code') {
                                          print('The code is invalid.');

                                        }
                                      }
                                    }
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 PasswordResetScreen()));
                                      //   },
                                      //   child: Text(
                                      //     'Forgot Password?',
                                      //     style: TextStyle(
                                      //         color: Colors.amber,
                                      //         letterSpacing: 1),
                                      //   ),
                                      // ),
                                      // Text(
                                      //   ' Or ',
                                      //   style: TextStyle(letterSpacing: 1),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
