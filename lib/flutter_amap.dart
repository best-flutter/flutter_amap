import 'dart:async';

import 'package:flutter/material.dart';

export 'src/map_type.dart';
export 'src/latlng.dart';
export 'src/region.dart';
export 'src/amap_view.dart';
export 'src/title_options.dart';
export 'src/location.dart';

import 'package:flutter/services.dart';
import 'package:flutter_amap/src/amap_view.dart';
import 'package:flutter_amap/src/title_options.dart';
import 'package:flutter_amap/src/latlng.dart';
import 'package:flutter_amap/src/location.dart';


class FlutterAmap {


  FlutterAmap(){
  }

  static setApiKey(String apiKey){
    AMapView.setApiKey(apiKey);
  }




}
