import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jiokee/screens/map_screen.dart';
import 'package:jiokee/widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 5, title: Text('Home', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
                child: Container()),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  CustomButton(
                      onPress: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MapView()));
                      },
                      label: 'Find Garage'),
                  SizedBox(height: 10,),
                  CustomButton(
                      onPress: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MapView()));
                      },
                      label: 'Find Petrol'),
                ],
              ),
            ),
            Expanded(
                flex: 4,
                child: Container()),
          ],
        ),
      ),
    );
  }
}
