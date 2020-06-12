import 'package:flutter/material.dart';
import 'package:raudio_app/Controller/Discover/playPauseController.dart';

class PlayPauseButton extends StatefulWidget {
  String uri;
  PlayPauseButton(this.uri);
  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  PlayPauseController con = PlayPauseController();
  String Uri;
  @override
  Widget build(BuildContext context) {
    Uri = widget.uri;

    return ButtonTheme(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 0,
      height: 0,
      child: FlatButton(
          onPressed: () {
            setState(() {
              con.pressed(Uri);
            });
          },
          child: con.isPlaying(Uri)
              ? new Icon(
                  Icons.pause_circle_filled,
                  color: Colors.white,
                  size: 44,
                )
              : new Icon(
                  Icons.play_circle_filled,
                  color: Colors.white,
                  size: 44,
                )),
    );
    ;
  }
}
