import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final int userID;

  ChatScreen({Key key, @required this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('userID: $userID'),
      ),
      body: CircleAvatar(
        backgroundImage: AssetImage(
            'images/user$userID.jpg'), //TODO: Kullanıcı resmini db'den getir
        radius: 60,
      ),
    );
  }
}
