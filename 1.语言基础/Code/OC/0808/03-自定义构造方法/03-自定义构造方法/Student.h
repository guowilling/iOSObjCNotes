//
//  Student.h
//  03-自定义构造方法
//
//  Created by apple on 13-8-8.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Person.h"

@interface Student : Person

@property int no;

- (id)initWithNo:(int)no;

- (id)initWithName:(NSString *)name andAge:(int)age andNo:(int)no;

@end
