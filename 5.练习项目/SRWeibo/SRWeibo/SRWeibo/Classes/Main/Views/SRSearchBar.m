//
//  SRSearchBar.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/26.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRSearchBar.h"

@implementation SRSearchBar

+ (instancetype)searchBar {
    
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.width       = SRScreenW;
        self.height      = 30;
        self.font        = [UIFont systemFontOfSize:12];
        self.placeholder = @"请输入搜索条件";
        self.background  = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.width        = 30;
        searchIcon.height       = 30;
        searchIcon.image        = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.contentMode  = UIViewContentModeCenter;
        self.leftView           = searchIcon;
        self.leftViewMode       = UITextFieldViewModeAlways;
    }
    return self;
}

@end
