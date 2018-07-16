package com.jzoom.flutteramap;

import android.content.Context;
import android.location.Location;

import com.amap.api.maps.AMap;
import com.amap.api.maps.CameraUpdateFactory;
import com.amap.api.maps.model.LatLng;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class AMapViewManager {


    private MethodChannel channel;
    Map<String,Object> mapViewOptions;


    public AMapViewManager(MethodChannel channel){
        this.channel = channel;
    }


    public AMapView createView(Context context){
        final AMapView view = new AMapView(context);
        view.getMap().setOnMyLocationChangeListener(new AMap.OnMyLocationChangeListener() {
            @Override
            public void onMyLocationChange(Location location) {
                Map<String,Object> map = new HashMap<String,Object>();
                map.put("latitude",location.getLatitude());
                map.put("longitude",location.getLongitude());
                map.put("accuracy",location.getAccuracy());
                map.put("altitude",location.getAltitude());
                map.put("speed",location.getSpeed());
                map.put("timestamp",(double)location.getTime() / 1000);
                map.put("id",view.getKey());
                channel.invokeMethod("locationUpdate",map);
            }
        });
        return view;
    }

    public void updateProps(AMapView view, Map<String,Object> mapView){

        AMap aMap = view.getMap();

        aMap.setMapType((Integer) mapView.get("mapType"));

        aMap.moveCamera(CameraUpdateFactory.zoomTo(   (float)(double)(Double) mapView.get("zoomLevel")  ));
        aMap.setMaxZoomLevel( (float)(double)(Double) mapView.get("maxZoomLevel")    );
        aMap.setMinZoomLevel( (float)(double)(Double) mapView.get("minZoomLevel")    );

        aMap.setMyLocationEnabled((Boolean) mapView.get("showsUserLocation"));


        Map<String,Object> centerCoordinate = (Map<String, Object>) mapView.get("centerCoordinate");

        if(centerCoordinate!=null){
            aMap.moveCamera(CameraUpdateFactory.changeLatLng(new LatLng(
                    (Double)centerCoordinate.get("latitude"),
                    (Double) centerCoordinate.get("longitude"))));
        }


    }




}

