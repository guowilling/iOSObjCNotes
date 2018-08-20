//
//  SRUserViewController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/4.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRUserViewController.h"

#define SRTopViewH 250

@interface SRUserViewController ()

@property (nonatomic, strong) UIImageView *topView;

@end

@implementation SRUserViewController

- (instancetype)init {
    
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(SRTopViewH, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self setupTopView];
    
    SRLog(@"contentInset: %@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
}

- (void)setupTopView {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mayday"];
    imageView.frame = CGRectMake(0, -SRTopViewH, SRScreenW, SRTopViewH);
    imageView.contentMode = UIViewContentModeCenter;
    imageView.userInteractionEnabled = YES;
    self.topView = imageView;
    [self.tableView addSubview:imageView];
    
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 0, 90, 25);
    btn.center = CGPointMake(SRScreenW * 0.5, 210);
    btn.layer.cornerRadius = 10;
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitle:@"STAYREAL" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
}

- (void)login {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.imageView.image = [UIImage imageNamed:@"gift_guide_like_s"];
        cell.textLabel.text = @"我的积分";
        return cell;
    }
    
    if (indexPath.row == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.imageView.image = [UIImage imageNamed:@"gift_guide_like_s"];
        cell.textLabel.text = @"我的订单";
        return cell;
    }
    
    if (indexPath.row == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.imageView.image = [UIImage imageNamed:@"gift_guide_like_s"];
        cell.textLabel.text = @"我的礼券";
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        SRLog(@"我的积分");
    }
    if (indexPath.row == 1) {
        SRLog(@"我的订单");
    }
    if (indexPath.row == 2) {
        SRLog(@"我的礼券");
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    SRLog(@"offsetY: %.2f", offsetY);
    if (-offsetY > SRTopViewH && -offsetY < SRTopViewH * 2) {
        CGFloat scale = -(offsetY + SRTopViewH) / SRTopViewH + 1;
        self.topView.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

@end
