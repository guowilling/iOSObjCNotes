//
//  SRTextPart.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRTextPart.h"

@implementation SRTextPart

- (NSString *)description {
    return [NSString stringWithFormat:@"text: %@ range: %@", self.text, NSStringFromRange(self.range)];
}

@end
