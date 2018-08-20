//
//  StatusCell.m
//  微博cell
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "StatusCell.h"
#import "Status.h"
#import "StatusFrame.h"

@interface StatusCell ()

@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *vipIV;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *pictureIV;

@end

@implementation StatusCell

- (UIImageView *)iconIV {
    if (_iconIV == nil) {
        _iconIV = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconIV];
    }
    return _iconIV;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = kNameFont;
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UIImageView *)vipIV {
    if (_vipIV == nil) {
        _vipIV = [[UIImageView alloc] init];
        _vipIV.image = [UIImage imageNamed:@"vip"];
        _vipIV.hidden = YES;
        [self.contentView addSubview:_vipIV];
    }
    return _vipIV;
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = kTextFont;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIImageView *)pictureIV {
    if (_pictureIV == nil) {
        _pictureIV = [[UIImageView alloc] init];
        _pictureIV.hidden = YES;
        [self.contentView addSubview:_pictureIV];
    }
    return _pictureIV;
}

- (void)setStatusFrame:(StatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    [self setupData];
    [self setupFrame];
}

- (void)setupData {
    Status *status = self.statusFrame.status;
    
    self.iconIV.image = [UIImage imageNamed:status.icon];
    self.nameLabel.text = status.name;
    if (status.vip) {
        self.vipIV.hidden = NO;
        self.nameLabel.textColor = [UIColor redColor];
    } else {
        self.vipIV.hidden = YES;
        self.nameLabel.textColor =[UIColor blackColor];
    }
    self.contentLabel.text = status.text;
    if (status.picture.length) {
        self.pictureIV.hidden = NO;
        self.pictureIV.image = [UIImage imageNamed:status.picture];
    } else {
        self.pictureIV.hidden = YES;
    }
}

- (void)setupFrame {
    self.iconIV.frame = self.statusFrame.iconF;
    self.nameLabel.frame = self.statusFrame.nameF;
    self.vipIV.frame = self.statusFrame.vipF;
    self.contentLabel.frame = self.statusFrame.textF;
    if (self.statusFrame.status.picture.length) {
        self.pictureIV.frame = self.statusFrame.pictureF;
    }
}

@end
