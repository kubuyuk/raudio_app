import 'package:flutter/material.dart';
import 'package:raudio_app/View/Tab/tabView.dart';
import 'package:raudio_app/View/Login/loginView.dart';
import 'package:raudio_app/spotifyapi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Spotify _spotify = Spotify();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: 'login',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        'login': (context) => LoginView(),
        '/': (context) => TabView(),
        'spotify': (context) => _spotify.openWebView(context),
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
    );
  }
}
