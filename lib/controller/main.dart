import 'package:flutter/material.dart';
import 'package:raudio_app/view/tab/tab_view.dart';
import 'package:raudio_app/view/login/login_view.dart';
import 'package:raudio_app/controller/services/spotify_brain.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Spotify _spotify = Spotify();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: LoginView.id,
      routes: {
        LoginView.id: (context) => LoginView(),
        TabView.id: (context) => TabView(),
        'spotify': (context) => _spotify.openWebView(context),
      },
    );
  }
}
