# flutter_amap

高德地图3d flutter组件。

展示原生android、ios高德地图，并与flutter交互。

注意：随着flutter版本的提升， 本项目也会随之更新，目前这个版本只能在单独的controller或者activity中打开高德地图。


## Getting Started

### 集成高德地图android版本

1、先申请一个apikey
http://lbs.amap.com/api/android-sdk/guide/create-project/get-key

2、在AndroidManifest.xml中增加
```
 <meta-data
            android:name="com.amap.api.v2.apikey"
            android:value="你的Key" />
```

3、增加对应的权限：

```
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.CHANGE_CONFIGURATION" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
```      

4、增加要显示的activity:

```
<activity android:name="com.jzoom.flutteramap.AMapActivity" android:theme="@style/Theme.AppCompat.Light.DarkActionBar"/>
```

### 集成高德地图ios版本

1、申请一个key
http://lbs.amap.com/api/ios-sdk/guide/create-project/get-key

直接在dart文件中设置key

```
import 'package:flutter_amap/flutter_amap.dart';
   
   void main(){
     FlutterAmap.setApiKey("你的key");
     runApp(ne w MyApp());
   }
```

2、在info.plist中增加:

```
<key>NSLocationWhenInUseUsageDescription</key>
<string>要用定位</string>
```


## How to use

先导入dart包
修改pubspec.yaml，增加依赖：

```
dependencies:
  flutter_amap: "^0.0.1"
```


在要用的地方导入:

```
import 'package:flutter_amap/flutter_amap.dart';
```

然后就可以使用了

```
 FlutterAmap amap = new FlutterAmap();
 
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

```

## Feature

* IOS Support
* Android Support
* Support for full screen map
* Support for location change update
* Support for basic map options




















