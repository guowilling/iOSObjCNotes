
#import "LocationHelper.h"
#import "CityHelper.h"

@interface LocationHelper () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, copy) LocationBlock locationBlock;

@end

@implementation LocationHelper

+ (LocationHelper *)sharedLocationManager {

    static LocationHelper *instance;
    @synchronized (self) {
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            instance = [[self alloc] init];
        });
    }
    return instance;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }
    return self;
}

- (void)currentLocation:(LocationBlock)locationBlock {
    
    self.locationBlock = locationBlock;
    
    if ([CLLocationManager locationServicesEnabled]) {
        CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
        if (status == kCLAuthorizationStatusNotDetermined) {
            [_locationManager requestAlwaysAuthorization];
        } else if (status == kCLAuthorizationStatusDenied) {
            [SVProgressHUDManager showErrorWithStatus:@"请前往设置->隐私->定位中打开定位服务"];
        } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse ||
                   status == kCLAuthorizationStatusAuthorizedAlways) {
            [_locationManager startUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [_locationManager startUpdatingLocation];
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *location = [locations lastObject];
    [_locationManager stopUpdatingLocation];
    CLGeocoder *gecoder = [[CLGeocoder alloc] init];
    [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placeMark = [placemarks firstObject];
        if (placeMark) {
            NSString *cityID;
            if (placeMark.locality) {
                cityID = placeMark.locality;
            } else {
                cityID = placeMark.administrativeArea;
            }
            NSString *cityName = [CityHelper getCityNameByID:cityID];
            if ([cityName isEqualToString:@"未知的城市"]) {
                cityName = [cityID stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }
            if (_locationBlock) {
                _locationBlock(location, cityName);
            }
        }
    }];
}

@end
