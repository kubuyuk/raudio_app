import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:raudio_app/Model/Classes/User.dart';
import 'package:raudio_app/Model/MockData/mockUserData.dart';
import 'package:flutter/material.dart';
import 'package:raudio_app/View/Profile/profileView.dart';

class DiscoverCardController {
  DiscoverCardController() {
    getLocation();
  }
  final Location location = Location();
  LocationData _location;
  String _locationErrorCode;
  bool locationErrorStatus;
  int getLength() {
    return 3;
  }

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

  String distance(index) {
    return calculateDistance(_location, mockUserList[index].latitude,
            mockUserList[index].longitude)
        .toStringAsFixed(0);
  }

  String nowPlayingId(index) {
    return mockUserList[index].nowPlayingID;
  }

  String nowPlayingUri(index) {
    return mockUserList[index].nowPlayingUri;
  }

  String name(index) {
    return mockUserList[index].name;
  }

  String image(index) {
    return mockUserList[index].ppURL;
  }

  void TileTapped(context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen(userID: index)),
    );
  }
}
