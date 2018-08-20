//
//  SRCommentCell.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRCommentCell.h"
#import "SRComment.h"
#import "SRUser.h"

static NSString * const SRUserSexMale = @"m";
static NSString * const SRUserSexFemale = @"f";

@interface SRCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profile_imageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *like_countLabel;

@end

@implementation SRCommentCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    SRCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    self.profile_imageView.backgroundColor = SRRandomColor;
//    self.sexImageView.backgroundColor = SRRandomColor;
//    self.usernameLabel.backgroundColor = SRRandomColor;
//    self.contentLabel.backgroundColor = SRRandomColor;
//    self.like_countLabel.backgroundColor = SRRandomColor;
}

- (void)setComment:(SRComment *)comment {
    
    _comment = comment;

    [self.profile_imageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image]
                              placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         self.profile_imageView.image = [UIImage circleImageWithImage:image borderWidth:0 borderColor:nil];
                                     }];
    self.sexImageView.image = [comment.user.sex isEqualToString:SRUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.usernameLabel.text = comment.user.username;
    self.contentLabel.text = comment.content;
    self.like_countLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

@end
