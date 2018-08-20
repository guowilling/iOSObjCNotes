//
//  ViewController.m
//  简易通讯录
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+MJ.h"

#define kusername @"gwl"
#define kpassword @"gwl"
#define kautoLogin @"autoLogin"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField  *usernameField;
@property (weak, nonatomic) IBOutlet UITextField  *passwordField;
@property (weak, nonatomic) IBOutlet UIButton     *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch     *autoLoginSwitch;

@end

@implementation LoginViewController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.usernameField];
    [center addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordField];
    //[_usernameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    //[_passwordField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.usernameField.text = [defaults objectForKey:kusername];
    self.passwordField.text = [defaults objectForKey:kpassword];
    
    [self textChange];
    
    if ([defaults boolForKey:kautoLogin]) {
        //[self loginBtnClick];
    }
}

- (void)textChange {
    
    self.loginBtn.enabled = (self.usernameField.text.length > 0) && (self.passwordField.text.length > 0);
}

- (IBAction)autoLoginChange:(UISwitch *)sender {
    
    if (sender.isOn) {
        self.autoLoginSwitch.on = YES;
    } else {
        self.autoLoginSwitch.on = NO;
    }
}

- (IBAction)loginBtnClick {
    
    [MBProgressHUD showMessage:@"正在登录"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (![self.usernameField.text isEqualToString:@"GWL"]) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"用户名错误"];
            return;
        }
        if (![self.passwordField.text isEqualToString:@"GWL"]) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"密码错误"];
            return;
        }
        
        [MBProgressHUD hideHUD];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.usernameField.text forKey:kusername];
        [defaults setObject:self.passwordField.text forKey:kpassword];
        [defaults setBool:self.autoLoginSwitch.isOn forKey:kautoLogin];
        [defaults synchronize];
        
        [self performSegueWithIdentifier:@"login2contacts" sender:nil];
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIViewController *destVC = segue.destinationViewController;
    destVC.title = [NSString stringWithFormat:@"%@的联系人列表", self.usernameField.text];
}

@end
