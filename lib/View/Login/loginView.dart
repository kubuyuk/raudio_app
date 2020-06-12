import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raudio_app/Controller/Login/loginController.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            'images/wavyPattern.png',
            height: 140,
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Connect your Spotify account to get started.',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ConnectButton(),
              ],
            ),
          ),
          Image.asset('images/headphones.png'),
        ],
      ),
    );
  }
}

class ConnectButton extends StatelessWidget {
  LoginController con = LoginController();
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        con.connectButtonGotPressed(context);
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset('images/connectButton.png', width: 170),
          SizedBox(
            width: 150,
            child: Row(
              children: <Widget>[
                Image.asset(
                  'images/spotifyLogo.png',
                  height: 30,
                ),
                SizedBox(width: 20),
                Text(
                  'Connect',
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
