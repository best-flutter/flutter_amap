class LatLng{
  final double latitude;
  final double longitude;

  const LatLng(this.latitude, this.longitude);

  static LatLng fromMap(Map map) {
    return new LatLng(map["latitude"], map["longitude"]);
  }

  Map toMap() {
    return {"latitude": this.latitude, "longitude": this.longitude};
  }

  @override
  String toString() {
    return 'LatLng{latitude: $latitude, longitude: $longitude}';
  }
}