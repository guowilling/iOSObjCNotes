//
//  SRShowPictureController.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRShowPictureController.h"
#import "SRProgressView.h"
#import "SRTopic.h"

@interface SRShowPictureController ()

@property (weak, nonatomic) IBOutlet UIScrollView   *scrollView; // 通过 xib 创建的 scrollView 的滚动范围由它里面的子控件大小决定
@property (weak, nonatomic) IBOutlet UIImageView    *imageView;
@property (weak, nonatomic) IBOutlet SRProgressView *progressView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewCenterY;

@end

@implementation SRShowPictureController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // 更新图片约束
    CGFloat pictureH = SRScreenW * self.topic.height / self.topic.width;
    self.imageViewWidth.constant = SRScreenW;
    self.imageViewHeight.constant = pictureH;
    self.imageViewCenterY.priority = pictureH > SRScreenH ? UILayoutPriorityDefaultLow : UILayoutPriorityRequired; // !!注意此处
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]
                      placeholderImage:nil
                               options:SDWebImageLowPriority
                              progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                  [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
                              }
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  self.progressView.hidden = YES;
                              }];
}

- (IBAction)save {
    
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片还没下载完呢"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}

- (IBAction)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
