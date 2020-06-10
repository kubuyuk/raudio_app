import 'package:flutter/material.dart';
import 'package:raudio_app/Model/MockData/mockUserData.dart';

class ProfileScreen extends StatelessWidget {
  final int userID;

  ProfileScreen({Key key, @required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mockUserList[userID].name),
      ),
      body: Image.asset(mockUserList[userID].ppURL),
    );
  }
}
