//
//  SRTopicCell.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRTopicCell.h"
#import "SRTopic.h"
#import "SRPictureView.h"
#import "SRVoiceView.h"
#import "SRVideoView.h"

@interface SRTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profile_imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *create_timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sina_vImageView;
@property (weak, nonatomic) IBOutlet UIView *multiMediaView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeight;

@property (weak, nonatomic) IBOutlet SRToolBarButton *dingBtn;
@property (weak, nonatomic) IBOutlet SRToolBarButton *caiBtn;
@property (weak, nonatomic) IBOutlet SRToolBarButton *repostBtn;
@property (weak, nonatomic) IBOutlet SRToolBarButton *commentBtn;

@property (nonatomic, weak) SRPictureView *pictureView;
@property (nonatomic, weak) SRVoiceView   *voiceView;
@property (nonatomic, weak) SRVideoView   *videoView;

@end

@implementation SRTopicCell

#pragma mark - Lazy load

- (SRPictureView *)pictureView {
    
    if (_pictureView == nil) {
        SRPictureView *pictureView = [SRPictureView pictureView];
        [self.multiMediaView addSubview:pictureView];
        [pictureView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.multiMediaView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _pictureView = pictureView;
//        _pictureView.backgroundColor = SRRandomColor;
    }
    return _pictureView;
}

- (SRVoiceView *)voiceView {
    
    if (_videoView == nil) {
        SRVoiceView *voiceView = [SRVoiceView voiceView];
        [self.multiMediaView addSubview:voiceView];
        [voiceView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.multiMediaView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _voiceView = voiceView;
//        _voiceView.backgroundColor = SRRandomColor;
    }
    return _voiceView;
}

- (SRVideoView *)videoView {
    
    if (_videoView == nil) {
        SRVideoView *videoView = [SRVideoView videoView];
        [self.multiMediaView addSubview:videoView];
        [videoView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.multiMediaView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        _videoView = videoView;
//        _videoView.backgroundColor = SRRandomColor;
    }
    return _videoView;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    SRTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topicCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    //self.autoresizingMask = UIViewAutoresizingNone;
    //self.sr_width = SRScreenW;
    
//    self.profile_imageView.backgroundColor = SRRandomColor;
//    self.nameLabel.backgroundColor = SRRandomColor;
//    self.create_timeLabel.backgroundColor = SRRandomColor;
//    self.contentLabel.backgroundColor = SRRandomColor;
//    self.sina_vImageView.backgroundColor = SRRandomColor;
//    self.dingBtn.backgroundColor = SRRandomColor;
//    self.caiBtn.backgroundColor = SRRandomColor;
//    self.repostBtn.backgroundColor = SRRandomColor;
//    self.commentBtn.backgroundColor = SRRandomColor;
}

- (void)setTopic:(SRTopic *)topic {
    
    _topic = topic;
    
    // 头像
    [self.profile_imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image]
                              placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                         self.profile_imageView.image = [UIImage circleImageWithImage:image borderWidth:9 borderColor:nil];
                                     }];
    
    // 标题
    self.nameLabel.text = topic.name;
    
    // 发布时间
    self.create_timeLabel.text = topic.create_time;

    // 正文
    self.contentLabel.text = topic.text;

    // 会员
    self.sina_vImageView.hidden = !topic.isSina_v;
    
    // 更新约束
    self.containerHeight.constant = topic.pictureSize.height;

    if (topic.type == SRTopicTypePicture) {
        self.pictureView.topic = self.topic;
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    } else if (topic.type == SRTopicTypeVideo) {
        self.videoView.topic = self.topic;
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
    } else if (topic.type == SRTopicTypeVoice) {
        self.voiceView.topic = self.topic;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
    } else if (topic.type == SRTopicTypeText) {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    
    [self.dingBtn setTitleCount:topic.ding placeholder:@"顶"];
    [self.caiBtn setTitleCount:topic.cai placeholder:@"踩"];
    [self.repostBtn setTitleCount:topic.repost placeholder:@"分享"];
    [self.commentBtn setTitleCount:topic.comment placeholder:@"评论"];
}

@end

@implementation SRToolBarButton

- (void)setTitleCount:(NSInteger)count placeholder:(NSString *)placeholder {
    
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [self setTitle:placeholder forState:UIControlStateNormal];
}

@end
