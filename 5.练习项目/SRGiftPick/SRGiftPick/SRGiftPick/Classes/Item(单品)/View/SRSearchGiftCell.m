//
//  SRSearchGiftCell.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/5.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRSearchGiftCell.h"
#import "UIImageView+WebCache.h"
#import "SRSearchGift.h"

@interface SRSearchGiftCell ()

@property (weak, nonatomic) IBOutlet UIImageView *giftImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;

@end

@implementation SRSearchGiftCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
    
    SRSearchGiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:giftCellID forIndexPath:indexPath];
    return cell;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self.nameLable sizeToFit];
    
//    self.backgroundColor = SRRandomColor;
//    self.giftImageView.backgroundColor = SRRandomColor;
//    self.nameLable.backgroundColor = SRRandomColor;
//    self.priceLable.backgroundColor = SRRandomColor;
//    self.favoriteBtn.backgroundColor = SRRandomColor;
}

- (void)setGift:(SRSearchGift *)gift {
    
    _gift = gift;
    
    self.nameLable.text = gift.name;
    self.priceLable.text = [NSString stringWithFormat:@"%@", gift.price];
    [self.giftImageView sd_setImageWithURL:[NSURL URLWithString:gift.cover_image_url]
                          placeholderImage:[UIImage imageNamed:@"searchGift_placeHolder"]];
    [self.favoriteBtn setTitle:gift.favorites_count forState:UIControlStateNormal];
}

@end
