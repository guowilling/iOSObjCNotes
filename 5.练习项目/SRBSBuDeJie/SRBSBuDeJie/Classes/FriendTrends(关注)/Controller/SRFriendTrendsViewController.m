//
//  SRFriendTrendsViewController.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRFriendTrendsViewController.h"
#import "SRFriendsRecommendController.h"
#import "SRLoginRegistController.h"

@interface SRFriendTrendsViewController ()

@end

@implementation SRFriendTrendsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNav];
}

- (void)setupNav {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"friendsRecommentIcon"]
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(friendsRecommend)];
}

- (void)friendsRecommend {
    
    SRFriendsRecommendController *friendsRecommendController = [[SRFriendsRecommendController alloc] init];
    [self.navigationController pushViewController:friendsRecommendController animated:YES];
}

- (IBAction)login:(UIButton *)sender {
    
    SRLoginRegistController *loginRegistController = [[SRLoginRegistController alloc] init];
    [self presentViewController:loginRegistController animated:YES completion:nil];
}

@end
