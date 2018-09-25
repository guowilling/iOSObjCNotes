/*
 作者：MJ
 描述：微博用户
 时间：
 文件名：User.h
 */
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

// 姓名、微博号码、密码、头像、性别、手机、生日
@interface User : NSObject

@property (nonatomic, retain) NSString *name;

@property (nonatomic, retain) NSString *account;

@property (nonatomic, retain) NSString *password;

@property (nonatomic, retain) NSString *icon;

@property (nonatomic, assign) Sex sex;

@property (nonatomic, retain) NSString *phone;

@property (nonatomic, assign) Date birthday;

@end
