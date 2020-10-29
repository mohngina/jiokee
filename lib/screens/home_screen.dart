import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      body: SafeArea(child: Text('THIS IS THE HOME SCREEN', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40, color: Colors.deepOrange),),),
    );
  }
}
