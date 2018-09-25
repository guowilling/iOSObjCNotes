//
//  ViewController.m
//  画画板
//
//  Created by 郭伟林 on 15/9/21.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "PaletteView.h"
#import "MBProgressHUD+NJ.h"
#import "UIImage+SR.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet PaletteView *paletteView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.paletteView.lineWidth = 5.0;
    
    self.paletteView.color = [UIColor redColor];
}

- (IBAction)clearBtnClick {
    
    [self.paletteView clear];
}

- (IBAction)backBtnClick {
    
    [self.paletteView back];
}

- (IBAction)saveBtnClick {
    
    UIImage *newImage = [UIImage captureImageWithView:self.paletteView];
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (!error) {
        [MBProgressHUD showSuccess:@"保存图片成功"];
    } else {
        [MBProgressHUD showError:@"保存图片失败"];
    }
}

- (IBAction)sliderValueChange:(UISlider *)sender {
    
    self.paletteView.lineWidth = sender.value;
}

- (IBAction)blackColor {
    
    self.paletteView.color = [UIColor blackColor];
}

- (IBAction)randomColor {
    
    self.paletteView.color = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
}

@end
