//
//  SRItemCell.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRItemCell.h"
#import "SRItem.h"
#import "SRLikeCountButton.h"

@interface SRItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet SRLikeCountButton *likeCountBtn;

@end

@implementation SRItemCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * const itemCellID = @"itemCellID";
    SRItemCell *cell = [tableView dequeueReusableCellWithIdentifier:itemCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor blackColor].CGColor];
    gradientLayer.opacity = 1.0;
    gradientLayer.frame = CGRectMake(0, 0, SRScreenW - SRCellUIEdgeInsets.right - SRCellUIEdgeInsets.left, self.titleLabel.superview.sr_height);
    [self.titleLabel.superview.layer insertSublayer:gradientLayer below:self.titleLabel.layer];
    
//    self.bgImageView.backgroundColor  = SRRandomColor;
//    self.titleLabel.backgroundColor   = SRRandomColor;
//    self.likeCountBtn.backgroundColor = SRRandomColor;
}

- (void)setItem:(SRItem *)item {
    
    _item = item;
    
    self.titleLabel.text = item.title;
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:item.cover_image_url] placeholderImage:nil];
    [self.likeCountBtn setTitle:[NSString stringWithFormat:@"%zd", item.likes_count] forState:UIControlStateNormal];
}

- (IBAction)likeCountBtnOnClick:(SRLikeCountButton *)sender {
    
    SRLog(@"喜欢");
}

@end
