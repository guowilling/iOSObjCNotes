//
//  ViewController.m
//  dispatch_group
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) UIImage *image1;
@property (nonatomic, strong) UIImage *image2;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 队列组
    dispatch_group_t group = dispatch_group_create();
    // 全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 下载图片1
    __block UIImage *image1 = nil;
    dispatch_group_async(group, queue, ^{
        NSURL *URL = [NSURL URLWithString:@"http://www.5068.com/u/faceimg/20140919221759.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:URL];
        image1 = [UIImage imageWithData:data];
    });
    
    // 下载图片2
    __block UIImage *image2 = nil;
    dispatch_group_async(group, queue, ^{
        NSURL *URL = [NSURL URLWithString:@"http://su.bdimg.com/static/superplus/img/logo_white_ee663702.png"];
        NSData *data = [NSData dataWithContentsOfURL:URL];
        image2 = [UIImage imageWithData:data];
    });
    
    // 合并图片(notify 函数里的 block 会在队列组里的所有任务执行完成之后执行)
    dispatch_group_notify(group, queue, ^{
        // 开启上下文
        UIGraphicsBeginImageContextWithOptions(image1.size, NO, 0.0);
        
        // 绘制第1张图片
        CGFloat image1W = image1.size.width;
        CGFloat image1H = image1.size.height;
        [image1 drawInRect:CGRectMake(0, 0, image1W, image1H)];
        
        // 绘制第2张图片
        CGFloat image2W = image2.size.width * 0.2;
        CGFloat image2H = image2.size.height * 0.2;
        [image2 drawInRect:CGRectMake(0, 0, image2W, image2H)];
        
        // 得到绘制好的图片
        UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束上下文
        UIGraphicsEndImageContext();
        
        // 回到主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = fullImage;
        });
    });
}

- (void)test2 {
    
    // 下载第1张
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url1 = [NSURL URLWithString:@"http://g.hiphotos.baidu.com/image/pic/item/f2deb48f8c5494ee460de6182ff5e0fe99257e80.jpg"];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        self.image1 = [UIImage imageWithData:data1];
        [self mergeImages];
    });
    
    // 下载第2张
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url2 = [NSURL URLWithString:@"http://su.bdimg.com/static/superplus/img/logo_white_ee663702.png"];
        NSData *data2 = [NSData dataWithContentsOfURL:url2];
        self.image2 = [UIImage imageWithData:data2];
        [self mergeImages];
    });
}

- (void)mergeImages {
    
    if (self.image1 == nil || self.image2 == nil) {
        return;
    }
    
    // 合并图片
    UIGraphicsBeginImageContextWithOptions(self.image1.size, NO, 0);
    CGFloat image1W = self.image1.size.width;
    CGFloat image1H = self.image1.size.height;
    [self.image1 drawInRect:CGRectMake(0, 0, image1W, image1H)];
    CGFloat image2W = self.image2.size.width  * 0.5;
    CGFloat image2H = self.image2.size.height * 0.5;
    [self.image2 drawInRect:CGRectMake(0, 0, image2W, image2H)];
    UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 回到主线程显示图片
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = fullImage;
    });
}

- (void)test1 {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 下载第1张
        NSURL *url1 = [NSURL URLWithString:@"http://www.5068.com/u/faceimg/20140919221759.jpg"];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        UIImage *image1 = [UIImage imageWithData:data1];
       
        // 下载第2张
        NSURL *url2 = [NSURL URLWithString:@"http://su.bdimg.com/static/superplus/img/logo_white_ee663702.png"];
        NSData *data2 = [NSData dataWithContentsOfURL:url2];
        UIImage *image2 = [UIImage imageWithData:data2];
        
        // 合并图片
        UIGraphicsBeginImageContextWithOptions(image1.size, NO, 0.0);
        CGFloat image1W = image1.size.width;
        CGFloat image1H = image1.size.height;
        [image1 drawInRect:CGRectMake(0, 0, image1W, image1H)];
        CGFloat image2W = image2.size.width * 0.5;
        CGFloat image2H = image2.size.height * 0.5;
        [image2 drawInRect:CGRectMake(0, 0, image2W, image2H)];
        UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // 回到主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = fullImage;
        });
    });
}

@end
