//
//  ViewController.m
//  线程间通信
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self performSelectorInBackground:@selector(download) withObject:nil];
}

- (void)download {
    
    NSLog(@"Thread: %@", [NSThread currentThread]);
    
    NSString *URLString = @"http://p1.bqimg.com/4851/112faa5cf03658c9.jpg";
    
    NSLog(@"Begin download image");
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URLString]];
    NSLog(@"End download image");
    
    UIImage *image = [UIImage imageWithData:data];
    
    // 回到主线程刷新界面
    [self performSelectorOnMainThread:@selector(downloadFinished:) withObject:image waitUntilDone:YES];
    
    //[self performSelector:@selector(downloadFinished:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
    
    //[self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
}

- (void)downloadFinished:(UIImage *)image {
    
    NSLog(@"Thread: %@", [NSThread currentThread]);
    self.imageView.image = image;
}

@end
