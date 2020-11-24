import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget with PreferredSizeWidget {

  final Size preferredSize;
  final String title;
  final Widget leading;

  CustomAppBar(
      {this.title,
        this.leading,
        Key key})
      : preferredSize = Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      leading: leading,
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.amber,
      // leading: IconButton(
      //   icon: Icon(Icons.menu),
      //   onPressed: () {},
      //   color: Colors.black,
      // ),
    );
  }
}

