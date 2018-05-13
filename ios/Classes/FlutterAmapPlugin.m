#import "FlutterAmapPlugin.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import "AMapViewManager.h"
#import "AMapView.h"
#import <CoreLocation/CLLocation.h>

@interface FlutterAmapPlugin()

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
        NSDictionary* title = args[@"title"];
        
        [self show:mapView title:title];
        result(@YES);
        
    } else if([@"dismiss" isEqualToString:method ]) {
        [self dismiss];
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

-(void)show:(NSDictionary*)mapView title:(NSDictionary*)title{
    NSLog(@"%lf", kCLDistanceFilterNone);
    //将属性映射到view上面
    UIViewController *vc = [[UIViewController alloc] init ];
    AMapView* amapView = (AMapView*)[self.manager view];
    [self updateViewProps:mapView amapView:amapView];
    
    vc.view = amapView;
    self.mapViewController = vc;
    vc.title = title[@"title"];
    BOOL showsNavBar = [title[@"showNavBar"] boolValue];
    
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithTitle:@"Close"                 style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    btnRight.tintColor = [UIColor blueColor];
    
    vc.navigationItem.rightBarButtonItems = @[btnRight];
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:vc];
    if(!showsNavBar){
        [navController setNavigationBarHidden:YES animated:NO];
    }
    
    
    // navController.navigationBar.translucent = NO;
    [self.root presentViewController:navController animated:true completion:nil];
}




@end
