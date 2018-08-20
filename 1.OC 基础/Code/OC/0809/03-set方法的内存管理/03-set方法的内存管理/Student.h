/*
 作者：MJ
 描述：
 时间：
 文件名：Student.h
 */
#import <Foundation/Foundation.h>
#import "Car.h"
#import "Dog.h"

@interface Student : NSObject
{
    int _no;
    NSString *_name;
    Car *_car;
    Dog *_dog;
}

- (void)setNo:(int)no;
- (int)no;

- (void)setName:(NSString *)name;
- (NSString *)name;

- (void)setCar:(Car *)car;
- (Car *)car;

- (void)setDog:(Dog *)dog;
- (Dog *)dog;

@end
