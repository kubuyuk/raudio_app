import 'package:raudio_app/view/messages/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:raudio_app/model/mock_user_data.dart';
import 'package:raudio_app/model/constants.dart';

class MessagesController {
  void TileTapped(context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatScreen(userUri: index)),
    );
  }

  int getLength() {
    return discoverListLength; //TODO: get users from Firebase
  }

  String image(index) {
    return mockUserList[index].ppURL; //TODO: get users from Firebase
  }

  String name(index) {
    return mockUserList[index].name; //TODO: get users from Firebase
  }

  String distance(index) {
    return '1km'; //TODO: get users from Firebase and then calculate thier distance with the current user
  }

  String lastText(index) {
    return 'A piece of text, Lorem Ipsum'; //TODO: get last piece of text from Firebase
  }
}
