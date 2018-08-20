//
//  SRBrandHeaderView.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/7.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRBrandHomeHeader.h"
#import "SRBrandHome.h"

@interface SRBrandHomeHeader ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation SRBrandHomeHeader

+ (instancetype)brandHomeHeader {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.sr_width * 0.5;
    self.iconImageView.clipsToBounds = YES;
    
//    self.bgImageView.backgroundColor = SRRandomColor;
//    self.iconImageView.backgroundColor = SRRandomColor;
//    self.nameLabel.backgroundColor = SRRandomColor;
//    self.descLabel.backgroundColor = SRRandomColor;
}

- (void)setBrandHome:(SRBrandHome *)brandHome {
    
    _brandHome = brandHome;
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:brandHome.cover_image_url]
                        placeholderImage:[UIImage imageNamed:@"searchGift_placeHolder"]];
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:brandHome.icon_url]
                          placeholderImage:[UIImage imageNamed:@"searchGift_placeHolder"]];
    
    self.nameLabel.text = brandHome.name;
    self.descLabel.text = brandHome.desc;
}

@end
