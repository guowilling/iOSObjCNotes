//
//  TgCell.m
//  团购cell
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "TgCell.h"
#import "TgModel.h"

@interface TgCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyCountLabel;
@end
@implementation TgCell

+ (TgCell *)tgCellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"tgCell";
    TgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TgCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.contentView.backgroundColor = [UIColor orangeColor];
    } else {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setTgModel:(TgModel *)tgModel {
    _tgModel = tgModel;
    self.iconImageView.image = [UIImage imageNamed:tgModel.icon];
    self.titleLabel.text = tgModel.title;
    self.priceLabel.text = tgModel.price;
    self.buyCountLabel.text = [NSString stringWithFormat:@"%@人购买", tgModel.buyCount];
}

#pragma mark - 初始化视图
/**
 * 通过代码创建时调用
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    NSLog(@"%s", __func__);
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
/**
 * 通过XIB或者Storyboard加载后调用
 */
- (void)awakeFromNib {
//    NSLog(@"%s", __func__);
//    self.contentView.backgroundColor = [UIColor clearColor];
}

@end
