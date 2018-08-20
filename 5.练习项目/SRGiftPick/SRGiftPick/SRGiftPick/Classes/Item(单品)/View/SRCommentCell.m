//
//  SRCommentCell.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/5.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRCommentCell.h"
#import "SRComment.h"

@interface SRCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nikenameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation SRCommentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString * const commentCellID = @"commentCellID";
    SRCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.sr_width * 0.5;
    self.iconImageView.clipsToBounds = YES;
    
//    self.iconImageView.backgroundColor = SRRandomColor;
//    self.nikenameLabel.backgroundColor = SRRandomColor;
//    self.commentLabel.backgroundColor = SRRandomColor;
//    self.timeLabel.backgroundColor = SRRandomColor;
}

- (void)setComment:(SRComment *)comment {
    
    _comment = comment;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:comment.avatar_url]
                          placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nikenameLabel.text = comment.nickname;
    self.commentLabel.text = comment.content;
    self.timeLabel.text = comment.created_at;
}

@end
