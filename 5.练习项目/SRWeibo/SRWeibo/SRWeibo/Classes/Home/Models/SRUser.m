//
//  SRUser.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRUser.h"

@implementation SRUser

//- (BOOL)isVip {
//    return _mbtype > 2;
//}

- (void)setMbtype:(int)mbtype {
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

@end
