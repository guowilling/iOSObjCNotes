/*
 作者：MJ
 描述：
 时间：
 文件名：Hashiqi.h
 */
#import "Dog.h"

@protocol MyDogProtocol <NSObject>
- (void)dogTest;
@end

@interface Hashiqi : Dog<MyDogProtocol>
- (void)addTest;
@end

// 分类
@interface Hashiqi (Add)
- (void)addTest;
@end