import 'package:location/location.dart';
import 'package:flutter/services.dart';

LocationData
    myLocation; //TODO: store last location on Firebase, don't keep this global

class LocationBrain {
  Location location = Location();
  Future<void> getLocation() async {
    try {
      final LocationData locationResult = await location.getLocation();
      myLocation = locationResult;
    } on PlatformException catch (err) {
      print('platform exception for location: $err');
    }
  }
}
