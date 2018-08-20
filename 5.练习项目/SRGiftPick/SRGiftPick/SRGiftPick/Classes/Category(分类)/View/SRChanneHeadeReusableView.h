//
//  SRChanneSectionHeader.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SRChannelGroup;

static NSString * const channelHeaderID = @"channelHeader";

@interface SRChanneHeadeReusableView : UICollectionReusableView

@property (nonatomic, strong) SRChannelGroup *channelGroup;

+ (instancetype)reuseViewWithCollectionView:(UICollectionView *)collectionView foxIndexPath:(NSIndexPath *)indexPath;

@end
