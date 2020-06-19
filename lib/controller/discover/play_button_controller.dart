import 'package:raudio_app/controller/services/spotify_brain.dart';

class PlayPauseController {
  bool _isPlaying = true;

  void pressed(uri) {
    if (_isPlaying == true) {
      if (spotify.currentlyPlayingUri() == uri) {
        _isPlaying = false;
        spotify.pause();
      } else {
        spotify.playUri(uri);
      }
    } else if (_isPlaying == false) {
      spotify.playUri(uri);
      _isPlaying = true;
    }
  }

  bool isPlaying(uri) {
    return _isPlaying && uri == spotify.currentlyPlayingUri();
  }
}
