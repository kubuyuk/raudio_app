import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:raudio_app/view/tab/tab_view.dart';

String playerData;
String userData;
String access_token;
Spotify spotify = Spotify();

class Spotify {
  String _tokenData;
  String _userData;
  String _playerData;
  String _access_token;
  String _refresh_token;
  String _code;
  WebViewController _controller;

  Future<String> getCurrentlyPlaying() async {
    print('access token for getting player is: ' + access_token);
    http.Response response = await http.get(
        'https://api.spotify.com/v1/me/player/currently-playing?',
        headers: {
          'Authorization': 'Bearer ' + access_token,
          'Content-Type': 'application/x-www-form-urlencoded',
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      //TODO: catch other status codes, too.
      _playerData = response.body;
      playerData = _playerData; //TODO: don't use a global var in the future
      print(currentlyPlayingUri());
      return response.body;
    }
  }

  Future<void> playUri(String uri) async {
    int progress = currentlyPlayingProgress();
    String body;
    if (uri != currentlyPlayingUri()) {
      body = '{"uris": ["$uri", "$uri"]}';
    } else {
      body = '{"uris": ["$uri", "$uri"], "position_ms": "$progress"}';
    }

    http.Response response =
        await http.put('https://api.spotify.com/v1/me/player/play',
            headers: {
              'Authorization': 'Bearer ' + access_token,
              'Content-Type': 'application/json',
            },
            body: body);
    print('play response body:' + response.body);
    print(uri);
    print('play response status:' + response.statusCode.toString());
  }

  Future<void> pause() async {
    http.Response response =
        await http.put('https://api.spotify.com/v1/me/player/pause', headers: {
      'Authorization': 'Bearer ' + access_token,
      'Content-Type': 'application/x-www-form-urlencoded',
    });
    print('pause response body:' + response.body);
    print('pause response status:' + response.statusCode.toString());
  }

  Future<String> seekToPosition(int position) async {
    http.Response response = await http.put(
        'https://api.spotify.com/v1/me/player/seek?position_ms=$position',
        headers: {
          'Authorization': 'Bearer ' + access_token,
          'Content-Type': 'application/x-www-form-urlencoded',
        });
    print('requestData response body:' + response.body);
    print('requestData response status:' + response.statusCode.toString());
    return response.body;
  }

  Future<String> userCountry() async {
    return jsonDecode(userData)['country'];
  }

  String userDisplayName() {
    return jsonDecode(userData)['display_name'];
  }

  Future<String> userID() async {
    return jsonDecode(userData)['id'];
  }

  Future<String> userMembershipType() async {
    return jsonDecode(userData)['product'];
  }

  Future<String> userEmail() async {
    return jsonDecode(userData)['email'];
  }

  Future<String> userUri() async {
    return jsonDecode(userData)['uri'];
  }

  String userImage() {
    return jsonDecode(userData)['images'][0]['url'];
  }

  String currentlyPlayingSongImage() {
    return jsonDecode(playerData)['item']['album']['images'][0]['url'];
  }

  String currentlyPlayingSongName() {
    return jsonDecode(playerData)['item']['name'];
  }

  String currentlyPlayingArtistsName() {
    return jsonDecode(playerData)['item']['artists'][0]['name'];
  }

  bool isCurrentlyPlaying() {
    if (jsonDecode(playerData)['is_playing'] == 'true') {
      return true;
    } else {
      return false;
    }
  }

  int currentlyPlayingDuration() {
    return jsonDecode(playerData)['item']['duration_ms'];
  }

  int currentlyPlayingProgress() {
    return jsonDecode(playerData)['progress_ms'];
  }

  String currentlyPlayingUri() {
    return jsonDecode(playerData)['item']['uri'];
  }

  Future<String> requestMyData() async {
    print('token is here in the function: ' + access_token);
    http.Response response =
        await http.get('https://api.spotify.com/v1/me?', headers: {
      'Authorization': 'Bearer ' + access_token,
      'Content-Type': 'application/x-www-form-urlencoded',
    });
    print('requestData response body:' + response.body);
    print('requestData response status:' + response.statusCode.toString());
    return response.body;
  }

  //open a Web View for authorisation
  WebView openWebView(context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl:
          'https://accounts.spotify.com/authorize?show_dialog=true&client_id=3a5d96339141402684c63b406b673497&response_type=code&redirect_uri=raudio-login://callback&scope=user-read-private%20user-read-email%20user-read-currently-playing%20user-read-playback-state%20user-modify-playback-state',
      onWebViewCreated: (WebViewController webViewController) {
        _controller = webViewController;
      },
      navigationDelegate: (NavigationRequest request) async {
        if (request.url.startsWith('raudio-login://callback')) {
          print('blocking navigation to $request}');
          _code = request.url.toString().split('=')[1];
          print('code is: $_code');
          //_controller.loadUrl(
          _tokenData = await requestToken();
          _access_token = jsonDecode(_tokenData)['access_token'];
          access_token =
              _access_token; //TODO: don't use a global var in the future
          _refresh_token = jsonDecode(_tokenData)[
              'refresh_token']; // TODO: use the refresh token to refresh your access token
          _userData = await requestMyData();
          userData = _userData; //TODO: don't use a global var in the future
          _playerData = await getCurrentlyPlaying();
          playerData = _playerData; //TODO: don't use a global var in the future
          print('currently playing: ' + currentlyPlayingUri());
          playUri(currentlyPlayingUri());

          Navigator.pushReplacementNamed(context, TabView.id);
          return NavigationDecision.prevent;
        }
        print('allowing navigation to $request');
        return NavigationDecision.navigate;
      },
    );
  }

  Future<String> requestToken() async {
    http.Response response = await http.post(
        'https://accounts.spotify.com/api/token?grant_type=authorization_code&code=${_code}&redirect_uri=raudio-login://callback',
        headers: {
          'Authorization':
              'Basic M2E1ZDk2MzM5MTQxNDAyNjg0YzYzYjQwNmI2NzM0OTc6ZWQxZWRlOWQxYjVmNDgwM2JmNzk4YTc0Zjg2NDIwOTg=',
          'Content-Type': 'application/x-www-form-urlencoded',
        });
    print('requestToken response body:' + response.body);
    print('requestToken response status:' + response.statusCode.toString());
    return response.body;
  }
}
