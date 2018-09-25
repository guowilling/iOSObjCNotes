//
//  NJSexBox.m
//  32-键盘处理
//
//  Created by 李南江 on 14-2-9.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "GWSexBox.h"

@implementation GWSexBox

+ (instancetype)sexBox {
    
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
}

- (IBAction)sexChanged {
    
    if (_manBtn.enabled) {
        _manBtn.enabled   = NO;
        _womanBtn.enabled = YES;
    } else {
        _manBtn.enabled   = YES;
        _womanBtn.enabled = NO;
    }
}

@end
