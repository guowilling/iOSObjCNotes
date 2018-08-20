//
//  SREmotion.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SREmotion : NSObject <NSCoding>

/** 图片表情的描述 */
@property (nonatomic, copy) NSString *chs;

/** 图片表情的图片名 */
@property (nonatomic, copy) NSString *png;

/** emoji表情的16进制编码 */
@property (nonatomic, copy) NSString *code;

@end
