//
//  SRStatusPicturesView.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/28.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRStatusPicturesView.h"
#import "SRStatusPictureView.h"
#import "SRPicture.h"
#import "SRHomeViewController.h"
#import "SRPictureBrowser.h"
#import "SRPictureModel.h"

#define SRStatusPictureWH      82
#define SRStatusPictureMargin  12
#define SRStatusPictureMaxCol(count) ((count == 4) ? 2 : 3)

@implementation SRStatusPicturesView

+ (instancetype)statusPicturesView {
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

+ (CGSize)sizeWithCount:(NSInteger)count {
    NSInteger maxcol = SRStatusPictureMaxCol(count);
    NSInteger columns = (count < maxcol) ? count : maxcol;
    NSInteger rows = ((count - 1) / maxcol) + 1;
    CGFloat width = columns * SRStatusPictureWH + (columns - 1) * SRStatusPictureMargin;
    CGFloat height = rows * SRStatusPictureWH + (rows - 1) * SRStatusPictureMargin;
    return CGSizeMake(width, height);
}

- (void)setPictures:(NSArray *)pictures {
    _pictures = pictures;
    
    // 创建足够的子控件
    while (self.subviews.count < pictures.count) {
        SRStatusPictureView *picView = [SRStatusPictureView pictureView];
        picView.userInteractionEnabled = YES;
        [self addSubview:picView];
    }
    
    // 遍历子控件设置图片
    for (int i = 0; i < self.subviews.count; i++) {
        SRStatusPictureView *picView = self.subviews[i];
        picView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [picView addGestureRecognizer:tap];
        if (i < pictures.count) {
            picView.hidden = NO;
            picView.picture = pictures[i];
        } else {
            picView.hidden = YES; // 防止cell复用的时候出错
        }
    }
}

- (void)tap:(UITapGestureRecognizer *)tap {
    UIImageView *tapedView = (UIImageView *)tap.view;
    NSMutableArray *imageBrowserModels = [NSMutableArray array];
    for (NSInteger i = 0; i < self.pictures.count; i ++) {
        SRPicture *pic = self.pictures[i];
        //NSURL *thumbnailURL = [NSURL URLWithString:pic.thumbnail_pic];
        NSURL *HDURL = [NSURL URLWithString:[pic.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"]];
        
        SRPictureModel *imageBrowserModel = [SRPictureModel sr_pictureModelWithPicURLString:HDURL.absoluteString
                                                                              containerView:tapedView.superview
                                                                        positionInContainer:self.subviews[i].frame
                                                                                      index:i];
        [imageBrowserModels addObject:imageBrowserModel];
    }
    [SRPictureBrowser sr_showPictureBrowserWithModels:imageBrowserModels currentIndex:tapedView.tag delegate:nil];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger count = self.pictures.count;
    NSInteger maxcol = SRStatusPictureMaxCol(count);
    for (int i = 0; i < count; i++) {
        SRStatusPictureView *picView = self.subviews[i];
        NSInteger col = i % maxcol;
        NSInteger row = i / maxcol;
        picView.x = col * (SRStatusPictureWH + SRStatusPictureMargin);
        picView.y = row * (SRStatusPictureWH + SRStatusPictureMargin);
        picView.width = SRStatusPictureWH;
        picView.height = SRStatusPictureWH;
    }
}

@end
