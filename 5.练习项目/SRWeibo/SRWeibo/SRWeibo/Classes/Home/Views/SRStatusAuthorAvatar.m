//
//  SRIconImageView.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/28.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRStatusAuthorAvatar.h"
#import "UIImageView+WebCache.h"
#import "SRUser.h"

@interface SRStatusAuthorAvatar ()

@property (nonatomic, weak) UIImageView *verifiedImageView;

@end

@implementation SRStatusAuthorAvatar

- (UIImageView *)verifiedImageView {
    if (!_verifiedImageView) {
        UIImageView * verifiedImageView = [[UIImageView alloc] init];
        [self addSubview:verifiedImageView];
        _verifiedImageView = verifiedImageView;
    }
    return _verifiedImageView;
}

- (void)setUser:(SRUser *)user {
    _user = user;
    
    // 头像
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
 
    // 认证图片
    switch (user.verified_type) {
        case SRUserVerifiedTypePersonal:    // 个人认证
            self.verifiedImageView.hidden = NO;
            self.verifiedImageView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case SRUserVerifiedTypeEnterprise:  // 官方认证
        case SRUserVerifiedTypeMedia:
        case SRUserVerifiedTypeWebsite:
            self.verifiedImageView.hidden = NO;
            self.verifiedImageView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case SRUserVerifiedTypeDaren:       // 微博达人
            self.verifiedImageView.hidden = NO;
            self.verifiedImageView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        default:                            // 没有任何认证
            self.verifiedImageView.hidden = YES;
            break;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.verifiedImageView.hidden == NO) {
        self.verifiedImageView.size = self.verifiedImageView.image.size;
        self.verifiedImageView.x = self.width - self.verifiedImageView.width * 0.5;
        self.verifiedImageView.y = self.height - self.verifiedImageView.height * 0.5;
    }
}

@end
