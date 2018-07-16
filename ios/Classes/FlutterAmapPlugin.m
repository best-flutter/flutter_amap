#import "FlutterAmapPlugin.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import "AMapViewManager.h"
#import "AMapView.h"
#import <CoreLocation/CLLocation.h>

@interface FlutterAmapPlugin()
{
    NSMutableDictionary* _dic;
}
@property (nonatomic, assign) UIViewController *root;
@property (nonatomic, assign) FlutterMethodChannel *channel;
@property (nonatomic,retain) AMapViewManager *manager;

@property (nonatomic,weak) UIViewController* mapViewController;

@end

@implementation FlutterAmapPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"flutter_amap" binaryMessenger:[registrar messenger]];
    
    UIViewController *root = UIApplication.sharedApplication.delegate.window.rootViewController;
    FlutterAmapPlugin* instance = [[FlutterAmapPlugin alloc] initWithRoot:root channel:channel];
    [registrar addMethodCallDelegate:instance channel:channel];
}
/*
-(void)dealloc{
    NSLog(@"self dealloc");
}
 */



- (id)initWithRoot:(UIViewController *)root channel:(FlutterMethodChannel *)channel {
    if (self = [super init]) {
        self.root = root;
        self.channel = channel;
        self.manager = [[AMapViewManager alloc]initWithMessageChannel:channel];
        _dic = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString* method = call.method;
    if ([@"setApiKey" isEqualToString:method]) {
        [AMapServices sharedServices].apiKey = call.arguments;
        result(@YES);
    } else if ([@"show" isEqualToString:method]){
        NSDictionary *args = call.arguments;
        NSDictionary* mapView = args[@"mapView"];
        NSString* title = args[@"id"];
        
        [self show:mapView key:title];
        result(@YES);
        
    } else if([@"dismiss" isEqualToString:method ]) {
        [self dismiss];
        result(@YES);
    }else if([@"rect" isEqualToString:method ]) {
        
         NSDictionary *args = call.arguments;
        double x = [args[@"x"] doubleValue];
        double y = [args[@"y"] doubleValue];
        double width = [args[@"width"] doubleValue];
        double height = [args[@"height"] doubleValue];
        NSString* key = args[@"id"];
        
        UIView* view = _dic[key];
        view.frame = CGRectMake(x, y, width, height);
    }else if([@"remove" isEqualToString:method ]) {
        NSDictionary *args = call.arguments;
        NSString* key = args[@"id"];
        [self remove: key ];
        result(@YES);
    }else if([@"hide" isEqualToString:method ]) {
        NSDictionary *args = call.arguments;
        NSString* key = args[@"id"];
        BOOL hide = [args[@"hide"]boolValue];
        UIView* view = _dic[key];
        view.hidden = hide;
        result(@YES);
    }else {
        result(FlutterMethodNotImplemented);
    }
}

-(void)dismiss{
    if(self.mapViewController){
        [self.root dismissViewControllerAnimated:true completion:nil];
        self.mapViewController = nil;
    }
}

-(void)updateViewProps:(NSDictionary*)mapView amapView:(AMapView*)amapView{
    amapView.showsScale = [mapView[@"showsScale"]boolValue];
    amapView.showsLabels =[mapView[@"showsLabels"]boolValue];
    amapView.showsCompass =[mapView[@"showsCompass"]boolValue];
    amapView.showsBuildings =[mapView[@"showsBuildings"]boolValue];
    amapView.showsIndoorMap =[mapView[@"showsIndoorMap"]boolValue];
    amapView.showsUserLocation =[mapView[@"showsUserLocation"]boolValue];
    amapView.showsIndoorMapControl =[mapView[@"showsIndoorMapControl"]boolValue];
    
    
    amapView.zoomEnabled =[mapView[@"zoomEnabled"]boolValue];
    amapView.distanceFilter =[mapView[@"distanceFilter"]doubleValue];
    
    amapView.zoomLevel =[mapView[@"zoomLevel"]doubleValue];
    amapView.minZoomLevel =[mapView[@"minZoomLevel"]doubleValue];
    amapView.maxZoomLevel =[mapView[@"maxZoomLevel"]doubleValue];
    amapView.rotateEnabled =[mapView[@"rotateEnabled"]boolValue];
    amapView.rotationDegree =[mapView[@"rotationDegree"]doubleValue];
    amapView.scrollEnabled =[mapView[@"scrollEnabled"]boolValue];
    
    amapView.mapType =[mapView[@"mapType"]integerValue];
    
    NSDictionary* centerCoordinate = [mapView objectForKey:@"centerCoordinate"];
    if(centerCoordinate && centerCoordinate!=(id)[NSNull null]){
        CLLocationCoordinate2D center = (CLLocationCoordinate2D){
            [centerCoordinate[@"latitude"]doubleValue], [centerCoordinate[@"longitude"]doubleValue]
        };
        amapView.centerCoordinate = center;
    }
    
    NSDictionary* limitRegion = [mapView objectForKey:@"limitRegion"];
    if(limitRegion && limitRegion!=(id)[NSNull null]){
        amapView.limitRegion = MACoordinateRegionMake(
                                                      (CLLocationCoordinate2D){[limitRegion[@"latitude"]doubleValue], [limitRegion[@"longitude"]doubleValue]},
                                                      (MACoordinateSpan){ [limitRegion[@"latitudeDelta"]doubleValue], [limitRegion[@"longitudeDelta"]doubleValue]
                                                      }
                                                      );
    }
    
    NSDictionary* region = [mapView objectForKey:@"region"];
    if(region && region!=(id)[NSNull null]){
        amapView.region = MACoordinateRegionMake(
                                                 (CLLocationCoordinate2D){[region[@"latitude"]doubleValue], [region[@"longitude"]doubleValue]},
                                                 (MACoordinateSpan){ [region[@"latitudeDelta"]doubleValue], [region[@"longitudeDelta"]doubleValue]
                                                 }
                                                 );
    }
    
}

-(void)show:(NSDictionary*)mapView key:(NSString*)key{
   NSLog(@"%lf", kCLDistanceFilterNone);
    //将属性映射到view上面
    AMapView* amapView = (AMapView*)[self.manager view];
    amapView.key = key;
    [self updateViewProps:mapView amapView:amapView];
    _dic[key]  = amapView;
    // navController.navigationBar.translucent = NO;
    [self.root.view addSubview:amapView];
    
}


-(void)remove : (NSString*) key{
    AMapView* view = _dic[key] ;
    [view removeFromSuperview];
    [_dic removeObjectForKey:key];
    
}



@end
