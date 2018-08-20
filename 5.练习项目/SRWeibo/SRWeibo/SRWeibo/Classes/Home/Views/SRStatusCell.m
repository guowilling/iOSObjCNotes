//
//  SRStatusCell.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRStatusCell.h"
#import "SRStatusFrame.h"
#import "SRStatus.h"
#import "SRUser.h"
#import "UIImageView+WebCache.h"
#import "SRPicture.h"
#import "SRStatusToolBar.h"
#import "SRStatusAuthorAvatar.h"
#import "SRStatusPicturesView.h"
#import "SRStatusTextView.h"

static NSString * const SRStatusCellID = @"SRStatusCell";

@interface SRStatusCell ()

/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) SRStatusAuthorAvatar *iconImageView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nicknameLabel;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipImageView;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLable;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
//@property (nonatomic, weak) UILabel *contentLable;
@property (nonatomic, weak) SRStatusTextView *contentTextView; // Notice: UITextView 才能点击选中某个范围
/** 配图 */
@property (nonatomic, weak) SRStatusPicturesView *picturesView;

/** 转发微博整体 */
@property (nonatomic, weak) UIView *retweetView;
/** 转发微博昵称:正文 */
//@property (nonatomic, weak) UILabel *retweetContentLable;
@property (nonatomic, weak) SRStatusTextView *retweetContentTextView;
/** 转发微博配图 */
@property (nonatomic, weak) SRStatusPicturesView *retweetPicsView;

/** 工具条 */
@property (nonatomic, weak) SRStatusToolBar *toolBar;

@end

@implementation SRStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    SRStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:SRStatusCellID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SRStatusCellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // cell 背景色
//        self.selectedBackgroundView.backgroundColor = SRRandomColor; // 无效
//        UIView *view = [[UIView alloc] init]; // 有效
//        view.backgroundColor = SRRandomColor;
//        self.selectedBackgroundView = view;
        
        [self setupOriginalStatus];
        [self setupRetweetStatus];
        [self setupToolBar];
    }
    return self;
}

// 原创微博
- (void)setupOriginalStatus {
    // 整体
    UIView *originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
//    self.originalView.backgroundColor = SRRandomColor;
    
    // 头像
    SRStatusAuthorAvatar *iconImageView = [[SRStatusAuthorAvatar alloc] init];
    [originalView addSubview:iconImageView];
    self.iconImageView = iconImageView;
//    self.iconImageView.backgroundColor = SRRandomColor;
    
    // 昵称
    UILabel *nicknameLabel = [[UILabel alloc] init];
    nicknameLabel.font = SRNameFont;
    nicknameLabel.textColor = [UIColor lightGrayColor];
    [originalView addSubview:nicknameLabel];
    self.nicknameLabel = nicknameLabel;
//    self.nicknameLabel.backgroundColor = SRRandomColor;
    
    // 会员图标
    UIImageView *vipImageView = [[UIImageView alloc] init];
    vipImageView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipImageView];
    self.vipImageView = vipImageView;
//    self.vipImageView.backgroundColor = SRRandomColor;
    
    // 时间
    UILabel *timeLable = [[UILabel alloc] init];
    timeLable.font = SRTimeFont;
    timeLable.textColor = [UIColor orangeColor];
    [originalView addSubview:timeLable];
    self.timeLable = timeLable;
//    self.timeLable.backgroundColor = SRRandomColor;
    
    // 来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = SRSourceFont;
    sourceLabel.textColor = [UIColor lightGrayColor];
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
//    self.sourceLabel.backgroundColor = SRRandomColor;
    
    // 正文
    SRStatusTextView *textView = [[SRStatusTextView alloc] init];
    [originalView addSubview:textView];
    self.contentTextView = textView;
//    self.contentTextView.backgroundColor = SRRandomColor;
    
    // 配图
    SRStatusPicturesView *picturesView = [[SRStatusPicturesView alloc] init];
    [originalView addSubview:picturesView];
    self.picturesView = picturesView;
//    self.picturesView.backgroundColor = SRRandomColor;
}

// 转发微博
- (void)setupRetweetStatus {
    // 转发微博整体
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = SRColorCellBackground;
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
//    self.retweetView.backgroundColor = SRRandomColor;
    
    // 转发微博昵称:正文
    SRStatusTextView *textView = [[SRStatusTextView alloc] init];
    [retweetView addSubview:textView];
    self.retweetContentTextView = textView;
//    self.retweetContentTextView.backgroundColor = SRRandomColor;
    
    // 转发微博配图
    SRStatusPicturesView *retweetPicsView = [[SRStatusPicturesView alloc] init];
    [retweetView addSubview:retweetPicsView];
    self.retweetPicsView = retweetPicsView;
//    self.retweetPicsView.backgroundColor = SRRandomColor;
}

- (void)setupToolBar {
    
    SRStatusToolBar *toolBar = [SRStatusToolBar statusToolBar];
    toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
    [self.contentView addSubview:toolBar];
    self.toolBar = toolBar;
//    self.toolBar.backgroundColor = SRRandomColor;
}

- (void)setStatusFrame:(SRStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    
    SRStatus *status = statusFrame.status;
    SRUser *user = status.user;
    
    // 原创微博
    {
        // 整体
        self.originalView.frame = statusFrame.originalViewF;
        
        // 头像
        self.iconImageView.user = user;
        self.iconImageView.frame = statusFrame.iconImageViewF;
        
        // 昵称
        self.nicknameLabel.text = user.screen_name;
        self.nicknameLabel.frame = statusFrame.nicknameLabelF;
        
        // 会员图标
        if (user.isVip) {
            self.vipImageView.hidden = NO;
            NSString *vipImageName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
            self.vipImageView.image = [UIImage imageNamed:vipImageName];
            self.vipImageView.frame = statusFrame.vipImageViewF;
            self.nicknameLabel.textColor = [UIColor orangeColor];
        } else {
            self.vipImageView.hidden = YES;
            self.nicknameLabel.textColor = [UIColor blackColor];
        }
        
        // 时间
        self.timeLable.text = status.created_at;
        self.timeLable.frame = statusFrame.timeLableF;
        
        // 来源
        self.sourceLabel.text = status.source;
        self.sourceLabel.frame = statusFrame.sourceLabelF;
        
        // 正文
        self.contentTextView.attributedText = status.attributedText;
        self.contentTextView.frame = statusFrame.contentLableF;
        
        // 配图
        if (status.pic_urls.count) {
            self.picturesView.hidden = NO;
            self.picturesView.pictures = status.pic_urls;
            self.picturesView.frame = statusFrame.picturesViewF;
        } else {
            self.picturesView.hidden = YES;
        }
    }
    
    // 转发微博
    {
        if (status.retweeted_status) {
            SRStatus *retweetStatus = status.retweeted_status;
            self.retweetView.hidden = NO;
            
            // 整体
            self.retweetView.frame = statusFrame.retweetViewF;
            
            // 正文
            self.retweetContentTextView.attributedText = status.retweetedAttributedText;
            self.retweetContentTextView.frame = statusFrame.retweetContentLabelF;
            
            // 配图
            if (retweetStatus.pic_urls.count) {
                self.retweetPicsView.hidden = NO;
                self.retweetPicsView.pictures = retweetStatus.pic_urls;
                self.retweetPicsView.frame = statusFrame.retweetPicsViewF;
            } else {
                self.retweetPicsView.hidden = YES;
            }
        } else {
            self.retweetView.hidden = YES;
        }
    }
    
    self.toolBar.status = status;
    self.toolBar.frame = statusFrame.toolBarViewF;
}

@end
