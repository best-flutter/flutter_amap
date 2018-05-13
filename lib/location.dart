
import 'latlng.dart';

class Location extends LatLng{

  final double horizontalAccuracy;
  final double verticalAccuracy;
  final double altitude;
  final double speed;
  final double timestamp;


  Location({double latitude, double longitude,this.horizontalAccuracy,
  this.verticalAccuracy,this.altitude,this.speed,this.timestamp})
      : super(latitude, longitude);

  static Location fromMap(dynamic map){

    return new Location(latitude:map["latitude"], longitude:map["longitude"],
    horizontalAccuracy: map["horizontalAccuracy"],
    verticalAccuracy: map["verticalAccuracy"],
    altitude: map["altitude"],
    speed: map["speed"],
    timestamp: map["timestamp"]);

  }


  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude, horizontalAccuracy:$horizontalAccuracy, verticalAccuracy:$verticalAccuracy, altitude:$altitude, speed:$speed, timestamp:$timestamp}';
  }

}