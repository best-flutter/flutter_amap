
import 'package:flutter_amap/flutter_amap.dart';

import 'latlng.dart';
import 'region.dart';
import 'map_type.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/rendering.dart';


typedef void LocationChange(Location location);

/**
 * 地图类型
 *
 * - standard: 标准地图
 * - satellite: 卫星地图
 * - night: 夜间地图
 * - nav: 导航地图
 * - bus: 公交地图
 */
enum MapType { standard, satellite, night, nav, bus }

/// 这个应该有更好的实现，比如在最外层增加InheritedWidget,
/// 内部可以感知并实现地图的登记处理
class AMapRouter extends  MaterialPageRoute{
  final List<GlobalKey> keys;
  AMapRouter({
    @required WidgetBuilder builder,
    this.keys
  }) : super(builder:builder);

  @override
  bool didPop(result) {
    for(int i=0; i < keys.length; ++i){
      //SHOW,这里应该有更好的实现方式，比如平移动画，将地图平滑展示
      new Future.delayed(new Duration(milliseconds: 300))
        .then((_){
        AMapView.channel.invokeMethod("hide",{"id":keys[i].toString(),"hide":false});
        GlobalKey key = keys[i];
        _AMapViewState state = key.currentState;
        state?.setSize();
      });
    }
    return super.didPop(result);
  }

  @override
  Future<RoutePopDisposition> willPop() {
    /// 应该将本页面的移除掉（动画评议掉）


    return super.willPop();
  }

  @override
  TickerFuture didPush() {
    //hide,这里应该有更好的实现方式，比如平移动画，将地图隐藏起来
    for(int i=0; i < keys.length; ++i){
      AMapView.channel.invokeMethod("hide",{"id":keys[i].toString(),"hide":true});


     // AMapView.channel.invokeMethod("hide",{"id":keys[i].toString(),"hide":true});
    }

    return super.didPush();
  }



}


class AMapView extends StatefulWidget {


  /**
   * 设定定位的最小更新距离。默认为kCLDistanceFilterNone=-1，会提示任何移动
   */
  final double distanceFilter;

  /**
   * 是否显示室内地图
   */
  final bool showsIndoorMap;

  /**
   * 是否显示室内地图默认控件, 默认YES
   */
  final bool showsIndoorMapControl;

  /**
   * 是否显示楼块，默认为YES
   */
  final bool showsBuildings;

  /**
   *是否显示底图标注, 默认为YES
   */
  final bool showsLabels;

  /**
   * 是否显示用户位置
   */
  final bool showsUserLocation;

  /**
   * 是否显示指南针, 默认YES
   */
  final bool showsCompass;



  /**
   * 是否显示比例尺, 默认YES
   */
  final bool showsScale;




  /**
   * 最大缩放级别
   */
  final double maxZoomLevel;

  /**
   * 最小缩放级别
   */
  final double minZoomLevel;

  /**
   * 当前缩放级别，取值范围 [3, 20]
   */
  final double zoomLevel;

  /**
   * 中心坐标
   */
  final LatLng centerCoordinate;

  /**
   * 显示区域
   */
  final Region region;

  /**
   * 限制地图只能显示某个矩形区域
   */
  final Region limitRegion;



  /**
   * 旋转角度
   */
  final double rotationDegree;

  /**
   * 是否支持缩放, 默认YES
   */
  final bool zoomEnabled;

  /**
   * 是否启用滑动手势，用于平移
   */
  final bool scrollEnabled;

  /**
   * 是否启用旋转手势，用于调整方向
   */
  final bool rotateEnabled;




  final MapType mapType;



  final LocationChange onLocationChange;




  /**
   * 是否显示定位按钮
   *
   * @platform android
   */
  //final bool showsLocationButton;
  /**
   * 是否显示放大缩小按钮
   *
   * @platform android
   */
  //final bool showsZoomControls;

  /**
   * 定位时间间隔(ms),默认2000
   */
  //final int locationInterval;
  /**
   * 倾斜角度，取值范围 [0, 60]
   */
  //final int tilt;
  /**
   * 是否启用倾斜手势，用于改变视角
   */
  //final bool tiltEnabled;


  AMapView({
    //ios
    this.showsScale : true,
    this.showsLabels : true,
    this.showsCompass : true,
    this.showsBuildings : true,
    this.showsIndoorMap : false,
    this.showsIndoorMapControl : true,
    this.showsUserLocation : false,
    this.zoomEnabled : true,
    this.distanceFilter : -1.0,
    this.centerCoordinate ,
    this.limitRegion ,
    this.region ,
    this.zoomLevel : 10.0,
    this.maxZoomLevel : 20.0,
    this.minZoomLevel : 3.0,
    this.rotateEnabled : false,
    this.rotationDegree : 0.0,
    this.scrollEnabled : true,
    this.mapType : MapType.standard,
    this.onLocationChange,

    Key key,


    //this.showsLocationButton : false,
    //this.showsZoomControls : false,
    //this.locationInterval: 2000,
    //this.tilt : 0,
    //this.tiltEnabled : false,


  }) : super( key: key );

  Map toMap() {
    return {
      "centerCoordinate":this.centerCoordinate != null ? this.centerCoordinate.toMap() : null,
      "distanceFilter":this.distanceFilter,
      "limitRegion":this.limitRegion != null ? this.limitRegion.toMap() : null,
      "showsUserLocation":this.showsUserLocation,

      "maxZoomLevel":this.maxZoomLevel,
      "minZoomLevel":this.minZoomLevel,
      "region":this.region != null ? this.region.toMap() : null,
      "rotateEnabled":this.rotateEnabled,

      "rotationDegree":this.rotationDegree,
      "scrollEnabled":this.scrollEnabled,
      "showsBuildings":this.showsBuildings,
      "showsCompass":this.showsCompass,
      "showsIndoorMap":this.showsIndoorMap,
      "showsIndoorMapControl":this.showsIndoorMapControl,
      "showsLabels":this.showsLabels,


      "mapType":this.mapType.index,
      "showsScale":this.showsScale,
      "zoomEnabled":this.zoomEnabled,
      "zoomLevel":this.zoomLevel,



      //"locationInterval":this.locationInterval,
      //"showsLocationButton":this.showsLocationButton,
      //"showsZoomControls":this.showsZoomControls,
      //"tilt":this.tilt,
      //"tiltEnabled":this.tiltEnabled,
    };
  }



  @override
  State<StatefulWidget> createState() {
    return new _AMapViewState();
  }

  static Map<String,GlobalKey> map = {

  };

  static int counter = 0;

  static GlobalKey createKey(GlobalKey orgKey){
    if(counter == 0){
      channel.setMethodCallHandler(_handleMethod);
    }
    if(orgKey!=null){
      remove(orgKey);
    }
    GlobalKey key = new GlobalKey(debugLabel: "${++counter}" );
    map[ key.toString() ] =  key;
    return key;
  }


  static void remove( GlobalKey key ){
    AMapView.channel.invokeMethod('remove',{
      "id": key.toString()
    });
  }
  static MethodChannel channel = const MethodChannel('flutter_amap');


  static Future<dynamic> _handleMethod(MethodCall call) async {
    String method = call.method;
    switch(method){
      case "locationUpdate":
        {
          Map args = call.arguments;
          String id = args["id"];
          print("$id $args");
          GlobalKey key = map[id];
          if(key!=null){
            AMapView view = key.currentWidget;
            view?.onLocationChange( Location.fromMap(args) );
          }
          //_locationChangeStreamController.add(Location.fromMap(args));
          return new Future.value("");
        }

    }
    return new Future.value( "");
  }

  static bool isSetKey = false;

  static void setApiKey(String apiKey) {
    MethodChannel c = const MethodChannel("flutter_amap");
    c.invokeMethod('setApiKey', apiKey);
    isSetKey =  true;
  }


}

class _AMapViewState extends State<AMapView>{

  @override
  void initState() {
    AMapView.channel.invokeMethod('show', {
      "mapView": widget.toMap(),
      "id":widget.key.toString()
    });
    super.initState();
  }

  int _x;
  int _y;
  int _width;
  int _height;



  void setSize(){
    dynamic render = context.findRenderObject();
    Rect rect = render.paintBounds;
    dynamic trans = render.getTransformTo(null).getTranslation();
    int x = trans.x.toInt();
    int y = trans.y.toInt();
    int width = rect.size.width.toInt();
    int height = rect.size.height.toInt();

    //如果已经隐藏了
    if(x < 0){
      return;
    }

    if(x != _x || y != _y || width != _width
        || height != _height){
      _x = x;
      _y = y;
      _width = width;
      _height = height;
      print("change position $x $y");
      AMapView.channel.invokeMethod('rect', {
        "id":widget.key.toString(),
        "x": trans.x,
        "y":trans.y,
        "width":rect.size.width,
        "height":rect.size.height});

    }
  }

  void _trySetSize() async{

    try{
      setSize();
    }catch(e){
      print(e);
      await new Future.delayed( new Duration(milliseconds: 10) );
      scheduleMicrotask(_trySetSize);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scheduleMicrotask(_trySetSize);
  }


  @override
  void didUpdateWidget(AMapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    scheduleMicrotask(_trySetSize);
  }


  @override
  void dispose() {
    AMapView.remove( widget.key );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(

    );
  }

}