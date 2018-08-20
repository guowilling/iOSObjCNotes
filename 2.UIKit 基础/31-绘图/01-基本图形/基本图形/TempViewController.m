//
//  TempViewController.m
//  基本图形
//
//  Created by 郭伟林 on 16/9/17.
//  Copyright © 2016年 郭伟林. All rights reserved.
//

#import "TempViewController.h"

@interface TempViewController ()

@end

@implementation TempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.drawView];
    self.drawView.frame  = CGRectMake(0, 0, 300, 300);
    self.drawView.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
