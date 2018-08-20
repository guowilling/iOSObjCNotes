//
//  SRMenuViewController.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/26.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRMenuViewController.h"

@implementation SRMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"密友";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"全部";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    SRLog(@"didSelectRowAtIndexPath text: %@", cell.textLabel.text);
}

@end
