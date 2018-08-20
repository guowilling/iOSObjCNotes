//
//  SRSubCategoryHeaderReusableView.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRSubCategoryHeaderReusableView.h"

@interface SRSubCategoryHeaderReusableView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SRSubCategoryHeaderReusableView

+ (instancetype)resuableViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
    
    SRSubCategoryHeaderReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                       withReuseIdentifier:subCategoryHeaderID
                                                                                              forIndexPath:indexPath];
    return reusableView;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
//    self.backgroundColor = SRRandomColor;
//    self.titleLabel.backgroundColor = SRRandomColor;
}

- (void)setCategory:(SRCategory *)category {
    
    _category = category;
    
    self.titleLabel.text = category.name;
}

@end
