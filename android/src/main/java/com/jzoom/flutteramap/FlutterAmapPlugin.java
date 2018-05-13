package com.jzoom.flutteramap;

import android.app.Activity;
import android.content.Intent;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterAmapPlugin
 */
public class FlutterAmapPlugin implements MethodCallHandler {

  private Activity root;

  static AMapViewManager manager;

  public FlutterAmapPlugin(Activity activity,MethodChannel channel) {
    this.root = activity;
    this.manager = new AMapViewManager(channel);
  }



  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_amap");
    channel.setMethodCallHandler(new FlutterAmapPlugin( registrar.activity(),channel ));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    String method = call.method;
    if ("show".equals(method)) {
        Map<String,Object> args = (Map<String, Object>) call.arguments;
      manager.mapViewOptions = (Map<String, Object>) args.get("mapView");

      Intent intent = new Intent(root,AMapActivity.class);
      root.startActivity(intent);

    }else if("setApiKey".equals(method)){
      result.success(true);
    }else if("dismiss".equals(method)){
        if(activity!=null){
            if(!activity.isFinishing()){
                activity.finish();
                activity = null;
            }
        }
        result.success(true);
    } else {
      result.notImplemented();
    }
  }



  static AMapActivity activity;
}
