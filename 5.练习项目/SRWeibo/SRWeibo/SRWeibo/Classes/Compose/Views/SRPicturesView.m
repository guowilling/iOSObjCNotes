//
//  SRPicturesView.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRPicturesView.h"

@implementation SRPicturesView

//@synthesize pictures = _pictures;

+ (instancetype)picturesView {
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _pictures = [NSMutableArray array];
    }
    return self;
}

// readonly 重写 getter方法 后, 不会自动生成对应的成员变量 _pictures.
//- (NSMutableArray *)pictures {
//    if (!_pictures) {
//        _pictures = [NSMutableArray array];
//    }
//    return _pictures;
//}

- (void)addPicture:(UIImage *)picture {
    [self.pictures addObject:picture];
    
    UIImageView *picView = [[UIImageView alloc] init];
    picView.image = picture;
    [self addSubview:picView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    NSInteger maxCol = 3;
    CGFloat w = 90;
    CGFloat h = 90;
    for (int i =0; i < count; i++) {
        UIImageView *imageView = self.subviews[i];
        NSInteger col = i % maxCol;
        NSInteger row = i / maxCol;
        CGFloat x = col * (w + 10);
        CGFloat y = row * (h + 10);
        imageView.frame = CGRectMake(x, y, w, h);
    }
}

@end
