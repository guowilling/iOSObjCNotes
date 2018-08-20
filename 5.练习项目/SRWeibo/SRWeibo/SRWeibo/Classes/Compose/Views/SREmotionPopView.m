//
//  SREmotionPopView.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SREmotionPopView.h"
#import "SREmotionButton.h"

@interface SREmotionPopView ()

@property (weak, nonatomic) IBOutlet SREmotionButton *emotionBtn;

@end

@implementation SREmotionPopView

+ (instancetype)emotionPopView {
    return [[[NSBundle mainBundle] loadNibNamed:@"SREmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFrom:(SREmotionButton *)emotionBtn {
    if (!emotionBtn) {
        return;
    }
    self.emotionBtn.emotion = emotionBtn.emotion;
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    CGRect btnFrame = [emotionBtn convertRect:emotionBtn.bounds toView:nil];
    self.centerX = CGRectGetMidX(btnFrame);
    self.y = CGRectGetMidY(btnFrame) - self.height;
}

@end
