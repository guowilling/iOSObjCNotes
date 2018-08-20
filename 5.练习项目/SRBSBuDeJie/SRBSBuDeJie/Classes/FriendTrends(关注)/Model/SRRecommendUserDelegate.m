//
//  SRRecommendUserDelegate.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRRecommendUserDelegate.h"
#import "SRRecommendUserCell.h"
#import "SRRecommendCategory.h"
#import "SRRecommendUser.h"

@implementation SRRecommendUserDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.recommendCategory.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SRRecommendUserCell *cell = [SRRecommendUserCell cellWithTableView:tableView];
    cell.user = self.recommendCategory.users[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SRRecommendUser *user = self.recommendCategory.users[indexPath.row];
    SRLog(@"username: %@", user.screen_name);
}

@end
