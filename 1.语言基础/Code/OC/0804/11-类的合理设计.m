
#import <Foundation/Foundation.h>

typedef enum {
    SexMan,
    SexWoman
} Sex;

typedef struct {
    int year;
    int month;
    int day;
} Date;


typedef enum {
    ColorBlack,
    ColorRed,
    ColorGreen
} Color;

@interface Dog : NSObject
{
    @public
    double weight; // 体重
    Color curColor; // 毛色
}

- (void)eat;
- (void)run;
@end

@implementation Dog
- (void)eat
{
    weight += 1;
    NSLog(@"狗吃完这次后的体重是%f", weight);
}

- (void)run
{
    weight -= 1;
    NSLog(@"狗跑完这次后的体重是%f", weight);
}
@end


@interface Student : NSObject
{
    @public
    Sex sex; // 性别
    Date birthday; // 生日
    double weight; // 体重
    Color favColor; // 喜欢的颜色
    char *name;
    
    Dog *dog; // 狗
}
- (void)eat;
- (void)run;
- (void)print;

- (void)liuDog;
- (void)weiDog;
@end

@implementation Student

- (void)liuDog
{
    [dog run];
}

- (void)weiDog
{
    [dog eat];
}

- (void)print
{
    NSLog(@"性别=%d, 喜欢的颜色=%d, 姓名=%s, 生日=%d-%d-%d", sex, favColor, name, birthday.year, birthday.month, birthday.day);
}

- (void)eat
{
    weight += 1;
    NSLog(@"学生吃完这次后的体重是%f", weight);
}

- (void)run
{
    weight -= 1;
    NSLog(@"学生跑完这次后的体重是%f", weight);
}
@end

int main()
{
    Student *s = [Student new];
    
    Dog *d = [Dog new];
    d->curColor = ColorGreen;
    d->weight = 20;
    s->dog = d;
    
    [s liuDog];
    [s weiDog];
    return 0;
}


void test()
{
    Student *s = [Student new];
    
    s->weight = 50;
    
    s->sex = SexMan;
    
    Date d = {2011, 9, 10};
    s->birthday = d;
//    s->birthday.year = 2011;
//    s->birthday.month = 9;
//    s->birthday.day = 10;
    
    s->name = "Jack";
    s->favColor = ColorBlack;
    
    [s print];
}

