
#import <Foundation/Foundation.h>

@class AvatarsModel;

@interface CastModel : NSObject

/** 演员图片（大中小） */
@property (nonatomic ,strong) AvatarsModel *avatars;
/** 演员主页 */
@property (nonatomic ,strong) NSString *alt;
/** ID */
@property (nonatomic ,strong) NSString *ID;
/** 名字 */
@property (nonatomic ,strong) NSString *name;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
