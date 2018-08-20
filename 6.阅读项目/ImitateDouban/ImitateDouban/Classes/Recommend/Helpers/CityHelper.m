
#import "CityHelper.h"
#import "HotCityModel.h"

@implementation CityHelper

+ (void)getHotCitiesInfo:(ArrayBlock)arrayBlock {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"hotCities" ofType:@"plist"];
    NSArray *hotCities = [[NSArray alloc] initWithContentsOfFile:filePath];
    NSMutableArray *hotCitiesModel = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in hotCities) {
        HotCityModel *model = [[HotCityModel alloc] initWithDictionary:dict];
        [hotCitiesModel addObject:model];
    }
    if (arrayBlock) {
        arrayBlock(hotCitiesModel);
    }
}

+ (NSString *)getCityNameByID:(NSString *)cityID{
    
    NSString *allCityNameFilePath = [[NSBundle mainBundle] pathForResource:@"AllCityName" ofType:@""];
    NSString *allCityName = [[NSString alloc] initWithContentsOfFile:allCityNameFilePath encoding:NSUTF8StringEncoding error:nil];
    
    NSString *allCityIDFilePath = [[NSBundle mainBundle] pathForResource:@"AllCityID" ofType:@""];
    NSString *allCityID = [[NSString alloc] initWithContentsOfFile:allCityIDFilePath encoding:NSUTF8StringEncoding error:nil];

    int index = -1;
    NSArray *cityNames = [allCityName componentsSeparatedByString:@"city="];
    NSArray *cityIDs = [allCityID componentsSeparatedByString:@"uid="];

    for (int i = 0; i < cityIDs.count; i++) {
        if ([cityIDs[i] compare:cityID options:NSCaseInsensitiveSearch] == 0) {
            index = i;
            break;
        }
    }
    if (index == -1) {
        return @"未知的城市";
    }
    return cityNames[index];
}

+ (NSString *)getCityIDByName:(NSString *)cityName {
    
    NSString *allCityNameFilePath = [[NSBundle mainBundle] pathForResource:@"AllCityName" ofType:@""];
    NSString *allCityName = [[NSString alloc] initWithContentsOfFile:allCityNameFilePath encoding:NSUTF8StringEncoding error:nil];
    
    NSString *allCityIDFilePath = [[NSBundle mainBundle] pathForResource:@"AllCityID" ofType:@""];
    NSString *allCityID = [[NSString alloc] initWithContentsOfFile:allCityIDFilePath encoding:NSUTF8StringEncoding error:nil];
    
    int cityID = -1;
    NSArray *cityNames = [allCityName componentsSeparatedByString:@"city="];
    NSArray *cityIDs = [allCityID componentsSeparatedByString:@"uid="];

    for (int i = 0; i < [cityNames count]; i++) {
        if ([cityNames[i] isEqualToString:cityName]) {
            cityID = i;
            break;
        }
    }
    if (cityID == -1) {
        return @"未知的城市ID";
    }
    return cityIDs[cityID];
}

+ (NSArray *)getAllCityName {
    
    NSString *allCityNameFilePath = [[NSBundle mainBundle] pathForResource:@"AllCityName" ofType:@""];
    NSString *allCityNameString = [[NSString alloc] initWithContentsOfFile:allCityNameFilePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *allCityName = [allCityNameString componentsSeparatedByString:@"city="];
    return allCityName;
}

@end
