import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final int userUri;

  ChatScreen({Key key, @required this.userUri}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('userID: $userUri'),
      ),
      body: CircleAvatar(
        backgroundImage: AssetImage(
            'images/user$userUri.jpg'), //TODO: Kullanıcı resmini db'den getir
        radius: 60,
      ),
    );
  }
}
