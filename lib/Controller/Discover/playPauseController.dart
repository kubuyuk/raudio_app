import 'package:raudio_app/spotifyapi.dart';

class PlayPauseController {
  Spotify spotify = Spotify();
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
