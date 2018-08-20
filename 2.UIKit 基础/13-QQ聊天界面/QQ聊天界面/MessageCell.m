//
//  MessageCell.m
//  QQ聊天界面
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "MessageCell.h"
#import "UIImage+Extension.h"
#import "MessageModel.h"
#import "MessageFrameModel.h"

@interface MessageCell ()

@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UIButton *contentBtn;
@property (nonatomic, weak) UIImageView *iconView;

@end

@implementation MessageCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView {
    static NSString *ID = @"cell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) { // 创建子控件
        // 时间
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        self.timeLabel = label;
        
        // 内容
        UIButton * btn = [[UIButton alloc] init];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:btn];
        self.contentBtn = btn;
        
        // 头像
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        self.iconView = imageView;
    }
    return self;
}

- (void)setMessageFrame:(MessageFrameModel *)messageFrame {
    _messageFrame = messageFrame;

    MessageModel *message = _messageFrame.message;
    
    self.timeLabel.frame = _messageFrame.timeF;
    self.timeLabel.text = message.time;
    
    self.iconView.frame = _messageFrame.iconF;
    if (kMessageModelTypeMe == message.type) {
        self.iconView.image = [UIImage imageNamed:@"me"];
    } else {
        self.iconView.image = [UIImage imageNamed:@"other"];
    }
    
    self.contentBtn.frame = _messageFrame.textF;
    [self.contentBtn setTitle:message.text forState:UIControlStateNormal];
    UIImage *newImage;
    if (kMessageModelTypeMe == message.type) {
        newImage = [UIImage resizableImageWithName:@"chat_send_press_pic"];
    } else {
        newImage = [UIImage resizableImageWithName:@"chat_recive_press_pic"];
    }
    [self.contentBtn setBackgroundImage:newImage forState:UIControlStateNormal];
}

/**
 ios5
 指定图片的上边, 下边, 左边, 右边 多少距离是不可以拉伸的
 默认的拉伸模式是平铺
 CGFloat w = norImage.size.width;
 CGFloat h = norImage.size.height;
 UIImage *newImage = [norImage resizableImageWithCapInsets:UIEdgeInsetsMake(h * 0.5 - 1 , w * 0.5 - 1, h * 0.5 , w * 0.5)];
 
 ios6
 多了一个指定拉伸模式的参数: 平铺/拉伸
 CGFloat w = norImage.size.width * 0.5;
 CGFloat h = norImage.size.height * 0.5;
 UIImage *newImage = [norImage resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
 [self.contentBtn setBackgroundImage:newImage forState:UIControlStateNormal];
 */

@end
