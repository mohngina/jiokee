import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({@required this.onPress, @required this.label});
  final Function onPress;
  final String label;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.amber,
      height: 60,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onPressed: onPress,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
