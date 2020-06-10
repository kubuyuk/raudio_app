import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String tokenData;
String userData;
String playerData;
String access_token;
String refresh_token;

class Spotify {
  String _tokenData;
  String _userData;
  String _playerData;
  String _access_token;
  String _refresh_token;
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
      playerData = response.body;
      _playerData = response.body;
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
          String code = request.url.toString().split('=')[1];
          print('code is: $code');
          //_controller.loadUrl(
          _tokenData = await requestToken(code);
          _access_token = jsonDecode(_tokenData)['access_token'];
          access_token = _access_token; //TODO: global saklamaktan kurtul
          _refresh_token = jsonDecode(_tokenData)[
              'refresh_token']; // TODO: refresh token api call gerekiyor
          _userData = await requestMyData(_access_token);
          userData = _userData; //TODO: global saklamaktan kurtul
          _playerData = await getCurrentlyPlaying();
          playerData = _playerData; //TODO: global saklamaktan kurtul
          print('currently playing: ' + currentlyPlayingUri());
          playUri(currentlyPlayingUri());

          Navigator.pushReplacementNamed(context, '/');
          return NavigationDecision.prevent;
        }
        print('allowing navigation to $request');
        return NavigationDecision.navigate;
      },
    );
  }
}

Future<String> requestToken(String code) async {
  http.Response response = await http.post(
      'https://accounts.spotify.com/api/token?grant_type=authorization_code&code=$code&redirect_uri=raudio-login://callback',
      headers: {
        'Authorization':
            'Basic M2E1ZDk2MzM5MTQxNDAyNjg0YzYzYjQwNmI2NzM0OTc6ZWQxZWRlOWQxYjVmNDgwM2JmNzk4YTc0Zjg2NDIwOTg=',
        'Content-Type': 'application/x-www-form-urlencoded',
      });
  print('requestToken response body:' + response.body);
  print('requestToken response status:' + response.statusCode.toString());
  return response.body;
}

Future<String> requestMyData(String access_token) async {
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
