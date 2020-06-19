import 'package:raudio_app/controller/services/spotify_brain.dart';

class PlayPauseController {
  bool _isPlaying = true;

  void pressed(Uri) {
    if (_isPlaying == true) {
      if (spotify.currentlyPlayingUri() == Uri) {
        _isPlaying = false;
        spotify.pause();
      } else {
        spotify.playUri(Uri);
      }
    } else if (_isPlaying == false) {
      spotify.playUri(Uri);
      _isPlaying = true;
    }
  }

  bool isPlaying(Uri) {
    return _isPlaying && Uri == spotify.currentlyPlayingUri();
  }
}
