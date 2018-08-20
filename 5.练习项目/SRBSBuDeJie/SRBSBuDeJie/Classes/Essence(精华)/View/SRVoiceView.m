//
//  SRVoiceView.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRVoiceView.h"
#import "SRProgressView.h"
#import "SRTopic.h"

@interface SRVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet SRProgressView *progressView;

@end

@implementation SRVoiceView

+ (instancetype)voiceView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setTopic:(SRTopic *)topic {
    
    _topic = topic;
    
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]
                      placeholderImage:nil
                               options:SDWebImageLowPriority
                              progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                  self.progressView.hidden = NO;
                                  topic.pictureProgress = 1.0 * receivedSize / expectedSize;
                                  [self.progressView setProgress:topic.pictureProgress animated:NO];
                              } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  self.progressView.hidden = YES;
                              }];
}

@end
