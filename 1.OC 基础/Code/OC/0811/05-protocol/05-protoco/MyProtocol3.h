//
//  MyPrototol3.h
//  05-protocol
//
//  Created by apple on 13-8-11.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyProtocol1.h"


// 一个协议遵守了另外一个协议, 就拥有另一个协议的所有方法声明
@protocol MyProtocol3 <MyProtocol1>

- (void)hehe;

@end
