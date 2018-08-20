//
//  SRDiscoverViewController.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/26.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRDiscoverViewController.h"
#import "SRSearchBar.h"

@implementation SRDiscoverViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.navigationItem.titleView = [[UISearchBar alloc] init];
    SRSearchBar *searchBar = [SRSearchBar searchBar];
    self.navigationItem.titleView = searchBar;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.navigationItem.titleView endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
