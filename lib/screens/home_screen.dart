import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:jiokee/screens/map_screen.dart';
import 'package:jiokee/widgets/custom_app_bar.dart';
import 'package:jiokee/widgets/custom_button.dart';
import 'package:http/http.dart' as http;
import 'package:jiokee/widgets/side_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  var data;
  bool isLoading = false;
  FSBStatus status;

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

  // void networkOps() async {
  //   var url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
  //   "location="
  //   "$latitude,"
  //   "$longitude"
  //   "&radius=1000&"
  //   "types=gas_station&"
  //   //"fields=name,geometry&"
  //   "fields=address_component,name,geometry&"
  //   "key=AIzaSyCmTQWvtmgxcppmShtOwveuFvVvt0JilIo";
  //   var response = await http.get(url);
  //
  //   if (response.statusCode == 200) {
  //     data = jsonDecode(response.body);
  //     //Navigator.popAndPushNamed(context, 'home');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     showToast();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FoldableSidebarBuilder(
          status: status,
          drawer: SideDrawer(),
          screenContents: Scaffold(
            backgroundColor: Colors.black,
            appBar: CustomAppBar(
              title: 'Jiokee',
              leading: IconButton(
                icon: Icon(Icons.menu,color: Colors.black,),
                onPressed: (){
                  setState(() {
                    status = status == FSBStatus.FSB_OPEN
                        ? FSBStatus.FSB_CLOSE
                        : FSBStatus.FSB_OPEN;
                  });
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
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/maps.png"),
                  fit: BoxFit.cover,
                ),
              ),
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
          ),
        ),
      ),
    );
  }
}
