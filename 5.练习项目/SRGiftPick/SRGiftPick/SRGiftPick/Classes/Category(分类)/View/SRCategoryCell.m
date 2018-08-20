//
//  SRCategoryCell.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRCategoryCell.h"
#import "SRCategory.h"

@interface SRCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView  *redView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SRCategoryCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    SRCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.backgroundColor = SRRGBColor(244, 244, 244);
    
//    self.backgroundColor = SRRandomColor;
//    self.redView.backgroundColor = SRRandomColor;
//    self.label.backgroundColor = SRRandomColor;
}

- (void)setCategory:(SRCategory *)category {
    
    _category = category;
    
    self.label.text = category.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    self.redView.hidden = !selected;
    
    self.label.textColor = selected ? [UIColor redColor] : SRRGBColor(78, 78, 78);
}

@end
