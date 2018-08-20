//
//  SRSubCategoryCell.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRSubCategory;

static NSString * const subCategoryCellID = @"subCategoryCell";

@interface SRSubCategoryCell : UICollectionViewCell

@property (nonatomic, strong) SRSubCategory *subCategory;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@end
