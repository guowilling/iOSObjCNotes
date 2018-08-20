//
//  SRRecommendCategoryCell.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/20.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRRecommendCategoryCell.h"
#import "SRRecommendCategory.h"

@interface SRRecommendCategoryCell ()

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation SRRecommendCategoryCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.backgroundColor = SRRGBColor(244, 244, 244);
    
//    self.categoryLabel.backgroundColor = SRRandomColor;
//    self.redView.backgroundColor = SRRandomColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    self.redView.hidden = !selected;
    self.categoryLabel.textColor = selected ? SRRGBColor(225, 25, 25) : SRRGBColor(78, 78, 78);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    SRRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCategoryCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setRecommendCategory:(SRRecommendCategory *)recommendCategory {
    
    _recommendCategory = recommendCategory;
    
    self.categoryLabel.text = recommendCategory.name;
}

@end
