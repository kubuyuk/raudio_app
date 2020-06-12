import 'package:raudio_app/spotifyapi.dart';
import 'dart:async';
import 'package:raudio_app/Model/Classes/Song.dart';

class ListeningNowController {
  Spotify spotify = Spotify();
  String _error;
  Timer sliderChangeTimer;
  Song currentlyPlaying;
  bool _isSliderSelected = false;
  bool isPlaying;

  void setTimerUpdates() {}

  String currentlyPlayingImage() {
    return spotify.currentlyPlayingSongImage();
  }

  String currentlyPlayingId() {
    return spotify.currentlyPlayingArtistsName();
  }

  String currentlyPlayingArtist() {
    return spotify.currentlyPlayingArtistsName();
  }

  String currentlyPlayingUri() {
    return spotify.currentlyPlayingUri();
  }

  int currentlyPlayingDuration() {
    return spotify.currentlyPlayingDuration();
  }

  int currentlyPlayingProgress() {
    return spotify.currentlyPlayingProgress();
  }

  void sliderChangeStart(startValue) {
    _isSliderSelected = true;
  }

  void getCurrentlyPlaying() {
    spotify.getCurrentlyPlaying();
  }

  void sliderChangeEnd(endValue) {
    spotify.seekToPosition(endValue.toInt());

    Future.delayed(const Duration(seconds: 4), () {
      _isSliderSelected = false;
    });
  }
}
