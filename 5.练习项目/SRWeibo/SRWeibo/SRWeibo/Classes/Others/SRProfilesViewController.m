//
//  SRProfilesViewController.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/26.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRProfilesViewController.h"
#import "SROneViewController.h"
#import "SDWebImageManager.h"
#import "MBProgressHUD+MJ.h"

@implementation SRProfilesViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置"
                                                                              style:0
                                                                             target:self
                                                                             action:@selector(setting)];
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs[NSForegroundColorAttributeName] = [UIColor purpleColor];
//    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}

- (void)setting {
    SROneViewController *oneVC = [[SROneViewController alloc] init];
    oneVC.title = @"设置";
    [self.navigationController pushViewController:oneVC animated:YES];
}

#pragma mark - UITabelViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if (indexPath.row == 0) {
        NSInteger byteSize = [SDImageCache sharedImageCache].getSize;
        CGFloat mSize = byteSize / 1000.0 / 1000.0;
        cell.textLabel.text = [NSString stringWithFormat:@"缓存大小:%.1fM", mSize];
        cell.detailTextLabel.text = @"清空缓存";
    }
    if (indexPath.row == 1) {
        cell.textLabel.text = @"关于我们";
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [[SDImageCache sharedImageCache] clearDisk];
        [MBProgressHUD showSuccess:@"成功清除"];
        [self.tableView reloadData];
        [self deleteCachesDirectory];
    }
}

- (void)deleteCachesDirectory {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSError *error;
    [manager removeItemAtPath:caches error:&error];
    if (error) {
        NSLog(@"error: %@", error);
    }
    // 获得文件或文件夹的属性(注意:文件夹没有大小属性只有文件才有大小属性)
    NSDictionary *attrs = [manager attributesOfItemAtPath:[caches stringByAppendingPathComponent:@"Snapshots"] error:nil];
    SRLog(@"%@", attrs);
}

@end
