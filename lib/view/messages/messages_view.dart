import 'package:flutter/material.dart';
import 'package:raudio_app/controller/messages/messages_controller.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    MessagesController con = MessagesController();
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: List<Widget>.generate(con.getLength(), (index) {
        return ListTile(
          onTap: () {
            con.TileTapped(context, index);
          },
          leading: CircleAvatar(
            backgroundImage: AssetImage(con.image(index)),
            radius: 28,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                con.name(index),
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              Text(
                con.distance(index),
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          subtitle: Text(
            con.lastText(index),
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          //trailing: Icon(Icons.play_circle_filled, color: Colors.white, size: 44),
        );
      }),
    );
  }
}
