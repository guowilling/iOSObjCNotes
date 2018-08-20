
#import "MapViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "ALActionSheetView.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView  *mapView;

@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation MapViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavBar];
    
    [self setupMapView];
    
    [self addPointAnnotation];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupNavBar {
    
    self.title = @"地图";
    
    UIButton *navigation = [UIButton buttonWithType:UIButtonTypeCustom];
    [navigation setTitle:@"导航" forState:UIControlStateNormal];
    navigation.frame = CGRectMake(0, 0, 60, 40);
    [navigation setTitleColor:TheThemeColor forState:UIControlStateNormal];
    [navigation.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [navigation addTarget:self action:@selector(navigationAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:navigation];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -20;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, buttonItem];
}

- (void)navigationAction {

    ALActionSheetView *actionSheetView = [ALActionSheetView showActionSheetWithTitle:@"请选择地图"
                                                                   cancelButtonTitle:@"取消"
                                                              destructiveButtonTitle:nil
                                                                   otherButtonTitles:@[@"苹果地图"]
                                                                             handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
                                                                                 if (buttonIndex == 0) {
                                                                                     [self openSystemMapApp];
                                                                                 }
                                                                             }];
    [actionSheetView show];
}

- (void)setupMapView {
    
    _mapView = [[MKMapView alloc] init];
    _mapView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
}

- (void)addPointAnnotation {
    
    if ([NSString isAvailable:_geo]) {
        [SVProgressHUDManager showErrorWithStatus:@"地理编码出错可能你选的地方在冥王星"];
        return;
    }
    NSArray *coordinateArray = [[NSArray alloc] initWithArray:[_geo componentsSeparatedByString:@" "]];
    double latitude  = [coordinateArray[0] doubleValue];
    double longitude = [coordinateArray[1] doubleValue];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.04, 0.04);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [_mapView setRegion:region animated:YES];

    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.title = _activityName;
    annotation.subtitle = _address;
    annotation.coordinate = coordinate;
    
    [_mapView addAnnotation:annotation];
    [_mapView selectAnnotation:annotation animated:YES];
}

- (void)openSystemMapApp {
    
    if (iOS7) {
        NSArray *coordinateArr = [[NSArray alloc] initWithArray:[_geo componentsSeparatedByString:@" "]];
        double latitude  = [coordinateArr[0] doubleValue];
        double longitude = [coordinateArr[1] doubleValue];
        CLLocationCoordinate2D toCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:toCoordinate addressDictionary:nil]];
        toLocation.name = _address;
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                       MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    } else {
        [SVProgressHUDManager showErrorWithStatus:@"系统不支持打开地图"];
    }
}

@end
