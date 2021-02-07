import 'package:flutter/material.dart';
import 'package:rider/components/colors.dart';

Widget defaultTextForm({title, type, controller}) => TextFormField(
  keyboardType: type,
  obscureText: true,
  controller: controller,
  decoration: InputDecoration(
    labelText: title,
    labelStyle: TextStyle(
      fontSize: 14.0,
    ),
    hintStyle: TextStyle(color: Colors.grey, fontSize: 10),
  ),
  style: TextStyle(fontSize: 14.0),
);

Widget defaultButton({
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