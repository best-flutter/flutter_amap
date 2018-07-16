//
//  AMapView.h
//  flutter_amap
//
//  Created by JZoom on 2018/5/13.
//

#import <MAMapKit/MAMapKit.h>

@interface AMapView : MAMapView

@property(nonatomic) BOOL loaded;
@property(nonatomic) MACoordinateRegion initialRegion;

@property (nonatomic,retain) NSString* key;

-(void)onLoadFnish;

@end
