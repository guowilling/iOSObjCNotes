//
//  SRTagRecommendCell.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRTagRecommendCell.h"
#import "SRTagRecommend.h"

@interface SRTagRecommendCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image_list;
@property (weak, nonatomic) IBOutlet UILabel *theme_name_label;
@property (weak, nonatomic) IBOutlet UILabel *sub_number_label;

@end

@implementation SRTagRecommendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    SRTagRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:tagRecommendCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.image_list.layer.cornerRadius = 10;
    self.image_list.layer.masksToBounds = YES;
    
//    self.image_list.backgroundColor = SRRandomColor;
//    self.theme_name_label.backgroundColor = SRRandomColor;
//    self.sub_number_label.backgroundColor = SRRandomColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

- (void)setTagRecommend:(SRTagRecommend *)tagRecommend {
    
    _tagRecommend = tagRecommend;
    
    [self.image_list sd_setImageWithURL:[NSURL URLWithString:tagRecommend.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.theme_name_label.text = tagRecommend.theme_name;
    self.sub_number_label.text = tagRecommend.sub_number;
}


- (void)setFrame:(CGRect)frame {
    
    // 调整 CELL 间距
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
