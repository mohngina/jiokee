import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiokee/screens/signup_screen.dart';
import 'package:jiokee/screens/verification_screen.dart';
import 'package:jiokee/widgets/custom_button.dart';
import 'package:jiokee/widgets/text_input.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
//TODO: Show A toast when username and password is blank
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  var data;
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  onClear() {
    setState(() {
      emailController.text = "";
      passwordController.text = "";
    });
  }

  void loginToast() {
    Fluttertoast.showToast(
        msg: "Login Successful!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepOrange,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: "Incorrect username or password",
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
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 20,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                TextInput(
                                  obscureText: false,
                                  hint: 'Email Address',
                                  onChange: (value) {
                                    email = value;
                                  },
                                  validate: (value) {
                                    if (value.isEmpty) {
                                      return 'Please type in your email';
                                    }
                                    Pattern pattern =
                                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = new RegExp(pattern);
                                    if (!regex.hasMatch(value))
                                      return 'Enter Valid Email';
                                    else
                                      return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                TextInput(
                                  obscureText: true,
                                  hint: 'Password',
                                  onChange: (typedPassword) {
                                    password = typedPassword;
                                  },
                                  validate: (typedPassword) {
                                    if (typedPassword.isEmpty) {
                                      return 'Please type in your password';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                CustomButton(
                                  label: 'LOGIN',
                                  onPress: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        final user = await _auth
                                            .signInWithEmailAndPassword(
                                            email: email, password: password);
                                        if (user != null) {
                                          Navigator.pushNamed(context, 'home');
                                          loginToast();
                                        }
                                        //networkOps();
                                        onClear();
                                      }catch(e){
                                        setState(() {
                                          isLoading = false;
                                        });
                                        showToast();
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
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUpScreen()));
                                        },
                                        child: Text(
                                          'Create Account?',
                                          style: TextStyle(
                                              color: Colors.amber,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 VerificationScreen()));
                                      //   },
                                      //   child: Text(
                                      //     'VERIFY?',
                                      //     style: TextStyle(
                                      //         color: Colors.amber,
                                      //         letterSpacing: 1),
                                      //   ),
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
