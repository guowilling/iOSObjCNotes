//
//  AppInfoView.m
//  应用程序管理(xib)
//
//  Created by 郭伟林 on 15/9/16.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "AppInfoView.h"

@interface AppInfoView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;

- (IBAction)ClickDownloadBtn:(UIButton *)sender;

@end

@implementation AppInfoView

+ (instancetype)appInfoView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AppInfoView class]) owner:nil options:nil] lastObject];
}

+ (instancetype)appInfoViewWithAppInfo:(AppInfo *)appInfo {
    
    AppInfoView *appInfoView = [self appInfoView];
    appInfoView.appInfo = appInfo;
    return appInfoView;
}

/**
 * 通过setter方法设置视图的内容
 */
-(void)setAppInfo:(AppInfo *)appInfo {
    
    _appInfo = appInfo;
    self.imageView.image = appInfo.image;
    self.nameLabel.text = appInfo.name;
}

- (IBAction)ClickDownloadBtn:(UIButton *)sender {
    
    sender.enabled = NO;
    
    if ([self.delegate respondsToSelector:@selector(appInfoViewDidClickDownloadButton:)]) {
        [self.delegate appInfoViewDidClickDownloadButton:self];
    }
}

@end
