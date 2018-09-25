//
//  ViewController.m
//  微博cell
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "StatusFrame.h"
#import "StatusCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *statusFrames;

@end

@implementation ViewController

- (NSArray *)statusFrames {
    if (_statusFrames == nil) {
        _statusFrames = [StatusFrame statusFrames];
    }
    return _statusFrames;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[StatusCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /**
     * 为了得到contentSize 此方法会在调用numberOfRowsInSection方法时执行 有多少行计算多少次
     * 问题: 此方法执行的时候cellForRowAtIndexPath:方法还没有执行 如何在cell实例化之前获得cell的实际高度?
     * 解决方法: 通过重写setter方法计算得到行高
     */
    return [self.statusFrames[indexPath.row] cellHeight];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}

@end
