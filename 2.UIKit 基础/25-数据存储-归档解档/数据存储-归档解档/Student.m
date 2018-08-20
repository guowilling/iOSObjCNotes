//
//  Student.m
//  数据存储-归档解档
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "Student.h"

static NSString * const cNumber = @"number";

@implementation Student

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    
    NSLog(@"%s", __func__);
    [aCoder encodeInteger:self.number forKey:cNumber];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        NSLog(@"%s", __func__);
        self.number = [aDecoder decodeIntegerForKey:cNumber];
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%p, name: %@, age: %zd, number: %zd", self, self.name, self.age, self.number];
}

@end
