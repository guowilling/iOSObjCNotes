//
//  Person.m
//  数据存储-归档解档
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "Person.h"

static NSString * const cName = @"name";
static NSString * const cAge  = @"age";

@implementation Person

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    NSLog(@"%s", __func__);
    
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:cName];
        self.age = [aDecoder decodeIntegerForKey:cAge];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    NSLog(@"%s", __func__);
    
    [aCoder encodeObject:self.name forKey:cName];
    [aCoder encodeInteger:self.age forKey:cAge];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%p, name: %@, age: %zd", self, self.name, self.age];
}

@end
