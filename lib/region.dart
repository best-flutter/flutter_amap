

class Region{
  double latitude;
  double longitude;
  double latitudeDelta;
  double longitudeDelta;

  Region({
    this.latitude,
    this.latitudeDelta,
    this.longitude,
    this.longitudeDelta
});


  Map toMap(){
    return {
      "latitude":this.latitude,
      "latitudeDelta":this.latitudeDelta,
      "longitude":this.longitude,
      "longitudeDelta":this.longitudeDelta
    };
  }

}