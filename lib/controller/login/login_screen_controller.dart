import 'package:flutter/material.dart';
import 'package:raudio_app/controller/services/location_brain.dart';

class LoginController {
  void connectButtonGotPressed(context) {
    LocationBrain()
        .getLocation(); //TODO: when you implement a future builder for location get rid of this.
    Navigator.pushReplacementNamed(context, 'spotify');
  }
}
