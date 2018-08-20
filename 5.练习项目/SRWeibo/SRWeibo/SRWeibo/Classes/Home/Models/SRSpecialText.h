//
//  SRSpecialText.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRSpecialText : NSObject

/** 这段特殊字符串的内容 */
@property (nonatomic, copy  ) NSString *text;

/** 这段特殊字符串的范围 */
@property (nonatomic, assign) NSRange  range;

/** 这段特殊字符串对应的矩形框 */
@property (nonatomic, strong) NSArray *rects;

@end
