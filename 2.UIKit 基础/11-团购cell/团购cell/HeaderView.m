//
//  HeaderScrollView.m
//  tableView基础
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "HeaderView.h"


@implementation HeaderView

+ (instancetype)headerView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])  owner:nil options:nil] lastObject];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        NSLog(@"%s", __func__);
    }
    return self;
}

- (void)awakeFromNib {
    NSLog(@"%s", __func__);
}

@end
