
#import "DetailMovieModel.h"
#import "RatingModel.h"
#import "CastModel.h"
#import "AvatarsModel.h"

@implementation DetailMovieModel

- (id)initWithDictionary:(NSDictionary *)dic {
    
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
        if (dic[@"id"]) {
            self.ID = [NSString stringWithFormat:@"%@", dic[@"id"]];
        }
        if (dic[@"collect_count"]) {
            self.collect_count = [NSString stringWithFormat:@"%@", dic[@"collect_count"]];
        }
        if (dic[@"rating"]) {
            self.rating = [[RatingModel alloc] initWithDictionary:dic[@"rating"]];
        }
        if (dic[@"genres"]) {
            self.genres = [[NSMutableArray alloc] initWithArray:dic[@"genres"]];
        }
        if (dic[@"casts"]) {
            NSArray *casts = dic[@"casts"];
            NSMutableArray *arrayM = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in casts) {
                CastModel *castM = [[CastModel alloc] initWithDictionary:dict];
                [arrayM addObject:castM];
            }
            self.casts = arrayM;
        }
        if (dic[@"directors"]) {
            NSArray *directors = dic[@"directors"];
            NSMutableArray *arrayM = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in directors) {
                CastModel *castM = [[CastModel alloc] initWithDictionary:dict];
                [arrayM addObject:castM];
            }
            self.directors = arrayM;
        }
        if (dic[@"images"]) {
            self.images = [[AvatarsModel alloc] initWithDictionary:dic[@"images"]];
        }
        if (dic[@"aka"]) {
            self.aka = [[NSMutableArray alloc] initWithArray:dic[@"aka"]];
        }
        if (dic[@"countries"]) {
            self.countries = [[NSMutableArray alloc] initWithArray:dic[@"countries"]];
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForKeyPath:(NSString *)keyPath {
    
    return nil;
}

@end
