//
//  HeaderView.m
//  QQ好友列表
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *label;

@end

@implementation HeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView {
    static NSString *ID = @"headerView";
    HeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (headerView == nil) {
        headerView = [[HeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headerView;
}

#pragma mark - init方法中所有控件的frame都是0
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithReuseIdentifier:reuseIdentifier]) {
        // 添加按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        btn.imageView.contentMode = UIViewContentModeCenter;
        btn.imageView.clipsToBounds = NO;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        self.btn = btn;
        
        // 添加标签
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
        self.label = label;
    }
    return self;
}

- (void)btnClick:(UIButton *)btn {
    self.groupModel.open = !self.groupModel.isOpen;
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickHeaderView:)]) {
        [self.delegate headerViewDidClickHeaderView:self];
    }
    // 这里旋转无效因为tableView会重新加载
    //self.btn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    NSLog(@"%s", __func__);
}

- (void)didMoveToSuperview {
    NSLog(@"%s", __func__);
    //展开或者关闭分组时按钮上的imageView的状态不应该在点击按钮的时候处理
    //因为在点击按钮刷新表格的时候headerview是重新实例化的
    //应该调用didMoveToSuperView方法控件添加到父控件时处理
    if (self.groupModel.isOpen) {
        self.btn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
}

#pragma mark - 控件frame改变的时候调用一般用于设置内部子控件frame
#pragma mark - 重写layoutSubviews一定要调用[super layoutSubviews]
- (void)layoutSubviews {
    [super layoutSubviews];
    self.btn.frame = self.bounds;
    CGFloat margin = 20;
    CGFloat labelW = 100;
    CGFloat labelH = self.bounds.size.height;
    CGFloat labelY = 0;
    CGFloat labelX = self.bounds.size.width - margin - labelW;
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

- (void)setGroupModel:(GroupModel *)groupModel {
    _groupModel = groupModel;
    [self.btn setTitle:groupModel.name forState:UIControlStateNormal];
    self.label.text = [NSString stringWithFormat:@"%zd/%zd", groupModel.online, groupModel.friends.count];
}

@end
