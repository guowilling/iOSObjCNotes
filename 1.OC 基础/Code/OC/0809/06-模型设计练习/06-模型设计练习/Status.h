/*
 作者：MJ
 描述：一条微博
 时间：
 文件名：Status.h
 */
#import <Foundation/Foundation.h>
#import "User.h"

// 微博内容、微博配图、发送时间、微博发送人、转发的微博、被评论数、被转发数

@interface Status : NSObject

@property (nonatomic, retain) NSString *text;

@property (nonatomic, retain) NSString *icon;

@property (nonatomic, assign) long time;

@property (nonatomic, retain) User *user;

@property (nonatomic, retain) Status *retweetStatus;

@property (nonatomic, assign) int commentsCount;

@property (nonatomic, assign) int retweetsCount;

@end
