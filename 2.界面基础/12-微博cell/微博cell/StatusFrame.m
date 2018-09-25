//
//  StatusFrame.m
//  微博cell
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "StatusFrame.h"
#import "Status.h"
#import "NSString+Extension.h"

@implementation StatusFrame

- (void)setStatus:(Status *)status {
    _status = status;
    
    CGFloat margin = 10;
    
    // 头像
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 昵称
    CGRect nameFrame = CGRectZero;
    nameFrame.size = [self.status.name sizeWithFont:kNameFont];
    nameFrame.origin.x = CGRectGetMaxX(self.iconF) + margin;
    nameFrame.origin.y = margin + (self.iconF.size.height - nameFrame.size.height) * 0.5;
    _nameF = nameFrame;
    
    // Vip图标
    CGFloat vipX = CGRectGetMaxX(self.nameF) + margin;
    CGFloat vipY = self.nameF.origin.y;
    CGFloat vipW = 14;
    CGFloat vipH = 14;
    _vipF = CGRectMake(vipX, vipY, vipW, vipH);
    
    // 正文
    CGRect textFrame = CGRectZero;
    textFrame.size = [self.status.text sizeWithFont:kTextFont maxWidth:[UIScreen mainScreen].bounds.size.width - 20];;
    textFrame.origin.x = margin;
    textFrame.origin.y = CGRectGetMaxY(self.iconF) + margin;
    _textF = textFrame;
    
    // 图片
    if (self.status.picture.length) {
        CGFloat pictureX = margin;
        CGFloat pictureY = CGRectGetMaxY(textFrame) + margin;
        CGFloat pictureW = 100;
        CGFloat pictureH = 100;
        _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
        _cellHeight = CGRectGetMaxY(self.pictureF) + margin;
    } else {
        _cellHeight = CGRectGetMaxY(self.textF) + margin;
    }
}

+ (NSArray *)statusFrames {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"statuses.plist" ofType:nil]];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        Status *status = [Status statusWithDict:dict];
        StatusFrame *statusFrame =[[StatusFrame alloc] init];
        statusFrame.status = status;
        [arrayM addObject:statusFrame];
    }
    return arrayM;
}

@end
