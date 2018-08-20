//
//  SRChanneSectionHeader.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRChanneHeadeReusableView.h"
#import "SRChannelGroup.h"

@interface SRChanneHeadeReusableView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@end

@implementation SRChanneHeadeReusableView

+ (instancetype)reuseViewWithCollectionView:(UICollectionView *)collectionView foxIndexPath:(NSIndexPath *)indexPath {
    
    SRChanneHeadeReusableView *reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                  withReuseIdentifier:channelHeaderID
                                                                                         forIndexPath:indexPath];
    return reuseableView;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
//    self.backgroundColor = SRRandomColor;
//    self.titleLable.backgroundColor = SRRandomColor;
}

- (void)setChannelGroup:(SRChannelGroup *)channelGroup {
    
    _channelGroup = channelGroup;
    
    self.titleLable.text = channelGroup.name;
}

@end
