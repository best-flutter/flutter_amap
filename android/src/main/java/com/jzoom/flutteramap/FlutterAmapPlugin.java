package com.jzoom.flutteramap;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterAmapPlugin
 */
public class FlutterAmapPlugin implements MethodCallHandler {

  private FlutterActivity root;

  static AMapViewManager manager;

  public FlutterAmapPlugin(FlutterActivity activity, MethodChannel channel) {
    this.root = activity;
    this.manager = new AMapViewManager(channel);
  }



  /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_amap");
    channel.setMethodCallHandler(new FlutterAmapPlugin( (FlutterActivity) registrar.activity(),channel ));
  }

  private AMapView createView(String id){
      AMapView view = new AMapView(root);
      view.setKey(id);
      map.put(id,view);
      return view;
  }

  private Map<String,AMapView> map =  new ConcurrentHashMap<>();

  private AMapView getView(String id){
      return map.get(id);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    String method = call.method;
    if ("show".equals(method)) {
        Map<String,Object> args = (Map<String, Object>) call.arguments;
        Map<String,Object> mapViewOptions = (Map<String, Object>) args.get("mapView");
        final String id = (String) args.get("id");

        root.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                AMapView view = createView(id);
                view.onCreate(new Bundle());
                view.onResume();
                root.addContentView(  view,new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT,FrameLayout.LayoutParams.MATCH_PARENT));


            }
        });


    }else if("rect".equals(method)){
        Map<String,Object> args = (Map<String, Object>) call.arguments;
        final int x = (int)(double)(Double) args.get("x");
        final int y = (int)(double)(Double) args.get("y");
        final double width = (Double) args.get("width");
        final double height = (Double) args.get("height");
        String id = (String) args.get("id");

        final AMapView layout = getView(id);
        if(layout!=null){
           root.runOnUiThread(new Runnable() {
               @Override
               public void run() {
                   FrameLayout.LayoutParams params = (FrameLayout.LayoutParams) layout.getLayoutParams();
                   DisplayMetrics metrics = new DisplayMetrics();
                   root.getWindowManager().getDefaultDisplay().getMetrics(metrics);
                   params.leftMargin = (int) (x * metrics.scaledDensity);
                   params.topMargin = (int) (y * metrics.scaledDensity);


                   params.width = (int) ( width* metrics.scaledDensity);
                   params.height = (int) ( height* metrics.scaledDensity);
                   layout.setLayoutParams(params);
               }
           });
        }


    }else if("remove".equals(method)){
        Map<String,Object> args = (Map<String, Object>) call.arguments;
        String id = (String) args.get("id");
        View view = map.get(id);
        if(view != null){
            ViewGroup viewGroup = (ViewGroup) view.getParent();
            viewGroup.removeView(view);
        }
    }  else if("setApiKey".equals(method)){
      result.success(true);
    }else if("dismiss".equals(method)){

        result.success(true);
    } else {
      result.notImplemented();
    }
  }


}
