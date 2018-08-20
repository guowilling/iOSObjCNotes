//
//  SRTextPart.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRTextPart : NSObject

/** 这段文字的内容 */
@property (nonatomic, copy  ) NSString *text;

/** 这段文字的范围 */
@property (nonatomic, assign) NSRange  range;

/** 是否为特殊文字 */
@property (nonatomic, assign, getter=isSpecial) BOOL special;

/** 是否为表情 */
@property (nonatomic, assign, getter=isEmotion) BOOL emotion;

@end
