import 'package:raudio_app/model/classes/User.dart';
import 'package:raudio_app/model/mock_data/mock_user_data.dart';
import 'package:flutter/material.dart';
import 'package:raudio_app/View/Profile/profile_view.dart';
import 'package:raudio_app/model/constants/constants.dart';
import 'package:raudio_app/controller/services/location_brain.dart';

class DiscoverCardController {
  int getLength() {
    return discoverListLength; //TODO: finalise the list length later on
  }

  String distance(index) {
    return calculateDistance(myLocation, mockUserList[index].latitude,
            mockUserList[index].longitude)
        .toStringAsFixed(0);
  }

  String nowPlayingId(index) {
    return mockUserList[index]
        .nowPlayingID; //TODO: Instead of Mock data implement Firebase
  }

  String nowPlayingUri(index) {
    return mockUserList[index]
        .nowPlayingUri; //TODO: Instead of Mock data implement Firebase
  }

  String name(index) {
    return mockUserList[index]
        .name; //TODO: Instead of Mock data implement Firebase
  }

  String image(index) {
    return mockUserList[index]
        .ppURL; //TODO: Instead of Mock data implement Firebase
  }

  void tileTapped(context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen(userID: index)),
    );
  }
}
