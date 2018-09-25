//
//  main.m
//  05-成员变量的作用域
//
//  Created by apple on 13-8-7.
//  Copyright (c) 2013年 itcast. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"

@implementation Car : NSObject

{
@public
    int _speed;
    
@protected
    int _wheels;
}

- (void)setSpeed:(int)speed
{
    _speed = speed;
}
- (int)speed
{
    return _speed;
}

@end


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        Student *stu = [Student new];
        
        [stu setHeight:170];

        NSLog(@"%d", [stu height]);
        
        Person *p = [Person new];
        
        p->_age = 25;
        
//        p->_height = 20;
        
//        p->aaa = 20;
    
    }
    return 0;
}



