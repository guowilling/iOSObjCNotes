//
//  UIImage+Extension.h
//  01-QQ聊天
//
//  Created by apple on 14-5-30.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  拉伸图片
 *
 *  @param imageName 图片名称
 *
 *  @return 拉伸后的图片
 */
+ (UIImage *)resizableImageWithName:(NSString *)imageName;

@end
