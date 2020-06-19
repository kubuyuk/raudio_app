import 'package:location/location.dart';
import 'package:great_circle_distance2/great_circle_distance2.dart';

class User {
  int userID;
  String name;
  String nowPlayingID;
  bool isOnline;
  double latitude;
  double longitude;
  String nowPlayingUri;
  String ppURL;
  User(
      {this.userID,
      this.name,
      this.nowPlayingID,
      this.nowPlayingUri,
      this.isOnline,
      this.latitude,
      this.longitude,
      this.ppURL});
}

double calculateDistance(LocationData location, double lat2, double lon2) {
  double lat1 = location.latitude;
  double lon1 = location.longitude;
  var gcd = new GreatCircleDistance.fromDegrees(
      latitude1: lat1, longitude1: lon1, latitude2: lat2, longitude2: lon2);
  return gcd.vincentyDistance() / 1000;
}
