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

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *account;

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *icon;

@property (nonatomic, assign) Sex sex;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, assign) Date birthday;

@end
