//
//  SRRecommendUserCell.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRRecommendUserCell.h"
#import "SRRecommendUser.h"

@interface SRRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *screen_name_label;
@property (weak, nonatomic) IBOutlet UILabel *fans_count_label;
@property (weak, nonatomic) IBOutlet UIView *separateLine;

@end

@implementation SRRecommendUserCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    //self.selectionStyle = UITableViewCellSelectionStyleNone; //xib 中可以直接设置.
    
    self.headerView.layer.cornerRadius = self.headerView.sr_width * 0.5;
    self.headerView.layer.masksToBounds = YES;
    self.separateLine.backgroundColor = SRRGBColor(235, 235, 235);
    
//    self.headerView.backgroundColor = SRRandomColor;
//    self.screen_name_label.backgroundColor = SRRandomColor;
//    self.fans_count_label.backgroundColor = SRRandomColor;
//    self.separateLine.backgroundColor = SRRandomColor;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    SRRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendUserCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setUser:(SRRecommendUser *)user {
    
    _user = user;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:user.header]
                       placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  self.headerView.image = [UIImage circleImageWithImage:image borderWidth:0 borderColor:nil];
                              }];
    self.screen_name_label.text = user.screen_name;
    NSInteger fansCount = [user.fans_count integerValue];
    self.fans_count_label.text = fansCount > 10000 ? [NSString stringWithFormat:@"%.1f万人关注",fansCount /10000.0] : [NSString stringWithFormat:@"%zd人关注",fansCount];
}

@end
