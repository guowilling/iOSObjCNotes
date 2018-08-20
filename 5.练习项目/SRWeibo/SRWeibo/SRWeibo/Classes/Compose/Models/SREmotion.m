//
//  SREmotion.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SREmotion.h"
#import "MJExtension.h"

@implementation SREmotion

MJCodingImplementation
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        self.chs = [aDecoder decodeObjectForKey:@"chs"];
//        self.png = [aDecoder decodeObjectForKey:@"png"];
//        self.code = [aDecoder decodeObjectForKey:@"code"];
//    }
//    return self;
//}

//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:self.chs forKey:@"chs"];
//    [aCoder encodeObject:self.png forKey:@"png"];
//    [aCoder encodeObject:self.code forKey:@"code"];
//}

- (BOOL)isEqual:(SREmotion *)object {
//    if (self == other) {
//        return YES;
//    } else {
//        return NO;
//    }
    return [self.chs isEqualToString:object.chs] || [self.code isEqualToString:object.code];
    
//    NSString *str1 = @"jack";
//    NSString *str2 = [NSString stringWithFormat:@"jack"];
//    [str1 isEqual:str2];        // NO  比较地址
//    [str1 isEqualToString:str2] // YES 比较内容
}

@end
