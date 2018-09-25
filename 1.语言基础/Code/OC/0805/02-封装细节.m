
#import <Foundation/Foundation.h>

typedef enum {
    SexMan,
    SexWoman
} Sex;


@interface Student : NSObject
{
  
  // 成员变量命名规范：以_下划线开头
    int _no;
    Sex _sex;
}

// sex的set和get方法
- (void)setSex:(Sex)sex;
- (Sex)sex;

// no的set和get方法
- (void)setNo:(int)no;
- (int)no;

@end

@implementation Student

- (void)setSex:(Sex)sex
{
    _sex = sex;
}
- (Sex)sex
{
    return _sex;
}

- (void)setNo:(int)no
{
    _no = no;
}
- (int)no
{
    return _no;
}

@end


int main()
{
    Student *stu = [Student new];
    
    [stu setSex:SexMan];
    [stu setNo:10];
    
    [stu sex];
    
    [stu no];
    
    return 0;
}