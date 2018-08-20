//
//  ViewController.m
//  应用程序管理(xib)
//
//  Created by 郭伟林 on 15/9/16.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "AppInfo.h"
#import "AppInfoView.h"

#define kAppViewW 80
#define kAppViewH 90
#define kColCount 3
#define kStartY 70

@interface ViewController () <AppInfoViewDelegate>
@property (nonatomic, strong) NSArray *appInfos;
@property (nonatomic, strong) UILabel *tipsLabel;
@end

@implementation ViewController

- (NSArray *)appInfos {
    if (_appInfos == nil) {
        _appInfos = [AppInfo appInfos];
    }
    return _appInfos;
}

- (UILabel *)tipsLabel {
    if (!_tipsLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.center = CGPointMake(self.view.center.x, 500);
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        [self.view addSubview:label];
        label.alpha = 0.0;
        _tipsLabel = label;
    }
    return _tipsLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat marginX = (self.view.bounds.size.width - 3 * 80) / 4;
    CGFloat marginY = 10;
    for (int i = 0; i < self.appInfos.count; i++) {
        // 行
        // 0, 1, 2 => 0
        // 3, 4, 5 => 1
        // 6, 7, 8 => 2
        int row = i / 3;
        
        // 列
        // 0, 3, 6 => 0
        // 1, 4, 7 => 1
        // 2, 5, 8 => 2
        int col = i % 3;
        CGFloat x = marginX + col * (marginX + kAppViewW);
        CGFloat y = kStartY + marginY + row * (marginY + kAppViewH);
  
        // 从XIB加载自定义视图
        //AppInfoView *appInfoView = [AppInfoView appInfoView];
        //appInfoView.appInfo = self.appInfos[i];
        AppInfoView *appInfoView =[AppInfoView appInfoViewWithAppInfo:self.appInfos[i]];
        appInfoView.frame = CGRectMake(x, y, kAppViewW, kAppViewH);
        appInfoView.delegate = self;
        [self.view addSubview:appInfoView];
    }
}

- (void)appInfoViewDidClickDownloadButton:(AppInfoView *)appInfoView {
    self.tipsLabel.text = appInfoView.appInfo.name;
    [UIView animateWithDuration:1.0 animations:^{
        self.tipsLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            self.tipsLabel.alpha = 0.0;
        }];
    }];
}

@end
