import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rider/network/firebase_auth.dart';
import 'package:rider/network/firebase_storage.dart';
import 'package:rider/network/realtime_database.dart';

import 'colors.dart';
void initApp() {
  FirebaseAuthService();
  FirebaseRealTimeDatabaseService();
  FirebaseStorageService();
}
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
showToast({@required String message, @required bool error}) =>
    Fluttertoast.showToast(
        msg: " $message ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: error ? kSecondaryColor : kMainColor,
        textColor: kForthColor,
        fontSize: 16.0);

void buildProgressDialog({context, text, error = false}) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
    contentPadding: EdgeInsets.all(8),
    backgroundColor: kMainColor,
    content: Container(
      color: kForthColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (!error) CircularProgressIndicator(backgroundColor: kForthColor    ,),
                if (!error)
                  SizedBox(
                    width: 20.0,
                  ),
                Expanded(
                  child: Text(
                    text,
                  ),
                ),
              ],
            ),
            if (error) SizedBox(height: 20.0),
            if (error)
              buildButton(
                onPressed: () => Navigator.pop(context),
                title: "Cancel",
              ),
          ],
        ),
      ),
    ),
  ),
);
Widget drawDivider() => Divider(height: 1.0,
  color: kMainColor,
  thickness: 1.0,
);