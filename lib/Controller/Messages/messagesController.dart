import 'package:raudio_app/View/Messages/chatView.dart';
import 'package:flutter/material.dart';
import 'package:raudio_app/Model/MockData/mockUserData.dart';

class MessagesController {
  void TileTapped(context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatScreen(userUri: index)),
    );
  }

  int getLength() {
    return 3;
  }

  String image(index) {
    return mockUserList[index].ppURL;
  }

  String name(index) {
    return mockUserList[index].name;
  }

  String distance(index) {
    return '1km';
  }

  String lastText(index) {
    return 'A piece of text, Lorem Ipsum';
  }
}
