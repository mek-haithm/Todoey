import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

TextStyle kTitleTextStyle(BuildContext context) {
  return const TextStyle(
    fontWeight: FontWeight.normal,
    color: kMainColor,
    fontSize: 25.0,
    fontFamily: 'ibmFont',
  );
}


TextStyle kLargeTextStyle(BuildContext context) {
  return const TextStyle(
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontSize: 20.0,
    fontFamily: 'ibmFont',
  );
}

TextStyle kLargeBoldTextStyle(BuildContext context) {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 20.0,
    fontFamily: 'ibmFont',
  );
}

TextStyle kMediumTextStyle(BuildContext context){
  return const TextStyle(
    fontWeight: FontWeight.normal,
    color: Color(0xff2c2929),
    fontSize: 17.0,
    fontFamily: 'ibmFont',
  );
}

TextStyle kMediumBoldTextStyle(BuildContext context){
  return const TextStyle(
    fontWeight: FontWeight.bold,
    color: Color(0xff2c2929),
    fontSize: 17.0,
    fontFamily: 'ibmFont',
  );
}

TextStyle kSmallTextStyle(BuildContext context){
  return const TextStyle(
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontSize: 15.0,
    fontFamily: 'ibmFont',
  );
}

TextStyle kSmallBoldTextStyle(BuildContext context){
  return const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 15.0,
    fontFamily: 'ibmFont',
  );
}

TextStyle kInactiveTextStyle(BuildContext context){
  return const TextStyle(
    fontWeight: FontWeight.normal,
    color: Colors.grey,
    fontSize: 17.0,
    fontFamily: 'ibmFont',
  );
}

TextStyle kInactiveBoldTextStyle(BuildContext context){
  return const TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.grey,
    fontSize: 17.0,
    fontFamily: 'ibmFont',
  );
}

TextStyle kMessageTitleTextStyle(BuildContext context){
  return const TextStyle(
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: 16.0,
    fontFamily: 'ibmFont',
  );
}

TextStyle kMessageTextTextStyle(BuildContext context){
  return const TextStyle(
    fontWeight: FontWeight.normal,
    color: Colors.black,
    fontSize: 14.0,
    fontFamily: 'ibmFont',
  );
}

TextStyle kButtonAlertTextStyle(BuildContext context){
  return const TextStyle(
    fontWeight: FontWeight.normal,
    color: kMainColor,
    fontSize: 12.0,
    fontFamily: 'ibmFont',
  );
}

TextStyle kButtonTextStyle(BuildContext context){
  return const TextStyle(
    fontWeight: FontWeight.normal,
    color: kBackground,
    fontSize: 17.0,
    fontFamily: 'ibmFont',
  );
}

TextStyle kSelectedLabelStyle(BuildContext context){
  return const TextStyle(
    fontWeight: FontWeight.normal,
    color: kMainColor,
    fontSize: 13.0,
    fontFamily: 'ibmFont',
  );
}

TextStyle kUnselectedLabelStyle(BuildContext context) {
  return const TextStyle(
    fontWeight: FontWeight.normal,
    color: Colors.grey,
    fontSize: 12.0,
    fontFamily: 'ibmFont',
  );
}