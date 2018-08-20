//
//  SRMeCell.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRMeCell.h"

@implementation SRMeCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *square = @"square";
    SRMeCell *cell = [tableView dequeueReusableCellWithIdentifier:square];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:square];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *backgroundView = [[UIImageView alloc] init];
    backgroundView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = backgroundView;
    
    self.textLabel.textColor = [UIColor darkGrayColor];
    self.textLabel.font = [UIFont systemFontOfSize:15];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    self.imageView.sr_width = 30;
    self.imageView.sr_height = 30;
    self.imageView.sr_centerY = self.contentView.sr_height * 0.5;
    
    self.textLabel.sr_x = CGRectGetMaxX(self.imageView.frame) + 10;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
