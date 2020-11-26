import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:jiokee/widgets/custom_button.dart';
import 'package:jiokee/widgets/text_input.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jiokee/utilities/shared_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {

  SignUpScreen({@required this.editForm});
  final bool editForm;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final _firstore = FirebaseFirestore.instance;
  String email, password, password2, firstName, lastName, phoneNUmber, userEmail;
  var data;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  User loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }


  void getCurrentUser() async {
    try{
      final user = await _auth.getRedirectResult();
      if (user != null){
        loggedInUser = _auth.currentUser;
        print(loggedInUser.email);
      }}
    catch(e){
      print(e);
    }
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: "Check your Internet Connection!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  void signUpToast() {
    Fluttertoast.showToast(
        msg: "Registered Successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepOrange,
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
                  Container(height: size.height * 0.12),
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
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(2, 1),
                                  blurRadius: 6.0,
                                ),
                              ],
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: widget.editForm ? Text(
                                        'Edit Profile',
                                        style: TextStyle(
                                            fontSize: 20,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold),
                                      ) : Text(
                                        'Registration',
                                        style: TextStyle(
                                            fontSize: 20,
                                            letterSpacing: 1,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                TextInput(
                                  obscureText: false,
                                  hint: 'First Name',
                                  keyboardType: TextInputType.text,
                                  onChange: (typedFirstName) {
                                    firstName = typedFirstName;
                                  },
                                  validate: (typedFirstName) {
                                    if (typedFirstName.isEmpty) {
                                      return 'Please type in your password';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                TextInput(
                                  obscureText: false,
                                  hint: 'Last Name',
                                  keyboardType: TextInputType.text,
                                  onChange: (typedLastName) {
                                    lastName = typedLastName;
                                  },
                                  validate: (typedLastName) {
                                    if (typedLastName.isEmpty) {
                                      return 'Please type in your password';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                TextInput(
                                  obscureText: false,
                                  hint: 'Email',
                                  keyboardType: TextInputType.emailAddress,
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
                                  obscureText: false,
                                  hint: 'Phone Number',
                                  keyboardType: TextInputType.number,
                                  onChange: (typedNumber) {
                                    phoneNUmber = typedNumber;
                                  },
                                  validate: (typedNumber) {
                                    if (typedNumber.isEmpty) {
                                      return 'Please type in your phone number';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                widget.editForm ? Container() : TextInput(
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
                                SizedBox(height: 15),
                                widget.editForm ? Container() : TextInput(
                                  obscureText: true,
                                  hint: 'Confirm Password',
                                  onChange: (typedPassword) {
                                    password2 = typedPassword;
                                  },
                                  validate: (typedPassword) {
                                    if (typedPassword.isEmpty) {
                                      return 'Please retype in your password';
                                    }else if( password != password2 ){
                                      return 'Passwords do not Match!';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                widget.editForm ? CustomButton(
                                  label: 'SAVE CHANGES',
                                  onPress: (){
                                    _firstore.collection('profile').add({
                                      'fname': firstName,
                                      'lname': lastName,
                                      'email': email,
                                      'phone': phoneNUmber,
                                    });
                                    print('awesome');
                                  },
                                ) :
                                CustomButton(
                                  label: 'CREATE ACCOUNT',
                                  onPress: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        final newUser = await _auth
                                            .createUserWithEmailAndPassword(
                                            email: email, password: password);
                                        userEmail = email;
                                        await sharedPreference.setEmail(userEmail);
                                        if (newUser != null){
                                         if(!newUser.user.emailVerified){
                                          await newUser.user.sendEmailVerification();
                                          Navigator.pushNamed(context, 'login');
                                          signUpToast();
                                         }else{
                                           // Navigator.pushNamed(context, 'login');
                                           // signUpToast();
                                         }
                                        }
                                       await _firstore.collection('profile').add({
                                          'fname': firstName,
                                          'lname': lastName,
                                          'phone': phoneNUmber,
                                        });
                                      }catch(e){
                                        showToast();
                                      }
                                      //networkOps();
                                    }
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
