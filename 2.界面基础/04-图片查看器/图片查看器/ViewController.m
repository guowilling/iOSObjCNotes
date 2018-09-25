//
//  ViewController.m
//  图片查看器
//
//  Created by 郭伟林 on 15/9/15.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

/**
 * strong & weak
 * 1.通过stroyboard或xib拖线控件为weak
 * 2.通过代码创建控件strong或weak都可以
 */

@interface ViewController ()

@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) NSArray *imageInfos;
@property (nonatomic, assign) NSInteger index;

@end

@implementation ViewController

- (NSArray *)imageInfos {
    if (_imageInfos == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"imageInfos" ofType:@"plist"];
        NSLog(@"filePath: %@", filePath);
        _imageInfos = [NSArray arrayWithContentsOfFile:filePath];
    }
    return _imageInfos;
}

- (UILabel *)numLabel {
    if (_numLabel == nil) {
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 40)];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_numLabel];
    }
    return _numLabel;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        CGFloat w = 200;
        CGFloat h = 200;
        CGFloat x = (self.view.bounds.size.width - w) * 0.5;
        CGFloat y =CGRectGetMaxY(self.numLabel.frame) + 20;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)descLabel {
    if (_descLabel == nil) {
        CGFloat y = CGRectGetMaxY(self.imageView.frame);
        CGFloat w = self.view.bounds.size.width;
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, w, 40)];
        _descLabel.textColor = [UIColor blackColor];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.numberOfLines = 0;
        [self.view addSubview:_descLabel];
    }
    return _descLabel;
}

- (UIButton *)leftButton {
    if (_leftButton == nil) {
        CGFloat centerX = self.imageView.frame.origin.x * 0.5;
        CGFloat centerY = self.imageView.center.y;
        _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _leftButton.center =CGPointMake(centerX, centerY);
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"left_normal"] forState:UIControlStateNormal];
        [_leftButton setBackgroundImage:[UIImage imageNamed:@"left_highlighted"] forState:UIControlStateHighlighted];
        [_leftButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.tag = -1;
        [self.view addSubview:_leftButton];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (_rightButton == nil) {
        CGFloat centerX = self.view.bounds.size.width - self.imageView.frame.origin.x * 0.5;
        CGFloat centerY = self.imageView.center.y;
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _rightButton.center =CGPointMake(centerX, centerY);
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"right_normal"] forState:UIControlStateNormal];
        [_rightButton setBackgroundImage:[UIImage imageNamed:@"right_highlighted"] forState:UIControlStateHighlighted];
        [_rightButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.tag = 1;
        [self.view addSubview:_rightButton];
    }
    return _rightButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showImageView];
}

-(void)showImageView {
    self.numLabel.text = [NSString stringWithFormat:@"%zd/5", self.index + 1];
    self.imageView.image = [UIImage imageNamed:self.imageInfos[self.index][@"name"]];
    self.descLabel.text = self.imageInfos[self.index][@"desc"];
    self.leftButton.enabled = (self.index != 0);
    self.rightButton.enabled = (self.index != 4);
}

// iOS中很多监听方法的第一个参数就是触发该监听方法的对象本身
- (void)clickBtn:(UIButton *)button {
    self.index += button.tag;
    [self showImageView];
}

@end
