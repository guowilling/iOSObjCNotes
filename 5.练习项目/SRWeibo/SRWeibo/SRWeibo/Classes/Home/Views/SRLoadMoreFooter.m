//
//  SRLoadMoreFooter.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRLoadMoreFooter.h"

@implementation SRLoadMoreFooter

+ (instancetype)loadMoreFooter {
    return [[[NSBundle mainBundle] loadNibNamed:@"SRLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
