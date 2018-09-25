//
//  ViewController.m
//  剪切
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
    
    UIImage *image = [UIImage imageWithName:@"mayday happy each day" border:5 color:[UIColor purpleColor]];
    self.imageView.image = image;
}

- (void)circleImage {
    
    UIImage *oldImage = [UIImage imageNamed:@"mayday happy each day"];
    UIGraphicsBeginImageContextWithOptions(oldImage.size, NO, 0);
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctr, CGRectMake(0, 0, oldImage.size.width, oldImage.size.height));
    CGContextClip(ctr);
    [oldImage drawInRect:CGRectMake(0, 0, oldImage.size.width, oldImage.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    self.imageView.image = newImage;
    
//    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tempImage.png"];
//    NSData *data = UIImagePNGRepresentation(newImage);
//    [data writeToFile:path atomically:YES];
}

@end
