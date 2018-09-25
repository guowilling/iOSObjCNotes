//
//  CarGroup.m
//  tableView基础
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "CarGroup.h"
#import "Car.h"

@implementation CarGroup

+ (NSArray *)carGroups {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cars_total" ofType:@"plist"]];
    NSMutableArray * arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self carGroupWithDcit:dict]];
    }
    return arrayM;
}

+ (instancetype)carGroupWithDcit:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if ([super init]) {
        [self setValue:dict[@"title"] forKey:@"title"];
        [self setCars:[Car carsWithArray:dict[@"cars"]]];

//        // 一层字典转模型
//        [self setValuesForKeysWithDictionary:dict];
//        // 二层字典转模型
//        NSMutableArray *arrayM = [NSMutableArray array];
//        for (NSDictionary *dict in self.cars) {
//            Car *car = [Car carWithDcit:dict];
//            [arrayM addObject:car];
//        }
//        self.cars = arrayM;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> {title: %@, cars: %@}", self.class, self, self.title, self.cars];
}

@end
