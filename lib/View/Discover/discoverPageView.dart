import 'package:flutter/material.dart';
import 'package:raudio_app/View/Profile/profileView.dart';
import 'package:raudio_app/Model/MockData/mockUserData.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:raudio_app/Model/Classes/Song.dart';
import 'package:raudio_app/Model/Classes/User.dart';
import 'package:raudio_app/spotifyapi.dart';

bool isPlaying =
    true; //TODO: Şu anda dinlenen parçanın çalma durumunu kontrol et.
bool isFavourite =
    false; //TODO: Şu anda dinlenen parçanın favori olma durumunu kontrol et.

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  Song currentlyPlaying = Song(
      name: 'Loading',
      artist: 'Loading',
      progress_ms: 0,
      duration_ms: 60,
      image:
          'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListeningNow(),
        DiscoverList(3),
      ],
    );
  }
}

class ListeningNow extends StatefulWidget {
  @override
  _ListeningNowState createState() => _ListeningNowState();
}

class _ListeningNowState extends State<ListeningNow> {
  Spotify spotify = Spotify();
  String _error;
  int progress;
  Timer timer;
  Timer sliderChangeTimer;
  Song currentlyPlaying;
  bool isSliderSelected = false;
  bool isPlaying;

  @override
  void initState() {
    super.initState();
    currentlyPlaying = Song(
        progress_ms: spotify.currentlyPlayingProgress(),
        duration_ms: spotify.currentlyPlayingDuration(),
        isPlaying: spotify.isCurrentlyPlaying(),
        uri: spotify.currentlyPlayingUri(),
        name: spotify.currentlyPlayingSongName(),
        artist: spotify.currentlyPlayingArtistsName(),
        image: spotify.currentlyPlayingSongImage());
    progress = currentlyPlaying.progress_ms;
    timer = new Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              spotify.getCurrentlyPlaying();
              currentlyPlaying.name = spotify.currentlyPlayingSongName();
              currentlyPlaying.image = spotify.currentlyPlayingSongImage();
              currentlyPlaying.duration_ms = spotify.currentlyPlayingDuration();
              currentlyPlaying.artist = spotify.currentlyPlayingArtistsName();
              currentlyPlaying.isPlaying = spotify.isCurrentlyPlaying();
              if (!isSliderSelected) {
                currentlyPlaying.progress_ms =
                    spotify.currentlyPlayingProgress();
                progress = currentlyPlaying.progress_ms;
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        // What am I listening right now?
        children: <Widget>[
          Opacity(
            opacity: 0.33,
            child: Container(
              height: 140,
              width: double.infinity,
              child: FittedBox(
                child: Image.network(currentlyPlaying.image),
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
                          currentlyPlaying.name,
                          style: TextStyle(color: Colors.white, fontSize: 26),
                        ),
                        Text(
                          currentlyPlaying.artist,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        //FavouriteButton(),
                        SizedBox(width: 10),
                        PlayPauseButton(spotify.currentlyPlayingUri()),
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
                    //TODO: Sliderı şarkıdan besle (https://developer.spotify.com/documentation/web-api/reference/player/seek-to-position-in-currently-playing-track/)
                    value: progress.toDouble(),
                    min: 0.0,
                    max: currentlyPlaying.duration_ms.toDouble(),
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey,
                    onChangeStart: (double startValue) {
                      isSliderSelected = true;
                    },
                    onChangeEnd: (double endValue) {
                      spotify.seekToPosition(endValue.toInt());

                      Future.delayed(const Duration(seconds: 4), () {
                        setState(() {
                          isSliderSelected = false;
                        });
                      });
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
                        style: TextStyle(
                            color: Colors
                                .white)), //TODO: Slider, Şu ana kadar çalan kısmın saniye değerini bastır
                    Text(
                        (spotify.currentlyPlayingDuration() / 60000)
                                .toInt()
                                .toString() +
                            ':' +
                            (spotify.currentlyPlayingDuration() / 1000 % 60)
                                .toInt()
                                .toString(),
                        style: TextStyle(
                            color: Colors
                                .white)) //TODO: Slider, Şarkının kalan saniye değerini bastır
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

class DiscoverList extends StatefulWidget {
  final int _count;
  DiscoverList(this._count);
  @override
  _DiscoverListState createState() => _DiscoverListState();
}

class _DiscoverListState extends State<DiscoverList> {
  int count;
  final Location location = Location();
  LocationData _location;
  String _error;

  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
    });
    try {
      final LocationData _locationResult = await location.getLocation();
      setState(() {
        _location = _locationResult;
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    count = widget._count;
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: List<Widget>.generate(count, (index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfileScreen(userID: index)),
            );
          },
          leading: CircleAvatar(
            backgroundImage: AssetImage(mockUserList[index]
                .ppURL), //TODO: Kullanıcı resmini db'den getir
            radius: 28,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                mockUserList[index].name, //TODO: Kullanıcı adını db'den getir
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              Text(
                calculateDistance(_location, mockUserList[index].latitude,
                            mockUserList[index].longitude)
                        .toStringAsFixed(0) +
                    ' km', //TODO: Lokasyonu göstermenin verimli bir yolunu uygula
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          subtitle: Text(
            mockUserList[index]
                .nowPlayingID, //TODO: Şarkı ve şarkıcıyı db'den getir
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          trailing: PlayPauseButton(mockUserList[index].nowPlayingUri),
        );
      }),
    );
  }
}

class PlayPauseButton extends StatefulWidget {
  String uri;
  PlayPauseButton(this.uri);
  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  Spotify spotify = Spotify();
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
            if (isPlaying == true) {
              if (spotify.currentlyPlayingUri() == Uri) {
                setState(() {
                  isPlaying = false;
                  spotify.pause();
                });
              } else {
                spotify.playUri(Uri);
              }
              // pause();
            } else if (isPlaying == false) {
              setState(() {
                spotify.playUri(Uri);
                isPlaying = true;
              });
              // play();
            }
          },
          child: isPlaying && Uri == spotify.currentlyPlayingUri()
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

class FavouriteButton extends StatefulWidget {
  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 0,
      child: FlatButton(
          onPressed: () {
            if (isFavourite == true) {
              setState(() {
                isFavourite = false;
              });
            } else if (isFavourite == false) {
              setState(() {
                isFavourite = true;
              });
            }
          },
          child: isFavourite
              ? new Icon(
                  Icons.favorite,
                  color: Colors.green,
                  size: 40,
                )
              : new Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 40,
                )),
    );
    ;
  }
}
