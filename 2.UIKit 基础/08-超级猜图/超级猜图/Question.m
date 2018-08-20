//
//  Question.m
//  超级猜图
//
//  Created by 郭伟林 on 15/9/16.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "Question.h"

@implementation Question

@synthesize image = _image;

- (UIImage *)image {
    if (_image == nil) {
        _image = [UIImage imageNamed:self.icon];
    }
    return _image;
}

+ (NSArray *)questions {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"questions.plist" ofType:nil]];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self questionWithDict:dict]];
    }
    return arrayM;
}

+ (instancetype)questionWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init]; // 注意: 只能在initXxx方法中对self赋值
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        [self randomOptions]; // 打乱答题区按钮顺序
    }
    return self;
}

- (void)randomOptions {
    self.options = [self.options sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
}

// 相当于java中的toString()
- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> {answer: %@, icon: %@, title: %@, options: %@}", self.class, self, self.answer, self.icon, self.title, self.options];
}

@end
