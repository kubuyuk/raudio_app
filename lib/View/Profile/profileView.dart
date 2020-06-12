import 'package:flutter/material.dart';
import 'package:raudio_app/Controller/Profile/profileController.dart';

class ProfileScreen extends StatelessWidget {
  final int userID;
  ProfileController con;

  ProfileScreen({Key key, @required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    con = ProfileController(userID);
    return Scaffold(
      appBar: AppBar(
        title: Text(con.name()),
      ),
      body: Image.asset(con.ppURL()),
    );
  }
}
