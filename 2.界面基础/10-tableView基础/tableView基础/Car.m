//
//  Car.m
//  tableView基础
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "Car.h"

@implementation Car

+ (NSArray *)carsWithArray:(NSArray *)array {
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        Car *car = [self carWithDcit:dict];
        [arrayM addObject:car];
    }
    return arrayM;
}

+ (instancetype)carWithDcit:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> {name: %@, icon: %@}", self.class, self,self.name, self.icon];
}

@end
