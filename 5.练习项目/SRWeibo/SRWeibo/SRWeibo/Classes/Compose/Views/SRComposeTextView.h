//
//  SRComposeTextView.h
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRPlaceholderTextView.h"

@class SREmotion;

/**
 * UITextField:
 * 1.不能显示多行文字
 * 2.有 placehoder 属性能设置占位文字
 * 3.继承自 UIControl
 * 4.监听方式: 代理; addTarget:action:forControlEvents:; 通知:UITextFieldTextDidChangeNotification
 
 * UITextView:
 * 1.能显示多行文字
 * 2.不能设置占位文字
 * 3.继承自 UIScollView
 * 4.监听方式: 代理; 通知:UITextViewTextDidChangeNotification
 */

// 需求: 多行文字并带有占位文字
// 方案: 自定义 TextView 继承自 UITextView; 提供占位文字属性; 通过 drawRect 方法画出占位文字

@interface SRComposeTextView : SRPlaceholderTextView

- (void)insertEmotion:(SREmotion *)emotion;

- (NSString *)fullText;

@end
