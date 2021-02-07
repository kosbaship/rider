import 'package:flutter/material.dart';
import 'package:rider/components/colors.dart';

Widget buildTextField({
  @required String title,
  @required TextEditingController controller,
  @required IconData icon,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false
}) => TextFormField(
  keyboardType: keyboardType,
  obscureText: obscureText,
  controller: controller,
  decoration: InputDecoration(
    hintText: "Enter your $title",
    floatingLabelBehavior: FloatingLabelBehavior.always,
    suffixIcon: Icon(icon),
    labelText: title,
    labelStyle: TextStyle(
      fontSize: 16.0,
    ),
    hintStyle: TextStyle(color: kGreyColor, fontSize: 10),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: kSecondaryColor, width: 2),
      gapPadding: 10,
    ),
  ),
  style: TextStyle(fontSize: 14.0, color: kSecondaryColor),
);

Widget buildButton({
  title,
  onPressed,
}) =>
    FlatButton(
      onPressed: onPressed,
      color: kMainColor,
      textColor: Colors.white,
      child: Container(
        height: 50.0,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'BoltSemiBold',
            ),
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void navigateToReplaceMe(context, widget) => Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false);
