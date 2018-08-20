//
//  HYWLogin&registController.m
//  BSBuDeJie
//
//  Created by heew on 15/7/26.
//  Copyright (c) 2015年 adhx. All rights reserved.
//

#import "SRLoginRegistController.h"
#import "SRVerticalButton.h"

@interface SRLoginRegistController ()

@end

@implementation SRLoginRegistController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (IBAction)qqLogin {
    
    SRLog(@"qqLogin");
}

- (IBAction)weiboLogin {
    
    SRLog(@"weiboLogin");
}

- (IBAction)qqWeiboLogin {
    
    SRLog(@"qqWeiboLogin");
}

- (IBAction)close {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
