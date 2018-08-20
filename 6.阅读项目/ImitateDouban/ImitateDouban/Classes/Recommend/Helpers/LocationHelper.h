
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void (^LocationBlock)(CLLocation *currentLocation, NSString *cityName);

@interface LocationHelper : NSObject

+ (LocationHelper *)sharedLocationManager;

- (void)currentLocation:(LocationBlock)locationBlock;

@end
