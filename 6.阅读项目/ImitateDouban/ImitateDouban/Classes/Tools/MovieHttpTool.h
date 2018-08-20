
#import <Foundation/Foundation.h>

@class DetailMovieModel;

typedef void (^MovieInfoBlock)(DetailMovieModel *movieModel);

@interface MovieHttpTool : NSObject

+ (void)getHotMovieWithStart:(NSInteger)start arrayBlock:(ArrayBlock)arrayBlock;

+ (void)getComingsoonWithStart:(NSInteger)start arrayBlock:(ArrayBlock)arrayBlock;

+ (void)getMovieInfoWithID:(NSString *)movieID movieInfoBlock:(MovieInfoBlock)movieInfoBlock;

@end
