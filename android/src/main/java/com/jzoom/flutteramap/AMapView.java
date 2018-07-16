package com.jzoom.flutteramap;

import android.content.Context;

import com.amap.api.maps.TextureMapView;

public class AMapView extends TextureMapView {
    public AMapView(Context context) {
        super(context);
    }

    private String key;


    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }
}
