//
//  SRSubCategoryCell.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRSubCategoryCell.h"
#import "SRSubCategory.h"

@interface SRSubCategoryCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@end

@implementation SRSubCategoryCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
    
    SRSubCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:subCategoryCellID forIndexPath:indexPath];
    return cell;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
//    self.backgroundColor = SRRandomColor;
//    self.iconImageVIew.backgroundColor = SRRandomColor;
//    self.nameLable.backgroundColor = SRRandomColor;
}

- (void)setSubCategory:(SRSubCategory *)subCategory {
    
    _subCategory =  subCategory;
    
    [self.iconImageVIew sd_setImageWithURL:[NSURL URLWithString:subCategory.icon_url] placeholderImage:[UIImage imageNamed:@"searchGift_placeHolder"]];
    
    [self.nameLable setText:subCategory.name];
}

@end
