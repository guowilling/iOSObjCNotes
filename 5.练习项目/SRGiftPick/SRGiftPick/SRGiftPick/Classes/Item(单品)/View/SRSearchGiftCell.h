//
//  SRSearchGiftCell.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/5.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRSearchGift;

static NSString * const giftCellID = @"giftCellID";

@interface SRSearchGiftCell : UICollectionViewCell

@property (nonatomic, strong) SRSearchGift *gift;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@end
