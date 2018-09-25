//
//  ViewController.m
//  图片水印
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+SR.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //UIImage *image = [UIImage imageWithBackgroundImageName:@"火影02" logImageName:@"火影01"];
    UIImage *image = [UIImage imageWithBackgroundImageName:@"火影01" string:@"STAYREAL"];
    self.imageView.image =  image;
}

@end
