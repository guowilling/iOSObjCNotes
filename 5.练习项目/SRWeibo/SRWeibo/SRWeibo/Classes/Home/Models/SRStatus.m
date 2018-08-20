//
//  SRStatus.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRStatus.h"
#import "SRUser.h"
#import "SRPicture.h"
#import "RegexKitLite.h"
#import "SRTextPart.h"
#import "SREmotion.h"
#import "SREmotionManager.h"
#import "SRSpecialText.h"
#import "MJExtension.h"
#import "NSDate+Extension.h"

@implementation SRStatus

- (NSDictionary *)objectClassInArray {
    return @{@"pic_urls" : [SRPicture class]};
}

- (void)setText:(NSString *)text {
    _text = [text copy];
    
    self.attributedText = [self attributedTextWithString:text retweeted:NO];
}

- (void)setRetweeted_status:(SRStatus *)retweeted_status {
    _retweeted_status = retweeted_status;
    
    NSString *retweetContent = [NSString stringWithFormat:@"@%@:%@", retweeted_status.user.screen_name, retweeted_status.text];
    self.retweetedAttributedText = [self attributedTextWithString:retweetContent retweeted:YES];
}

- (NSAttributedString *)attributedTextWithString:(NSString *)text retweeted:(BOOL)retweeted {
    // 正则表达式
    // [表情]
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @xxxx
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // 超链接
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];

    NSMutableArray *parts = [NSMutableArray array];
    
    // 遍历特殊字符串
    [text enumerateStringsMatchedByRegex:pattern
                              usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                                  if ((*capturedRanges).length == 0) {
                                      return;
                                  }
                                  SRTextPart *part = [[SRTextPart alloc] init];
                                  part.text = *capturedStrings;
                                  part.range = *capturedRanges;
                                  part.special = YES;
                                  part.emotion = [part.text hasPrefix:@"[" ] && [part.text hasSuffix:@"]"];
                                  [parts addObject:part];
                              }];
    
    // 遍历普通字符串
    [text enumerateStringsSeparatedByRegex:pattern
                                usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                                    if ((*capturedRanges).length == 0) {
                                        return;
                                    }
                                    SRTextPart *part = [[SRTextPart alloc] init];
                                    part.text = *capturedStrings;
                                    part.range = *capturedRanges;
                                    [parts addObject:part];
                                }];
    
    // parts 数组元素排序, 默认从小到大
    [parts sortUsingComparator:^NSComparisonResult(SRTextPart *part1, SRTextPart *part2) {
        if (part1.range.location > part2.range.location) {
            //NSOrderedSame       (相等): part1 = part2
            //NSOrderedAscending  (升序): part1 < part2
            //NSOrderedDescending (降序): part1 > part2
            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    NSMutableArray *specialTexts = [NSMutableArray array];
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:15 / 375.0 * SRScreenW];
    
    for (SRTextPart *part in parts) { // 重新拼接每段内容
        NSAttributedString *subAttrStr = nil;
        if (part.isEmotion) { // 表情
            SREmotion *picEmotion = [SREmotionManager emotionWithChs:part.text];
            if (picEmotion) { // 图片表情
                NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                attach.image = [UIImage imageNamed:picEmotion.png];
                attach.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                subAttrStr = [NSAttributedString attributedStringWithAttachment:attach];
            } else { // emoji表情
                subAttrStr = [[NSAttributedString alloc] initWithString:part.text];
            }
        } else if (part.isSpecial) { // 特殊字符串
            NSDictionary *attrs = @{NSForegroundColorAttributeName: [UIColor blueColor]};
            subAttrStr = [[NSAttributedString alloc] initWithString:part.text attributes:attrs];
            SRSpecialText *specialText = [[SRSpecialText alloc] init];
            specialText.text = part.text;
            specialText.range = NSMakeRange(attributedText.length, part.text.length);
            [specialTexts addObject:specialText];
        } else { // 普通字符串
            if (retweeted == YES) {
                NSDictionary *attrs = @{NSForegroundColorAttributeName: [UIColor darkGrayColor]};
                subAttrStr = [[NSAttributedString alloc] initWithString:part.text attributes:attrs];
            } else {
                subAttrStr = [[NSAttributedString alloc] initWithString:part.text];
            }
        }
        [attributedText appendAttributedString:subAttrStr];
    }
    
    // 一定要设置字体大小保证尺寸正确
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    
    // 添加特殊字符串数组属性
    [attributedText addAttribute:@"sts" value:specialTexts range:NSMakeRange(0, 1)];
    
    return attributedText;
}

- (NSString *)created_at {
    // 日期处理相关类: NSDateFormatter NSDate NSCalendar
    // 日期格式 E:星期 M:月份 d:几号 H:24小时制 m:分钟 s:秒 y:年
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy"; // @"Tue Sep 30 17:06:25 +0600 2014";
    NSDate *createDate = [formatter dateFromString:_created_at];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponents = [calendar components:unit fromDate:createDate toDate:now options:0];
    if ([createDate isThisYear]) { // 今年
        if ([createDate isToday]) { // 今天
            if (dateComponents.hour >= 1) { // 大于 1 小时
                return [NSString stringWithFormat:@"%zd小时前", dateComponents.hour];
            } else if (dateComponents.minute >= 5) { // 大于 5 分钟
                return [NSString stringWithFormat:@"%zd分钟前", dateComponents.minute];
            } else {
                return @"刚刚";
            }
        }
        if ([createDate isYesterday]) { // 昨天
            formatter.dateFormat = @"昨天 HH:mm";
            return [formatter stringFromDate:createDate];
        } else { // 今年其他天
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:createDate];
        }
    } else { // 非今年
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:createDate];
    }
}

- (void)setSource:(NSString *)source {
    // <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
    if (source.length) {
        NSRange range;
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        NSString *subString = [source substringWithRange:range];
        _source = [NSString stringWithFormat:@"来自%@", subString];
    } else {
        _source = @"来自 SRWeibo";
    }
}

@end
