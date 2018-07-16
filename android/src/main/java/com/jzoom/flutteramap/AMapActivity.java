package com.jzoom.flutteramap;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;

public class AMapActivity extends AppCompatActivity {


    private AMapView mapView;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        mapView = FlutterAmapPlugin.manager.createView(this);
        mapView.onCreate(savedInstanceState);
        FlutterAmapPlugin.manager.updateProps(mapView, FlutterAmapPlugin.manager.mapViewOptions);
        setContentView(mapView);

    }


    @Override
    protected void onResume() {
        super.onResume();
        mapView.onResume();
    }

    @Override
    protected void onPause() {
        super.onPause();
        mapView.onPause();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        mapView.onDestroy();

    }


}
