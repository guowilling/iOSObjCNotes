//
//  SRComposeTextView.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRComposeTextView.h"
#import "SREmotion.h"
#import "SREmotionAttachment.h"
#import "NSString+Emoji.h"
#import "UITextView+Extension.h"

@implementation SRComposeTextView

- (void)insertEmotion:(SREmotion *)emotion {
    if (emotion.code) { // emoji 表情相当于字符串
        [self insertText:emotion.code.emoji]; // insertText 方法只能插入字符串
        return;
    }
    if (emotion.png) { // 图片表情
        SREmotionAttachment *attachment = [[SREmotionAttachment alloc] init];
        attachment.emotion = emotion;
        // 注意一定要设置附件尺寸
        attachment.bounds = CGRectMake(0, -4, self.font.lineHeight + 1, self.font.lineHeight + 1);
        NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:attachment];
        [self insertAttributedText:attributedString settingBlock:^(NSMutableAttributedString *attributedText) {
            // 普通文本 (text)由textView.font 控制字体
            // 属性文本 (attributedText) 不由 textView.font 控制字体
            [attributedText addAttribute:NSFontAttributeName
                                   value:[UIFont fontWithName:@"PingFangSC-Light" size:self.font.pointSize / 375.0 * SRScreenW]
                                   range:NSMakeRange(0, attributedText.length)];
        }];
    }
}

- (NSString *)fullText {
    NSMutableString *fullText = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length)
                                            options:0
                                         usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
                                             SREmotionAttachment *attachment = attrs[@"NSAttachment"];
                                             if (attachment) {
                                                 [fullText appendString:attachment.emotion.chs];
                                             } else {
                                                 NSAttributedString *attrStr = [self.attributedText attributedSubstringFromRange:range];
                                                 [fullText appendString:attrStr.string];
                                             }
                                         }];
    return fullText;
}

@end
