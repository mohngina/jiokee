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

class EditProfile extends StatefulWidget {

  EditProfile({@required this.editField});
  final bool editField;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _auth = FirebaseAuth.instance;
  final _firstore = FirebaseFirestore.instance;
  String email, password, password2, firstName, lastName, phoneNUmber, userEmail;
  var data;
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();

  User loggedInUser;

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
                            child: StreamBuilder(
                                stream: Firestore.instance.collection('profile').document('101').snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return new Text("Loading");
                                  }
                                  var userDocument = snapshot.data;
                                  fnameController.text = userDocument["fname"];
                                  lnameController.text = userDocument["fname"];
                                  emailController.text = userDocument["email"];
                                  phoneController.text = userDocument["phone"];
                                  return new Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .stretch,
                                    children: [
                                      Center(
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Text(
                                                'Edit Profile',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    letterSpacing: 1,
                                                    fontWeight: FontWeight
                                                        .bold),
                                              )
                                          )),
                                      TextInput(
                                        obscureText: false,
                                        //controller: fnameController,
                                        valueX: fnameController.text,
                                        keyboardType: TextInputType.text,
                                        onChange: (typedFirstName) {
                                          firstName = typedFirstName;
                                        },
                                        validate: (typedFirstName) {
                                          if (typedFirstName.isEmpty) {
                                            return 'Please type in your name';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 15),
                                      TextInput(
                                        obscureText: false,
                                        //controller: lnameController,
                                        valueX: lnameController.text,
                                        keyboardType: TextInputType.text,
                                        onChange: (typedLastName) {
                                          lastName = typedLastName;
                                        },
                                        validate: (typedLastName) {
                                          if (typedLastName.isEmpty) {
                                            return 'Please type in your name';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 15),
                                      TextInput(
                                        obscureText: false,
                                        //controller: emailController,
                                        valueX: emailController.text,
                                        keyboardType: TextInputType
                                            .emailAddress,
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
                                        //controller: phoneController,
                                        valueX: phoneController.text,
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
                                      SizedBox(height: 20),
                                      CustomButton(
                                        label: 'SAVE CHANGES',
                                        onPress: () async {
                                          // _firstore.collection('profile').add({
                                          //   'fname': firstName,
                                          //   'lname': lastName,
                                          //   'email': email,
                                          //   'phone': phoneNUmber,
                                          // });
                                         await _firstore.collection('profile').doc('101').update({
                                            'fname': firstName,
                                            'lname': lastName,
                                            'email': email,
                                            'phone': phoneNUmber,
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5),
                                      ),
                                    ],
                                  );
                                },
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
