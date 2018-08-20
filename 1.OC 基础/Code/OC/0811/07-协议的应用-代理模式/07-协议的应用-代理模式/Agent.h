//
//  Agent.h
//  07-协议的应用-代理模式
//
//  Created by apple on 13-6-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//  负责询问电影票情况的代理

#import <Foundation/Foundation.h>
#import "TicketDelegate.h"

@interface Agent : NSObject <TicketDelegate>

@end
