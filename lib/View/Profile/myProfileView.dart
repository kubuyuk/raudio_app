import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:raudio_app/spotifyapi.dart';
import 'package:raudio_app/Model/Classes/User.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final Location location = Location();
  String userName;
  String userPp;
  Spotify spotify = Spotify();
  LocationData _location;
  String _error;

  @override
  void initState() {
    _getLocation();

    userName = spotify.userDisplayName();
    userPp = spotify.userImage();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 300,
          width: double.infinity,
          child: FittedBox(
            child: Image.network(userPp),
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
          ),
        ),
        Text(
          userName,
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          height: 10,
          width: 10,
        ),
        Text(
          (_error ?? '${_location ?? "unknown"}'),
          style: Theme.of(context).textTheme.body2,
        ), //TODO: Cihazda dene, lokasyonu tetiklemenin başka bir yolunu bul ve db'e gönder
        SizedBox(height: 200),
      ],
    );
  }
}
