//
//  SRStatusPictureView.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/28.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRStatusPictureView.h"
#import "SRPicture.h"
#import "UIImageView+WebCache.h"

@interface SRStatusPictureView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation SRStatusPictureView

+ (instancetype)pictureView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        /**
         * contentMode:
         * UIViewContentModeScaleToFill     : 图片拉伸至填充UIImageView(变形)(默认)
         * UIViewContentModeScaleAspectFit  : 图片拉伸至较长的一边等于UIImageView的宽或者高, 再居中显示(不会变形)
         * UIViewContentModeScaleAspectFill : 图片拉伸至较短的一边等于UIImageView的宽或者高, 再居中显示(不会变形)
         * UIViewContentModeCenter          : 居中显示
         * 规律: 带有Scale图片会拉伸; 带有Aspect图片保持原来宽高比
         */
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

- (UIImageView *)gifView {
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return _gifView;
}

- (void)setPicture:(SRPicture *)picture {
    _picture = picture;
    
    NSURL *HDURL = [NSURL URLWithString:[picture.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"]];
    [self sd_setImageWithURL:HDURL placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if ([picture.thumbnail_pic hasSuffix:@"gif"]) {
        self.gifView.hidden = NO;
    } else {
        self.gifView.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
