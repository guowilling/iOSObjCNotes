//
//  SRChannel.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRChannel : NSObject

@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger items_count;
@property (nonatomic, assign) NSInteger ID;

@end
