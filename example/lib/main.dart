import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amap/flutter_amap.dart';

void main(){
  FlutterAmap.setApiKey("0787b16ca4fd97815b1d354571e9f9c1");
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FlutterAmap amap = new FlutterAmap();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new InkWell(child: new Text("Show Map"),onTap: this.show)
        ),
      ),
    );
  }


  void show(){
    amap.show(
        mapview: new AMapView(
            centerCoordinate: new LatLng(39.9242, 116.3979),
            zoomLevel: 13.0,
            mapType: MapType.night,
            showsUserLocation: true),
        title: new TitleOptions(title: "我的地图"));
    amap.onLocationUpdated.listen((Location location){

      print("Location changed $location") ;

    });
  }
}
