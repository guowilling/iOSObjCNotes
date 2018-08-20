//
//  GPRaiderHeaderView.m
//  礼物说
//
//  Created by heew on 15/1/23.
//  Copyright (c) 2014年 giftTalk All rights reserved.
//

#import "SRRaidersHeader.h"
#import "SRCollection.h"

@interface SRRaidersHeader ()

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView  *lastImageView;

@end

@implementation SRRaidersHeader

+ (instancetype)raiderHeaderView {
    
    return [[self alloc] init];
}

- (instancetype)init {
    
    if (self = [super init]) {
        UILabel *titleLabel = [[UILabel alloc] init];
        [self addSubview:titleLabel];
//        titleLabel.backgroundColor = SRRandomColor;
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(10);
            make.height.equalTo(20);
        }];
        titleLabel.text = @"专题";
        titleLabel.font = [UIFont systemFontOfSize:14];
        [titleLabel setTintColor:[UIColor blackColor]];
        [titleLabel layoutIfNeeded];
        
        UIButton *checkAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        checkAllButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [checkAllButton setTitle:@"查看全部" forState:UIControlStateNormal];
        [checkAllButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self addSubview:checkAllButton];
//        checkAllButton.backgroundColor = SRRandomColor;
        [checkAllButton makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(titleLabel);
            make.right.equalTo(self.right).offset(-10);
        }];
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        [scrollView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(checkAllButton.bottom).offset(10);
            make.left.right.bottom.equalTo(self);
        }];
        self.scrollView = scrollView;
//        scrollView.backgroundColor = SRRandomColor;
    }
    return self;
}

- (void)setCollections:(NSArray *)collections {
    
    _collections = collections;
   
    for (int i = 0; i < collections.count; i++) {
        SRCollection *collection = collections[i];
        SRRaiderHeaderImageView *imageView = [[SRRaiderHeaderImageView alloc] init];
        imageView.collection = collection;
        imageView.layer.cornerRadius = 10;
        imageView.layer.masksToBounds = YES;
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:collection.banner_image_url] placeholderImage:[UIImage imageNamed:@"searchGift_placeHolder"]];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidClick:)];
        [imageView addGestureRecognizer:tapGestureRecognizer];
        [self.scrollView addSubview:imageView];
//        imageView.backgroundColor = SRRandomColor;
        
        if (i == 0) {
            [imageView makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(self.scrollView).offset(10);
                make.bottom.equalTo(self.scrollView).offset(-10);
                make.width.equalTo(imageView.height).multipliedBy(2);
                make.height.equalTo(self.scrollView.height).offset(-20);
            }];
            self.lastImageView = imageView;
        } else if (i > 0 && i < collections.count - 1) {
            [imageView makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.lastImageView.right).offset(10);
                make.bottom.equalTo(self.scrollView).offset(-10);
                make.top.equalTo(self.scrollView).offset(10);
                make.width.equalTo(imageView.height).multipliedBy(2);
                make.height.equalTo(self.scrollView.height).offset(-20);
            }];
            self.lastImageView = imageView;
        } else {
            [imageView makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.lastImageView.right).offset(10);
                make.bottom.equalTo(self.scrollView).offset(-10);
                make.top.equalTo(self.scrollView).offset(10);
                make.width.equalTo(imageView.height).multipliedBy(2);
                make.height.equalTo(self.scrollView.height).offset(-20);
                make.right.equalTo(self.scrollView).offset(-10);
            }];
        }
    }
}

- (void)imageViewDidClick:(UITapGestureRecognizer *)tapGestureRecognizer {
    
    SRRaiderHeaderImageView *imageView = (SRRaiderHeaderImageView *)tapGestureRecognizer.view;
    if ([self.delegate respondsToSelector:@selector(raiderHeader:didClickImageView:)]) {
        [self.delegate raiderHeader:self didClickImageView:imageView];
    }
}

@end

@implementation SRRaiderHeaderImageView : UIImageView

@end
