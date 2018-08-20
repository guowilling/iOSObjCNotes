//
//  SRBrand.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRBrand : NSObject

@property (copy, nonatomic) NSString *cover_image_url;
@property (copy, nonatomic) NSString *created_at;
@property (copy, nonatomic) NSString *desc;
@property (assign, nonatomic) NSInteger ID;
@property (strong, nonatomic) NSArray *image_urls;
@property (assign, nonatomic) NSInteger items_count;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger status;
@property (assign, nonatomic) NSInteger updated_at;

@end
