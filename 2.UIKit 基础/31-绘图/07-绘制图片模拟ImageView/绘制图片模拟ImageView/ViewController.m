//
//  ViewController.m
//  绘制图片模拟ImageView
//
//  Created by 郭伟林 on 15/9/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "GWImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) GWImageView *imageView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    GWImageView *imageView = [[GWImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"mayday1"];
    imageView.frame = CGRectMake(0, 0, 100, 100);
    imageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 300);
    [self.view addSubview:imageView];
    self.imageView2 = imageView;
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 200);
    [button setTitle:@"更改图片" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200) , NO , 0);
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(ctx, CGRectMake(50, 50, 100, 100));
//    CGContextStrokePath(ctx);
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    self.imageView.image = image;
//    NSData *data = UIImagePNGRepresentation(image);
//    [data writeToFile:@"/Users/guowilling/Desktop/tempImage.png" atomically:YES];
}

- (void)changeImage {
    
    self.imageView2.image = [UIImage imageNamed:@"mayday2"];
}

@end
