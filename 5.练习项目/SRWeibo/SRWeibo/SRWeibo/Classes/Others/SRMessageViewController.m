//
//  SRMessageViewController.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/26.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRMessageViewController.h"

@implementation SRMessageViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(composeMessage)];
}

- (void)composeMessage {
    NSLog(@"composeMessage");
}

@end
