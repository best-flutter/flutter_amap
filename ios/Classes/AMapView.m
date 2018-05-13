//
//  AMapView.m
//  flutter_amap
//
//  Created by JZoom on 2018/5/13.
//

#import "AMapView.h"

@implementation AMapView

- (id)init {
    if(self = [super init]){
       
    }
    return self;
}

-(void)dealloc{
    
}

// 如果在地图未加载的时候调用改方法，需要先将 region 存起来，等地图加载完成再设置
- (void)setRegion:(MACoordinateRegion)region {
    if (self.loaded) {
        super.region = region;
    } else {
        self.initialRegion = region;
    }
}

-(void)onLoadFnish{
    
    if(self.initialRegion.center.latitude!=0){
        self.region = self.initialRegion;
    }
    
    
}


@end
