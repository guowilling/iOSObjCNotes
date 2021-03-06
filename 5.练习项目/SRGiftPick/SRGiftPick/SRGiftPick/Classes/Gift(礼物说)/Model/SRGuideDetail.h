//
//  SRGuideDetail.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRGuideDetail : NSObject

@property (assign, nonatomic) NSInteger comments_count;
@property (copy, nonatomic) NSString *content_html;
@property (copy, nonatomic) NSString *content_url;
@property (copy, nonatomic) NSString *cover_image_url;
@property (copy, nonatomic) NSString *created_at;
@property (copy, nonatomic) NSString *ID;
@property (strong, nonatomic) NSArray *label_ids;
@property (assign, nonatomic) BOOL liked;
@property (assign, nonatomic) NSInteger likes_count;
@property (copy, nonatomic) NSString *published_at;
@property (copy, nonatomic) NSString *share_msg;
@property (assign, nonatomic) NSInteger shares_count;
@property (copy, nonatomic) NSString *short_title;
@property (assign, nonatomic) NSInteger status;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *updated_at;
@property (copy, nonatomic) NSString *url;

@end
