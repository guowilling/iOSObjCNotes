//
//  AppInfo.m
//  应用程序管理(代码)
//
//  Created by 郭伟林 on 15/9/15.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "AppInfo.h"

@implementation AppInfo

@synthesize image = _image;

- (UIImage *)image {
    if (_image == nil) {
        _image = [UIImage imageNamed:self.icon];
    }
    return _image;
}

+ (NSArray *)appInfos {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self appInfoWithDict:dict]];
    }
    return arrayM;
}

+ (instancetype)appInfoWithDict:(NSDictionary *)dict {
    // self是类
    return [[self alloc] initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict {
    // self是对象
    if (self = [super init]) {
        // 通过字典给属性赋值
        // self.name = dict[@"name"];
        // self.icon = dict[@"icon"];
        
        // KVC: key value coding键值编码
        // [self setValue:dict[@"name"] forKeyPath:@"name"];
        // [self setValue:dict[@"icon"] forKeyPath:@"icon"];
        [self setValuesForKeysWithDictionary:dict]; // 本质上就是调用上两句代码
    }
    return self;
}

@end
