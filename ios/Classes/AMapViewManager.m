//
//  AMapViewManager.m
//  flutter_amap
//
//  Created by JZoom on 2018/5/13.
//

#import "AMapViewManager.h"
#import "AMapView.h"

@interface AMapViewManager() <MAMapViewDelegate>
@end


@implementation AMapViewManager

- (UIView *)view {
    AMapView *mapView = [[AMapView alloc]init];
    mapView.centerCoordinate = CLLocationCoordinate2DMake(39.9242, 116.3979);
    mapView.zoomLevel = 10;
    mapView.delegate = self;
    return mapView;
}
-(id)initWithMessageChannel:(FlutterMethodChannel*)channel{
    if(self = [super init]){
        self.channel = channel;
    }
    return  self;
}

-(void)dealloc{
    NSLog(@"AMapViewManager dealloc");
}

/**
 * @brief 地图区域改变过程中会调用此接口 since 4.6.0
 * @param mapView 地图View
 */
- (void)mapViewRegionChanged:(AMapView *)mapView{}

/**
 * @brief 地图区域即将改变时会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(AMapView *)mapView regionWillChangeAnimated:(BOOL)animated{}

/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(AMapView *)mapView regionDidChangeAnimated:(BOOL)animated{}

/**
 * @brief 地图将要发生移动时调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(AMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{}

/**
 * @brief 地图移动结束后调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(AMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction{}

/**
 * @brief 地图将要发生缩放时调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(AMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction{}

/**
 * @brief 地图缩放结束后调用此接口
 * @param mapView       地图view
 * @param wasUserAction 标识是否是用户动作
 */
- (void)mapView:(AMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction{}

/**
 * @brief 地图开始加载
 * @param mapView 地图View
 */
- (void)mapViewWillStartLoadingMap:(AMapView *)mapView{
    
}

/**
 * @brief 地图加载成功
 * @param mapView 地图View
 */
- (void)mapViewDidFinishLoadingMap:(AMapView *)mapView{
    
    [mapView onLoadFnish];
    
}

/**
 * @brief 地图加载失败
 * @param mapView 地图View
 * @param error 错误信息
 */
- (void)mapViewDidFailLoadingMap:(AMapView *)mapView withError:(NSError *)error{
    
}

/**
 * @brief 根据anntation生成对应的View。
 
 注意：
 1、5.1.0后由于定位蓝点增加了平滑移动功能，如果在开启定位的情况先添加annotation，需要在此回调方法中判断annotation是否为MAUserLocation，从而返回正确的View。
 if ([annotation isKindOfClass:[MAUserLocation class]]) {
 return nil{}
 }
 
 2、请不要在此回调中对annotation进行select和deselect操作，此时annotationView还未添加到mapview。
 
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
//- (MAAnnotationView *)mapView:(AMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation

/**
 * @brief 当mapView新添加annotation views时，调用此接口
 * @param mapView 地图View
 * @param views 新添加的annotation views
 */
- (void)mapView:(AMapView *)mapView didAddAnnotationViews:(NSArray *)views{}

/**
 * @brief 当选中一个annotation view时，调用此接口. 注意如果已经是选中状态，再次点击不会触发此回调。取消选中需调用-(void)deselectAnnotation:animated:
 * @param mapView 地图View
 * @param view 选中的annotation view
 */
- (void)mapView:(AMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{}

/**
 * @brief 当取消选中一个annotation view时，调用此接口
 * @param mapView 地图View
 * @param view 取消选中的annotation view
 */
- (void)mapView:(AMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{}

/**
 * @brief 在地图View将要启动定位时，会调用此函数
 * @param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(AMapView *)mapView{
    
}

/**
 * @brief 在地图View停止定位后，会调用此函数
 * @param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(AMapView *)mapView{
    
}

/**
 * @brief 位置或者设备方向更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据)
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(AMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    [self.channel invokeMethod:@"locationUpdate" arguments:@{@"latitude": @(userLocation.coordinate.latitude),
                                               @"longitude": @(userLocation.coordinate.longitude),
                                               @"horizontalAccuracy": @(userLocation.location.horizontalAccuracy),
                                               @"verticalAccuracy":@(userLocation.location.verticalAccuracy),
                                               @"altitude": @(userLocation.location.altitude),
                                               @"speed": @(userLocation.location.speed),
                                               @"timestamp": @(userLocation.location.timestamp.timeIntervalSince1970),}];
  
    
}

/**
 * @brief 定位失败后，会调用此函数
 * @param mapView 地图View
 * @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(AMapView *)mapView didFailToLocateUserWithError:(NSError *)error{}

/**
 * @brief 拖动annotation view时view的状态变化
 * @param mapView 地图View
 * @param view annotation view
 * @param newState 新状态
 * @param oldState 旧状态
 */
- (void)mapView:(AMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState
   fromOldState:(MAAnnotationViewDragState)oldState{}

/**
 * @brief 根据overlay生成对应的Renderer
 * @param mapView 地图View
 * @param overlay 指定的overlay
 * @return 生成的覆盖物Renderer
 */
//- (MAOverlayRenderer *)mapView:(AMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay{}

/**
 * @brief 当mapView新添加overlay renderers时，调用此接口
 * @param mapView 地图View
 * @param overlayRenderers 新添加的overlay renderers
 */
- (void)mapView:(AMapView *)mapView didAddOverlayRenderers:(NSArray *)overlayRenderers{}

/**
 * @brief 标注view的accessory view(必须继承自UIControl)被点击时，触发该回调
 * @param mapView 地图View
 * @param view callout所属的标注view
 * @param control 对应的control
 */
- (void)mapView:(AMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{}

/**
 * @brief 标注view的calloutview整体点击时，触发改回调。
 * @param mapView 地图的view
 * @param view calloutView所属的annotationView
 */
- (void)mapView:(AMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view{}

/**
 * @brief 标注view被点击时，触发改回调。（since 5.7.0）
 * @param mapView 地图的view
 * @param view annotationView
 */
- (void)mapView:(AMapView *)mapView didAnnotationViewTapped:(MAAnnotationView *)view{}

/**
 * @brief 当userTrackingMode改变时，调用此接口
 * @param mapView 地图View
 * @param mode 改变后的mode
 * @param animated 动画
 */
- (void)mapView:(AMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated{}

/**
 * @brief 当openGLESDisabled变量改变时，调用此接口
 * @param mapView 地图View
 * @param openGLESDisabled 改变后的openGLESDisabled
 */
- (void)mapView:(AMapView *)mapView didChangeOpenGLESDisabled:(BOOL)openGLESDisabled{}

/**
 * @brief 当touchPOIEnabled == YES时，单击地图使用该回调获取POI信息
 * @param mapView 地图View
 * @param pois 获取到的poi数组(由MATouchPoi组成)
 */
- (void)mapView:(AMapView *)mapView didTouchPois:(NSArray *)pois{}

/**
 * @brief 单击地图回调，返回经纬度
 * @param mapView 地图View
 * @param coordinate 经纬度
 */
- (void)mapView:(AMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{}

/**
 * @brief 长按地图，返回经纬度
 * @param mapView 地图View
 * @param coordinate 经纬度
 */
- (void)mapView:(AMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate{}

/**
 * @brief 地图初始化完成（在此之后，可以进行坐标计算）
 * @param mapView 地图View
 */
- (void)mapInitComplete:(AMapView *)mapView{}

#if MA_INCLUDE_INDOOR
/**
 * @brief  室内地图出现,返回室内地图信息
 *
 *  @param mapView        地图View
 *  @param indoorInfo     室内地图信息
 */
- (void)mapView:(AMapView *)mapView didIndoorMapShowed:(MAIndoorInfo *)indoorInfo{}

/**
 * @brief  室内地图楼层发生变化,返回变化的楼层
 *
 *  @param mapView        地图View
 *  @param indoorInfo     变化的楼层
 */
- (void)mapView:(AMapView *)mapView didIndoorMapFloorIndexChanged:(MAIndoorInfo *)indoorInfo{}

/**
 * @brief  室内地图消失后,返回室内地图信息
 *
 *  @param mapView        地图View
 *  @param indoorInfo     室内地图信息
 */
- (void)mapView:(AMapView *)mapView didIndoorMapHidden:(MAIndoorInfo *)indoorInfo{}
#endif //end of MA_INCLUDE_INDOOR

/**
 * @brief 离线地图数据将要被加载, 调用reloadMap会触发该回调，离线数据生效前的回调.
 * @param mapView 地图View
 */
- (void)offlineDataWillReload:(AMapView *)mapView{}

/**
 * @brief 离线地图数据加载完成, 调用reloadMap会触发该回调，离线数据生效后的回调.
 * @param mapView 地图View
 */
- (void)offlineDataDidReload:(AMapView *)mapView{}
@end
