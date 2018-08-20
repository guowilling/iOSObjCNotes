//
//  SREmotionPageView.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SREmotionPageView.h"
#import "SREmotion.h"
#import "NSString+Emoji.h"
#import "SREmotionButton.h"
#import "SREmotionPopView.h"
#import "SREmotionManager.h"

@interface SREmotionPageView ()

@property (nonatomic, weak  ) UIButton *deleteBtn;
@property (nonatomic, strong) SREmotionPopView *popView;

@end

@implementation SREmotionPageView

- (SREmotionPopView *)popView {
    if (!_popView) {
        _popView = [SREmotionPopView emotionPopView];
    }
    return _popView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIButton * deleteBtn = [[UIButton alloc] init];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteBtn];
        self.deleteBtn = deleteBtn;
        
        UILongPressGestureRecognizer *longPress =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}

// 触发开始长按、长按移动、长按松开等手势时调用和 addTarget 不冲突
- (void)longPressPageView:(UILongPressGestureRecognizer *)longPress {
    CGPoint point = [longPress locationInView:longPress.view];
    SRLog(@"%@", NSStringFromCGPoint(point));
    
    SREmotionButton *emotionBtn = nil; // 手指位置所在的表情按钮
    NSInteger count = self.subviews.count;
    for (int i = 1; i < count; i++) {
        SREmotionButton *btn = self.subviews[i];
        if (CGRectContainsPoint(btn.frame, point)) {
            emotionBtn = btn;
        }
    }
    switch (longPress.state) {
        case UIGestureRecognizerStateCancelled:  // 被迫结束(来电等)
        case UIGestureRecognizerStateEnded:      // 主动结束(手指抬起)
            [self.popView removeFromSuperview];
            if (emotionBtn) {
                [SREmotionManager addToRectenEmotions:emotionBtn.emotion];
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                userInfo[@"emotion"] = emotionBtn.emotion;
                [[NSNotificationCenter defaultCenter] postNotificationName:SREmotionBtnDidSelectNotification object:nil userInfo:userInfo];
            }
            break;
            
        case UIGestureRecognizerStateBegan:      // 触发长按手势
        case UIGestureRecognizerStateChanged:    // 长按位置改变
            [self.popView showFrom:emotionBtn];
            
        default:
            break;
    }
}

- (void)deleteBtnClick {
    [[NSNotificationCenter defaultCenter] postNotificationName:SRTextDidDeleteNotification object:nil];
}

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    NSInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
        SREmotionButton *emotionBtn = [[SREmotionButton alloc] init]; // 创建表情按钮
        emotionBtn.emotion = emotions[i]; // 设置表情图片
//        emotionBtn.backgroundColor = SRRandomColor;
        [emotionBtn addTarget:self action:@selector(emotionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:emotionBtn];
    }
}

- (void)emotionBtnClick:(SREmotionButton *)btn {
//    self.popView.emotion = btn.emotion;
//    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//    [window addSubview:self.popView];
//    CGRect btnFrame = [btn convertRect:btn.bounds toView:window];
//    self.popView.centerX = CGRectGetMidX(btnFrame);
//    self.popView.y = CGRectGetMidY(btnFrame) - self.popView.height;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.popView removeFromSuperview];
//    });
    
    [SREmotionManager addToRectenEmotions:btn.emotion]; // 添加到最近表情中
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"emotion"] = btn.emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:SREmotionBtnDidSelectNotification object:nil userInfo:userInfo]; // 发出通知
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.emotions.count;
    CGFloat inset = 10;
    CGFloat btnW = (self.width - 2 * inset) / SREmotionMaxColumns;
    CGFloat btnH = (self.height - inset) / SREmotionMaxRows;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i + 1]; // 跳过第一个删除按钮
        btn.x = inset + (i % SREmotionMaxColumns) * btnW;
        btn.y = inset + (i / SREmotionMaxColumns) * btnH;
        btn.width = btnW;
        btn.height = btnH;
    }

    self.deleteBtn.width = btnW;
    self.deleteBtn.height = btnH;
    self.deleteBtn.x = self.width - btnW - 10;
    self.deleteBtn.y = self.height - btnH;
}

@end
