import 'package:flutter/material.dart';
import 'play_button_view.dart';
import 'package:raudio_app/controller/discover/discover_card_controller.dart';

class DiscoverList extends StatefulWidget {
  @override
  _DiscoverListState createState() => _DiscoverListState();
}

class _DiscoverListState extends State<DiscoverList> {
  DiscoverCardController con = DiscoverCardController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                con.distance(index) + ' km', //TODO: Future Builder
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          subtitle: Text(
            con.nowPlayingId(index),
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          trailing: PlayPauseButton(con.nowPlayingUri(index)),
        );
      }),
    );
  }
}
