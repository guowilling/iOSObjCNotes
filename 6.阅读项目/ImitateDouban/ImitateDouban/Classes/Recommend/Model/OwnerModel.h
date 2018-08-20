
#import <Foundation/Foundation.h>

@interface OwnerModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *alt;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *large_avatar;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
