import 'dart:async';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:raudio_app/spotifyapi.dart';

class MyProfileController {
  Location location = Location();
  Spotify spotify = Spotify();
  String _locationErrorCode;
  bool locationErrorStatus;

  Future getLocation() async {
    try {
      final LocationData _locationResult = await location.getLocation();
      locationErrorStatus = false;
      return _locationResult;
    } on PlatformException catch (err) {
      _locationErrorCode = err.code;
      locationErrorStatus = true;
    }
  }

  String name() {
    return spotify.userDisplayName();
  }

  String image() {
    return spotify.userImage();
  }

  bool isThereALocationError() {
    return locationErrorStatus;
  }
}
