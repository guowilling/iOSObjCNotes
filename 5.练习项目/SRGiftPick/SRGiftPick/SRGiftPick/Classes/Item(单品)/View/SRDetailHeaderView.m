//
//  SRDetailTopView.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/5.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRDetailHeaderView.h"
#import "SRSearchGift.h"
#import "SRPageScrollView.h"

@interface SRDetailHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@end

@implementation SRDetailHeaderView

+ (instancetype)detailTopView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setGift:(SRSearchGift *)gift {
    
    _gift = gift;
    
    self.pageScrollView.imageURLStrings = gift.image_urls;
    self.nameLabel.text = gift.name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", gift.price];
    self.descLabel.text = gift.giftDescription;
    
    self.sr_width = SRScreenW;

    [self layoutIfNeeded]; // !! 重新布局设置子控件 frame 后一定要调用 layoutIfNeeded
    
    self.sr_height = CGRectGetMaxY(self.descLabel.frame) + 10;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone; // 一定要设置!!
    
//    self.nameLabel.backgroundColor  = SRRandomColor;
//    self.priceLabel.backgroundColor = SRRandomColor;
//    self.descLabel.backgroundColor  = SRRandomColor;
}

@end
