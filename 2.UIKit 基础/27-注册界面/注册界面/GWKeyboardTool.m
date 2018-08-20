//
//  HMKeyboardTool.m
//  作业-注册
//
//  Created by Vincent_Guo on 14-8-27.
//  Copyright (c) 2014年 vgios. All rights reserved.
//

#import "GWKeyboardTool.h"

@implementation GWKeyboardTool

+ (instancetype)keyboardTool {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
}

- (IBAction)previous:(id)sender {
    
    if ([self.delgate respondsToSelector:@selector(keyboardTool:didClickItemType:)]) {
        [self.delgate keyboardTool:self didClickItemType:KeyboardItemTypePrevious];
    }
}

- (IBAction)next:(id)sender {
    
    if ([self.delgate respondsToSelector:@selector(keyboardTool:didClickItemType:)]) {
        [self.delgate keyboardTool:self didClickItemType:KeyboardItemTypeNext];
    }
    
}

- (IBAction)done:(id)sender {
    
    if ([self.delgate respondsToSelector:@selector(keyboardTool:didClickItemType:)]) {
        [self.delgate keyboardTool:self didClickItemType:KeyboardItemTypeDone];
    }
}

@end
