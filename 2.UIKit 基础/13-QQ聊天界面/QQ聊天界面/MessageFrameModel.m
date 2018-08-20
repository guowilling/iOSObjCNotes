//
//  MessageFrameModel.m
//  QQ聊天界面
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "MessageFrameModel.h"
#import "MessageModel.h"
#import "NSString+Extension.h"

@implementation MessageFrameModel

+ (NSArray *)messageFrames {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"]];
    NSMutableArray *arrayM = [NSMutableArray array];
    MessageModel *previousMessage = nil;
    for (NSDictionary *dict in array) {
        MessageModel * message = [MessageModel messageModelWithDict:dict];
        message.hiddenTime = [message.time isEqualToString:previousMessage.time];
        previousMessage = message;
        MessageFrameModel *messageFrame = [[MessageFrameModel alloc] init];
        messageFrame.message = message;
        [arrayM addObject:messageFrame];
    }
    return arrayM;
}

- (void)setMessage:(MessageModel *)message {
    _message = message;

    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat padding = 10;
    
    // 时间
    if (NO == message.hiddenTime) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeH = 30;
        CGFloat timeW = screenWidth;
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    // 头像
    CGFloat iconH = 30;
    CGFloat iconW = 30;
    CGFloat iconY = CGRectGetMaxY(_timeF) + padding;
    CGFloat iconX = 0;
    if (kMessageModelTypeMe == _message.type) {
        iconX = screenWidth - padding - iconW;
    } else {
        iconX = padding;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 正文
    CGSize textSize = [_message.text sizeWithFont:kTextFont maxWidth:200];
    CGFloat textW = textSize.width + 20 * 2;
    CGFloat textH = textSize.height + 20 * 2;
    CGFloat textY = iconY;
    CGFloat textX = 0;
    if (kMessageModelTypeMe == _message.type) {
        textX = iconX - padding - textW;
    } else {
        textX = CGRectGetMaxX(_iconF) + padding;
    }
    _textF = CGRectMake(textX, textY, textW, textH);
    
    // 行高
    CGFloat maxIconY = CGRectGetMaxY(_iconF);
    CGFloat maxTextY = CGRectGetMaxY(_textF);
    _cellHeight = MAX(maxIconY, maxTextY) + padding;
}

@end
