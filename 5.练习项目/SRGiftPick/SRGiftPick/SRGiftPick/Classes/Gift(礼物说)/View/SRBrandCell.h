//
//  SRBrandCell.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRBrand;

static NSString * const brandCellID = @"brandCellID";

@interface SRBrandCell : UITableViewCell

@property (nonatomic, strong) SRBrand *brand;

@property (nonatomic, assign, getter=isBigImageViewLeft) BOOL bigImageViewLeft;

@end
