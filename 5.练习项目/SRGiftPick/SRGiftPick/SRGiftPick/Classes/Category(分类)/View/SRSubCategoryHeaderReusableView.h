//
//  SRSubCategoryHeaderReusableView.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SRCategory.h"

static NSString * const subCategoryHeaderID = @"subCategoryHeader";

@interface SRSubCategoryHeaderReusableView : UICollectionReusableView

@property (nonatomic, strong) SRCategory *category;

+ (instancetype)resuableViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@end
