//
//  SRStatusFrame.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRStatusFrame.h"
#import "SRUser.h"
#import "SRStatus.h"
#import "SRStatusPicturesView.h"
#import "NSString+Extension.h"

@implementation SRStatusFrame

- (void)setStatus:(SRStatus *)status {
    _status = status;
    
    SRUser *user = status.user;
    
    // 原创微博
    {
        // 头像
        CGFloat iconX = SRSpacing;
        CGFloat iconY = SRSpacing;
        CGFloat iconWH = 35;
        self.iconImageViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
        
        // 昵称
        CGFloat nicknameX = CGRectGetMaxX(self.iconImageViewF) + SRSpacing;
        CGFloat nicknameY = iconY;
        CGSize nicknameSize = [user.screen_name sizeWithFont:SRNameFont];
        self.nicknameLabelF = CGRectMake(nicknameX, nicknameY, nicknameSize.width, nicknameSize.height);
        
        // 会员图标
        if (user.isVip) {
            CGFloat vipX = CGRectGetMaxX(self.nicknameLabelF) + 5;
            CGFloat vipY = nicknameY;
            CGFloat vipW = 15;
            CGFloat vipH = nicknameSize.height;
            self.vipImageViewF = CGRectMake(vipX, vipY, vipW, vipH);
        }
        
        // 时间
        CGFloat timeX = nicknameX;
        CGFloat timeY = CGRectGetMaxY(self.nicknameLabelF);
        CGSize timeSize = [status.created_at sizeWithFont:SRTimeFont];
        self.timeLableF = (CGRect){{timeX, timeY}, timeSize};
        
        // 来源
        CGFloat sourceX = CGRectGetMaxX(self.timeLableF) + SRSpacing;
        CGFloat sourceY = timeY;
        CGSize sourceSize = [status.source sizeWithFont:SRSourceFont];
        self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
        
        // 正文
        CGFloat contentX = iconX;
        CGFloat contentY = MAX(CGRectGetMaxY(self.iconImageViewF), CGRectGetMaxY(self.timeLableF)) + SRSpacing;
        CGFloat maxWidth = SRScreenW - 2 * SRSpacing;
        CGSize contentSize = [status.attributedText.string sizeWithFont:SRContentFont maxWidth:maxWidth];
        contentSize.height += 10;
        self.contentLableF = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
        CGFloat originalH;
        
        // 配图
        if (status.pic_urls.count) {
            CGFloat picturesX = contentX;
            CGFloat picturesY = CGRectGetMaxY(self.contentLableF) + SRSpacing;
            CGSize picturesSize = [SRStatusPicturesView sizeWithCount:status.pic_urls.count];
            self.picturesViewF = CGRectMake(picturesX, picturesY, picturesSize.width, picturesSize.height);
            originalH = CGRectGetMaxY(self.picturesViewF) + SRSpacing;
        } else {
            originalH = CGRectGetMaxY(self.contentLableF) + SRSpacing;
        }
        
        // 原创微博整体
        CGFloat originalX = 0;
        CGFloat originalY = 0;
        CGFloat originalW = SRScreenW;
        self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    }
    
    // 转发微博
    if (status.retweeted_status) {
        SRStatus *retweetStatus = status.retweeted_status;
        SRUser *retweetUser = retweetStatus.user;
        // 转发微博昵称:正文
        NSString *retweetContent = [NSString stringWithFormat:@"@%@:%@", retweetUser.screen_name, retweetStatus.attributedText.string];
        CGFloat retweetContentX = SRSpacing;
        CGFloat retweetContentY = 5;
        CGFloat maxWidth = SRScreenW - 2 * retweetContentX;
        CGSize retweetContentSize = [retweetContent sizeWithFont:SRRetweetContentFont maxWidth:maxWidth];
        retweetContentSize.height += 10;
        self.retweetContentLabelF = CGRectMake(retweetContentX, retweetContentY, retweetContentSize.width, retweetContentSize.height);
        
        CGFloat retweetH = 0;
        
        // 转发微博配图
        if (retweetStatus.pic_urls.count) {
            CGFloat retweetPicsX = retweetContentX;
            CGFloat retweetPicsY = CGRectGetMaxY(self.retweetContentLabelF) + SRSpacing;
            CGSize retweetPicturesSize = [SRStatusPicturesView sizeWithCount:retweetStatus.pic_urls.count];
            self.retweetPicsViewF = CGRectMake(retweetPicsX, retweetPicsY, retweetPicturesSize.width, retweetPicturesSize.height);
            retweetH = CGRectGetMaxY(self.retweetPicsViewF) + SRSpacing;
        } else {
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + SRSpacing;
        }
        
        // 转发微博整体
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = SRScreenW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    } else {
        self.retweetViewF = CGRectZero;
    }
    
    CGFloat toolBarX = 0;
    CGFloat toolBarY = MAX(CGRectGetMaxY(self.originalViewF), CGRectGetMaxY(self.retweetViewF));
    CGFloat toolBarW = SRScreenW;
    CGFloat toolBarH = 35;
    self.toolBarViewF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    self.cellHeight = CGRectGetMaxY(self.toolBarViewF) + 5;
}

@end
