import 'package:flutter/material.dart';

class LoginStatus {
  static ValueNotifier<String> name = ValueNotifier<String>('');
  static ValueNotifier<String> imageUrl = ValueNotifier<String>('');
  static bool isLogin = false;
  static bool isGeust = false;
  static bool joining = false;
  static bool signining = false;
  //static String accessToken = "";
  //static String refreshToken = "";
}