
import 'package:flutter_amap/src/latlng.dart';

class Location extends LatLng{

  final double accuracy;
  final double altitude;
  final double speed;
  final double timestamp;


  Location({double latitude, double longitude,this.accuracy,this.altitude,this.speed,this.timestamp})
      : super(latitude, longitude);

  static Location fromMap(dynamic map){

    return new Location(latitude:map["latitude"], longitude:map["longitude"],
    accuracy: map["accuracy"],
    altitude: map["altitude"],
    speed: map["speed"],
    timestamp: map["timestamp"]);

  }


  @override
  String toString() {
    return 'Location{latitude: $latitude, longitude: $longitude, accuracy:$accuracy, altitude:$altitude, speed:$speed, timestamp:$timestamp}';
  }

}