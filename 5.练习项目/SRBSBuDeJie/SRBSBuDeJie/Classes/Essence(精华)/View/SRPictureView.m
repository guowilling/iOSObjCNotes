//
//  SRPictureView.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRPictureView.h"
#import "SRTopic.h"
#import "SRProgressView.h"
#import "SRShowPictureController.h"

@interface SRPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet SRProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *seeFullImageBtn;

@end

@implementation SRPictureView

+ (instancetype)pictureView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
//    self.imageView.backgroundColor = SRRandomColor;
//    self.gifView.backgroundColor = SRRandomColor;
//    self.progressView.backgroundColor = SRRandomColor;
//    self.seeFullImageBtn.backgroundColor = SRRandomColor;
}

- (void)setTopic:(SRTopic *)topic {
    
    _topic = topic;
    
    // 立即显示最新的进度值, 防止因网速慢导致显示的是其他图片的下载进度.
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.middle_image]
                      placeholderImage:nil
                               options:SDWebImageLowPriority
                              progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                  self.progressView.hidden = NO;
                                  topic.pictureProgress = 1.0 * receivedSize / expectedSize;
                                  [self.progressView setProgress:topic.pictureProgress animated:NO];
                              } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  self.progressView.hidden = YES;
                                  
                                  if (topic.isBigPicture) { // 大图片才需要进行处理
                                      UIGraphicsBeginImageContextWithOptions(topic.pictureSize, YES, 0.0);
                                      CGFloat width = topic.pictureSize.width;
                                      CGFloat height = width * image.size.height / image.size.width;
                                      [image drawInRect:CGRectMake(0, 0, width, height)];
                                      self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
                                      UIGraphicsEndImageContext();
                                  }
                              }];
    
    self.gifView.hidden = ![topic.large_image.pathExtension.lowercaseString isEqualToString:@"gif"];
    self.seeFullImageBtn.hidden = !topic.isBigPicture;
}

- (IBAction)showPicture:(UITapGestureRecognizer *)sender {
    
    SRShowPictureController *showPicture = [[SRShowPictureController alloc] init];
    showPicture.topic = self.topic;
    [SRKeyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

@end
