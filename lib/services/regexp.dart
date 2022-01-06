import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool validatePassword(String value) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

bool validateUserId(String value) {
  String pattern = r'^(?=.*?[0-9]).{8}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
