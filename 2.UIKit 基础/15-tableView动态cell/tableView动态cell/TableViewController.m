//
//  TableViewController.m
//  tableView动态cell
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "TableViewController.h"
#import "AppModel.h"
#import "AppCell.h"

@interface TableViewController () <AppModelDelegate>

@property (nonatomic, strong) NSArray *appModels;

@end

@implementation TableViewController

- (NSArray *)appModels {
    if (_appModels == nil) {
        _appModels = [AppModel appModels];
    }
    return _appModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.delegate = self;
    cell.appModel = self.appModels[indexPath.row];
    return cell;
}

#pragma mark - AppModelDelegate
- (void)appCellDidClickDownloadBtn:(AppCell *)appCell {
    AppModel *app = appCell.appModel;
    
    // 添加标签
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"成功下载%@", app.name];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    
    label.frame = CGRectMake(0, 0, 150, 50);
    label.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.5);
    
    label.layer.cornerRadius = 5;
    label.clipsToBounds = YES;
    [self.view addSubview:label];
    label.alpha = 0.0;
    
    // 动画显示隐藏标签
    [UIView animateWithDuration:1.0 animations:^{
        label.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            label.alpha = 0.0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

@end
