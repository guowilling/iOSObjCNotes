//
//  SRTagRecommend.h
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRTagRecommend : NSObject

/** 是否含有子标签 */
@property (nonatomic, assign) NSInteger is_sub;
/** 此标签的id */
@property (nonatomic, strong) NSString *theme_id;
/** 此标签名称 */
@property (nonatomic, strong) NSString *theme_name;
/** 此标签的订阅量 */
@property (nonatomic, strong) NSString *sub_number;
/** 是否是推荐标签 */
@property (nonatomic, assign) NSInteger is_default;
/** 推荐标签的图片url地址 */
@property (nonatomic, strong) NSString *image_list;

@end
