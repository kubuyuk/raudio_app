import 'package:raudio_app/controller/services/spotify_brain.dart';
import 'dart:async';

class ListeningNowController {
  String _error; //TODO: manage API errors
  Timer sliderChangeTimer;
  bool _isSliderSelected = false;
  bool isPlaying;

  String currentlyPlayingImage() {
    return spotify.currentlyPlayingSongImage();
  }

  String currentlyPlayingId() {
    return spotify.currentlyPlayingSongName();
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
  }
}
