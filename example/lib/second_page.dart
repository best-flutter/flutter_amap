import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amap/flutter_amap.dart';

class SecondPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SecondPage();
  }

}

class _SecondPage extends State<SecondPage>{
  Key _key0;
  @override
  void initState() {
    _key0 = AMapView.createKey(_key0);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:  AppBar(


      ),
      body: new AMapView(
          key:_key0,
          centerCoordinate:  LatLng(39.9242, 116.3979),
          zoomLevel: 13.0,
          mapType: MapType.night,
          showsUserLocation: true
      ),

    );
  }

}