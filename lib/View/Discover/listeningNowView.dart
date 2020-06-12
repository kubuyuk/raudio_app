import 'package:flutter/material.dart';
import 'package:raudio_app/Controller/Discover/listeningNowController.dart';
import 'dart:async';
import 'playPauseButtonView.dart';

class ListeningNow extends StatefulWidget {
  @override
  _ListeningNowState createState() => _ListeningNowState();
}

class _ListeningNowState extends State<ListeningNow> {
  ListeningNowController con = ListeningNowController();
  int progress;
  Timer timer;

  @override
  void initState() {
    super.initState();
    con.getCurrentlyPlaying();

    timer = new Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              con.getCurrentlyPlaying();
              con.currentlyPlayingImage();
              progress = con.currentlyPlayingProgress();
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.33,
            child: Container(
              height: 140,
              width: double.infinity,
              child: FittedBox(
                child: Image.network(con.currentlyPlayingImage()),
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
              ),
            ),
          ), // Song Image
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          con.currentlyPlayingId(),
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        ),
                        Text(
                          con.currentlyPlayingArtist(),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        //FavouriteButton(),
                        SizedBox(width: 10),
                        PlayPauseButton(con.currentlyPlayingUri()),
                        SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.black,
                    trackHeight: 3.0,
                    thumbColor: Colors.yellow,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
                    overlayColor: Colors.purple.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
                  ),
                  child: Slider(
                    value: progress.toDouble(),
                    min: 0.0,
                    max: con.currentlyPlayingDuration().toDouble(),
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey,
                    onChangeStart: (double startValue) {
                      con.sliderChangeStart(startValue);
                    },
                    onChangeEnd: (double endValue) {
                      con.sliderChangeEnd(endValue);
                    },
                    onChanged: (double newValue) {
                      setState(() {
                        progress = newValue.toInt();
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        (progress / 60000).toInt().toString() +
                            ':' +
                            (progress / 1000 % 60).toInt().toString(),
                        style: TextStyle(color: Colors.white)),
                    Text(
                        (con.currentlyPlayingDuration() / 60000)
                                .toInt()
                                .toString() +
                            ':' +
                            (con.currentlyPlayingDuration() / 1000 % 60)
                                .toInt()
                                .toString(),
                        style: TextStyle(color: Colors.white))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
