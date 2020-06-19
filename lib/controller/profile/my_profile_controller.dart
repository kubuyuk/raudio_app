import 'package:location/location.dart';
import 'package:raudio_app/controller/services/spotify_brain.dart';
import 'package:raudio_app/controller/services/location_brain.dart';

class MyProfileController {
  String name() {
    return spotify.userDisplayName();
  }

  LocationData location() {
    return myLocation;
  }

  String image() {
    return spotify.userImage();
  }
}
