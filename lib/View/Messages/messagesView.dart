import 'package:flutter/material.dart';
import 'package:raudio_app/Model/MockData/mockUserData.dart';
import 'package:raudio_app/View/Messages/chatView.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: List<Widget>.generate(mockUserList.length, (index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ChatScreen(userID: index)), //TODO:kullanıcı ID'sini ilet
            );
          },
          leading: CircleAvatar(
            backgroundImage: AssetImage(
                'images/user$index.jpg'), //TODO: Kullanıcı resmini db'den getir
            radius: 28,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'User$index', //TODO: Kullanıcı adını db'den getir
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              Text(
                '1km', //TODO: Lokasyonu göstermenin verimli bir yolunu uygula
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          subtitle: Text(
            'A piece of text, Lorem Ipsum', //TODO: Son mesajı görüntüle
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          //trailing: Icon(Icons.play_circle_filled, color: Colors.white, size: 44),
        );
      }),
    );
  }
}
