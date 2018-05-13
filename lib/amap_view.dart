import 'package:flutter_amap/latlng.dart';
import 'package:flutter_amap/region.dart';
import 'map_type.dart';


class AMapView {

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
    this.centerCoordinate : null,
    this.limitRegion : null,
    this.region : null,
    this.zoomLevel : 10.0,
    this.maxZoomLevel : 20.0,
    this.minZoomLevel : 3.0,
    this.rotateEnabled : false,
    this.rotationDegree : 0.0,
    this.scrollEnabled : true,
    this.mapType : MapType.standard,

    //this.showsLocationButton : false,
    //this.showsZoomControls : false,
    //this.locationInterval: 2000,
    //this.tilt : 0,
    //this.tiltEnabled : false,


  });

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





}
