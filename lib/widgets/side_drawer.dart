import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiokee/screens/home_screen.dart';
import 'package:jiokee/screens/login_screen.dart';
import 'package:jiokee/screens/map_screen.dart';
import 'package:jiokee/screens/profile_screen.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      width: mediaQuery.size.width * 0.70,
      height: mediaQuery.size.width,
      child: Column(
        children: [
          Container(
            color: Color(0xff182538),
            height: 200,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Stella Muthoni',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.amber),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        'Administrator',
                        style: TextStyle(fontSize: 12, color: Colors.amber),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomeScreen()));
            },
          ),
          SizedBox(height: 5),
          ListTile(
            leading: Icon(Icons.perm_identity),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProfileScreen()));
            },
          ),
          SizedBox(height: 5),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Maps'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MapView()));
            },
          ),
          SizedBox(height: 5),
          ListTile(
            leading: Icon(Icons.power_settings_new, color: Colors.red,),
            title: Text('Logout'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}
