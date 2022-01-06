import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool validatePassword(String value) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

bool validateUserId(String value) {
  RegExp regExp = new RegExp("r'^[0-9]{8}'");

  return regExp.hasMatch(value);
}
