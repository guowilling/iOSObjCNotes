//
//  SRSpecialText.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRSpecialText.h"

@implementation SRSpecialText

- (NSString *)description {
    return [NSString stringWithFormat:@"Stext: %@ range: %@", self.text, NSStringFromRange(self.range)];
}

@end
