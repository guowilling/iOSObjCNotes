//
//  contact.h
//  简易通讯录
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *number;

@end
