import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jiokee/screens/signup_screen.dart';
import 'package:jiokee/widgets/custom_app_bar.dart';
import 'package:image_picker/image_picker.dart';


class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final picker = ImagePicker();
  File _image;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xff182538),
      appBar: CustomAppBar(
        title: 'Profile',
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      persistentFooterButtons: [
        Container(
          width: 900,
          child: Text(
            'Powered by Jiokee',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
        )
      ],
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0, -0.9),
            child: MaterialButton(
              onPressed: (){
                getImage();
              },
              child: CircleAvatar(
                child: Align(
                  alignment: Alignment(0, 0.9),
                    child: Icon(Icons.mode_edit,color: Color(0xff182538))
                ),
                radius: 100.0,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 0.2),
            child: Container(
                height: mediaQuery.size.width * 0.45,
                width: mediaQuery.size.width * 0.80,
                decoration: BoxDecoration(
                  border: Border.all(width: 4.0,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: mediaQuery.size.width * 0.1, top: 5),
                      child: Row(
                        children: [
                          Text(
                            'Name :',style: TextStyle(color: Colors.white,fontSize: 15),
                          ),
                          SizedBox(width: 20),
                          Text('Stella Muthoni',style: TextStyle(color: Colors.white,fontSize: 15))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: mediaQuery.size.width * 0.1, top: 5),
                      child: Row(
                        children: [
                          Text(
                            'Email :',style: TextStyle(color: Colors.white,fontSize: 15)
                          ),
                          SizedBox(width: 25),
                          Text('stellamuthoni@gmail.com',style: TextStyle(color: Colors.white,fontSize: 15))
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: mediaQuery.size.width * 0.1, top: 5),
                      child: Row(
                        children: [
                          Text(
                            'Contact :',style: TextStyle(color: Colors.white,fontSize: 15)
                          ),
                          SizedBox(width: 10),
                          Text('0701234567',style: TextStyle(color: Colors.white,fontSize: 15))
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                        color: Colors.amber,
                        minWidth: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          'Edit Profile',
                          style:
                          TextStyle(color: Colors.black, letterSpacing: 1),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen(
                                    editForm: true,
                                  )));
                        })
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
