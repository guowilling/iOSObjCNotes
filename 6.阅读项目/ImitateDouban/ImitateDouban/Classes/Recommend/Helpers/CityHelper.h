
#import <Foundation/Foundation.h>

@interface CityHelper : NSObject

+ (void)getHotCitiesInfo:(ArrayBlock)arrayBlock;

+ (NSArray *)getAllCityName;

+ (NSString *)getCityNameByID:(NSString *)cityID;

+ (NSString *)getCityIDByName:(NSString *)cityName;


@end
