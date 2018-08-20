
#import "MovieHttpTool.h"
#import "MovieModel.h"
#import "DetailMovieModel.h"

@implementation MovieHttpTool

+ (void)getHotMovieWithStart:(NSInteger)start arrayBlock:(ArrayBlock)arrayBlock {
    
    NSString *urlSting = [NSString stringWithFormat:@"%@?count=10&start=%zd", HotMovie_URL, start];
    NSLog(@"HotMovie_URL: %@",urlSting);
    [HttpTools GET:urlSting params:nil success:^(id json) {
        NSMutableArray *arrayM = [[NSMutableArray alloc] init];
        if ([json[@"subjects"] isKindOfClass:[NSArray class]]) {
            NSArray *subjectsArr = json[@"subjects"];
            for (NSDictionary *dict in subjectsArr) {
                MovieModel *movieM = [[MovieModel alloc] initWithDictionary:dict];
                [arrayM addObject:movieM];
            }
        }
        if (arrayBlock) {
            arrayBlock(arrayM);
        }
    } failure:^(NSError *error) {
        [SVProgressHUDManager showErrorWithStatus:@"网络出错啦"];
    }];
}

+ (void)getComingsoonWithStart:(NSInteger)start arrayBlock:(ArrayBlock)arrayBlock {
    
    NSString *urlSting = [NSString stringWithFormat:@"%@?count=10&start=%zd", ComingsoonMovie_URL, start];
    NSLog(@"ComingsoonMovie_URL: %@",urlSting);
    [HttpTools GET:urlSting params:nil success:^(id json) {
        NSMutableArray *arrayM = [[NSMutableArray alloc] init];
        if ([json[@"subjects"] isKindOfClass:[NSArray class]]) {
            NSArray *subjectsArr = json[@"subjects"];
            for (NSDictionary *dict in subjectsArr) {
                MovieModel *movieM = [[MovieModel alloc] initWithDictionary:dict];
                [arrayM addObject:movieM];
            }
        }
        if (arrayBlock) {
            arrayBlock(arrayM);
        }
    } failure:^(NSError *error) {
        [SVProgressHUDManager showErrorWithStatus:@"网络出错啦"];
    }];
}

+ (void)getMovieInfoWithID:(NSString *)movieID movieInfoBlock:(MovieInfoBlock)movieInfoBlock {
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", MovieInfo_URL, movieID];
    NSLog(@"MovieInfo_URL: %@",urlString);
    [HttpTools GET:urlString params:nil success:^(id json) {
        DetailMovieModel *detailMovieModel = [[DetailMovieModel alloc] init];
        if ([json isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = json;
            detailMovieModel = [[DetailMovieModel alloc] initWithDictionary:dict];
        }
        movieInfoBlock(detailMovieModel);
    } failure:^(NSError *error) {
        [SVProgressHUDManager showErrorWithStatus:@"网络出错啦"];
    }];
}

@end
