//
//  SRChannelCell.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRChannelCell.h"
#import "SRChannel.h"

@interface SRChannelCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SRChannelCell

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
    
    SRChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:channelCellID forIndexPath:indexPath];
    return cell;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
//    self.backgroundColor = SRRandomColor;
//    self.iconImageView.backgroundColor = SRRandomColor;
//    self.nameLabel.backgroundColor = SRRandomColor;
}

- (void)setChannel:(SRChannel *)channel {
    
    _channel = channel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:channel.icon_url] placeholderImage:[UIImage imageNamed:@"searchGift_placeHolder"]];
    
    self.nameLabel.text = channel.name;
}

@end
