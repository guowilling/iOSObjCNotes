//
//  MyProtocol.h
//  05-protocol
//
//  Created by apple on 13-8-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyProtocol1 <NSObject>

- (void)test4;

@required // 默认
- (void)test;
- (void)test2;

@optional
- (void)test3;

@end
