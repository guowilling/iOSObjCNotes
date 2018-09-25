//
//  NSString+Number.h
//  05-分类的应用
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

/*
 给NSString增加一个类方法：计算某个字符串中阿拉伯数字的个数
 给NSString增加一个对象方法：计算当前字符串中阿拉伯数字的个数
 */


#import <Foundation/Foundation.h>

@interface NSString (Number)

+ (int)numberCountOfString:(NSString *)str;

- (int)numberCount;

@end
