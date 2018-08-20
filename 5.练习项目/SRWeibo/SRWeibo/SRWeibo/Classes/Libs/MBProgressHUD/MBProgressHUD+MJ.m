//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"

@implementation MBProgressHUD (MJ)

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.0];
}

#pragma mark - Message

+ (MBProgressHUD *)showMessage:(NSString *)message {
    
    return [self showMessage:message toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    hud.removeFromSuperViewOnHide = YES;
    hud.dimBackground = YES;
    return hud;
}

#pragma mark - Success

+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:nil];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view {
    
    [self show:success icon:@"success.png" view:view];
}

#pragma mark - Error

+ (void)showError:(NSString *)error {
    
    [self showError:error toView:nil];
}

+ (void)showError:(NSString *)error toView:(UIView *)view {
    
    [self show:error icon:@"error.png" view:view];
}

#pragma mark - Hide

+ (void)hideHUD {
    
    [self hideHUDForView:nil];
}

+ (void)hideHUDForView:(UIView *)view {
    
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    [self hideHUDForView:view animated:YES];
}

@end
