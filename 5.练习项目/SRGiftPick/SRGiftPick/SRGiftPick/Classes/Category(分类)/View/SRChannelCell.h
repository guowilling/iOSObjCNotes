//
//  SRChannelCell.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRChannel;

static NSString * const channelCellID = @"channelCell";

@interface SRChannelCell : UICollectionViewCell

@property (nonatomic, strong) SRChannel *channel;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

@end
