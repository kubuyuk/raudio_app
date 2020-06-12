import 'package:flutter/material.dart';

class LoginController {
  void connectButtonGotPressed(context) {
    Navigator.pushReplacementNamed(context, 'spotify');
  }
}
