//
//  Person.h
//  06-@property和@synthesize
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    int _age;
    
    int _height;
    
    double _weight;
    
    NSString *_name;
}

// @property自动生成setter和getter声明
@property int age;
// - (void)setAge:(int)age;
// - (int)age;

@property int height;
// - (void)setHeight:(int)height;
// - (int)height;


@property double weight;

@property NSString *name;

@end
