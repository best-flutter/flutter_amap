//
//  AMapViewManager.h
//  flutter_amap
//
//  Created by JZoom on 2018/5/13.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
@interface AMapViewManager : NSObject


@property (nonatomic, assign) FlutterMethodChannel *channel;


- (UIView *)view;

-(id)initWithMessageChannel:(FlutterMethodChannel*)channel;
@end
