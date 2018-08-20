//
//  SRBrandCell.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRBrandCell.h"
#import "SRBrand.h"

static const CGFloat SRBrandCellMargin = 2;

@interface SRBrandCell ()

@property (weak, nonatomic) IBOutlet UIView *topContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIView *imageContainerView;
@property (weak, nonatomic) UIImageView *bigImageView;
@property (strong, nonatomic) NSMutableArray *smallImageViews;

@end

@implementation SRBrandCell

- (NSMutableArray *)smallImageViews {
    
    if (_smallImageViews == nil) {
        _smallImageViews = @[].mutableCopy;
    }
    return _smallImageViews;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self createImageViews];
    
//    self.topContainerView.backgroundColor = SRRandomColor;
//    self.iconImageView.backgroundColor = SRRandomColor;
//    self.nameLabel.backgroundColor = SRRandomColor;
//    self.descLabel.backgroundColor = SRRandomColor;
//    self.imageContainerView.backgroundColor = SRRandomColor;
}

- (void)createImageViews {
    
    UIImageView *bigIV = [[UIImageView alloc] init];
    [self.imageContainerView addSubview:bigIV];
    self.bigImageView = bigIV;
    
    for (int i = 0; i < 4; i++) {
        UIImageView *smallIV = [[UIImageView alloc] init];
        [self.imageContainerView addSubview:smallIV];
        [self.smallImageViews addObject:smallIV];
    }
}

- (void)setBrand:(SRBrand *)brand {
    
    _brand = brand;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:brand.cover_image_url]
                          placeholderImage:[UIImage imageNamed:@"searchGift_placeHolder"]];
    
    self.nameLabel.text = brand.name;
    self.descLabel.text = brand.desc;
    
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:[brand.image_urls firstObject]]
                         placeholderImage:[UIImage imageNamed:@"searchGift_placeHolder"]];
    
    for (int i = 0; i < 4; i++) {
        UIImageView *smallImageView = self.smallImageViews[i];
        [smallImageView sd_setImageWithURL:[NSURL URLWithString:brand.image_urls[i + 1]]
                          placeholderImage:[UIImage imageNamed:@"searchGift_placeHolder"]];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // CELL 边距
    //self.contentView.sr_x = SRCellUIEdgeInsets.left;
    //self.contentView.sr_height -= SRCellUIEdgeInsets.bottom;
    //self.contentView.sr_width -= SRCellUIEdgeInsets.right + SRCellUIEdgeInsets.left;
    
//    CGFloat imageContentViewW = self.contentView.sr_width - 2 *(SRCellUIEdgeInsets.right + SRCellUIEdgeInsets.left);
//    CGFloat imageContentViewH = self.contentView.sr_height - CGRectGetMaxY(self.topContainerView.frame) - SRCellUIEdgeInsets.top  - SRCellUIEdgeInsets.bottom;
//    self.imageContainerView.sr_size = CGSizeMake(imageContentViewW, imageContentViewH);
    
    CGFloat bigImageViewX = self.imageContainerView.sr_width * 0.5;
    CGFloat smallImageViewOriginX = 0 ;
    if (self.isBigImageViewLeft) {
        smallImageViewOriginX = bigImageViewX;
        bigImageViewX = 0;
    }
    self.bigImageView.frame = CGRectMake(bigImageViewX, 0, self.imageContainerView.sr_width * 0.5, self.imageContainerView.sr_height);
    [self setupImageViewMargin:self.bigImageView];
    
    NSInteger columns = 2;
    CGFloat smallImageViewW = self.imageContainerView.sr_width * 0.5 * 0.5;
    CGFloat smallImageViewH = self.imageContainerView.sr_height * 0.5;
    CGFloat smallImageViewX = 0;
    CGFloat smallImageViewY = 0;
    for (NSInteger i = 0; i < self.smallImageViews.count; i++) {
        UIImageView *smallImageView = self.smallImageViews[i];
        smallImageViewX = i % columns * smallImageViewW + smallImageViewOriginX;
        smallImageViewY = i / columns * smallImageViewH;
        smallImageView.frame = CGRectMake(smallImageViewX, smallImageViewY, smallImageViewW, smallImageViewH);
        [self setupImageViewMargin:smallImageView];
    }
}

- (void)setupImageViewMargin:(UIImageView *)imageView {
    
    imageView.sr_x += SRBrandCellMargin;
    imageView.sr_y += SRBrandCellMargin;
    imageView.sr_width -= 2 * SRBrandCellMargin;
    imageView.sr_height -= 2 * SRBrandCellMargin;
}

@end
