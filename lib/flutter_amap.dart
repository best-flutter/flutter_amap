import 'dart:async';

export 'latlng.dart';
export 'region.dart';
export 'amap_view.dart';
export 'title_options.dart';
export 'map_type.dart';
export 'location.dart';

import 'package:flutter/services.dart';
import 'amap_view.dart';
import 'title_options.dart';
import 'latlng.dart';
import 'location.dart';

class FlutterAmap {
  MethodChannel _channel = const MethodChannel('flutter_amap');
  static bool _apiKeySet = false;

  StreamController<Location> _locationChangeStreamController = new StreamController.broadcast();


  FlutterAmap(){
    _channel.setMethodCallHandler(_handleMethod);
  }

  static setApiKey(String apiKey){
    MethodChannel c = const MethodChannel("flutter_amap");
    c.invokeMethod('setApiKey', apiKey);
    _apiKeySet = true;
  }

  void show({AMapView mapview,TitleOptions title}){
    if (!_apiKeySet) {
      throw "API Key must be set before calling `show`. Use FlutterAmap.setApiKey";
    }

    _channel.invokeMethod('show', {"mapView": mapview.toMap(),"title":title.toMap()});

  }

  Stream<Location> get onLocationUpdated =>_locationChangeStreamController.stream;

  Future<dynamic> _handleMethod(MethodCall call) async {
    String method = call.method;
    switch(method){
      case "locationUpdate":
        {
          Map args = call.arguments;
          _locationChangeStreamController.add(Location.fromMap(args));
          return new Future.value("");
        }

    }
    return new Future.value( "");
  }

}
