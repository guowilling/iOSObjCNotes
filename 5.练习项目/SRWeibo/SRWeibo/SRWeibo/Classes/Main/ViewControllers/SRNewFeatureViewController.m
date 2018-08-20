//
//  SRNewFeatureViewController.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/27.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRNewFeatureViewController.h"
#import "SRTabBarController.h"

@interface SRNewFeatureViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView  *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation SRNewFeatureViewController

- (void)dealloc {
    SRLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:({
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.frame = self.view.bounds;
        scrollView.contentSize = CGSizeMake(scrollView.width * 4, 0); // Notice: scrollView 的 contentSize 高度赋值 0 垂直方向不能滚动
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self.view addSubview:scrollView];
        _scrollView = scrollView;
    })];
    
    CGFloat imageViewW = self.scrollView.width;
    CGFloat imageViewH = self.scrollView.height;
    for (int i=0; i < 4; i++) {
        [_scrollView addSubview:({
            UIImageView *imageView = [[UIImageView alloc] init];
            NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i + 1];
            imageView.image = [UIImage imageNamed:imageName];
            imageView.x = imageViewW * i;
            imageView.y = 0;
            imageView.width = imageViewW;
            imageView.height = imageViewH;
            if (i == 3) {
                [self setupLastImageView:imageView];
            }
            imageView;
        })];
    }

    [self.view addSubview:({
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = 4;
        pageControl.centerX = self.scrollView.width * 0.5; // Notice: UIPageControl 不设置尺寸依然能显示但不能交互
        pageControl.centerY = self.scrollView.height - 50;
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        pageControl.pageIndicatorTintColor = [UIColor blackColor];
        _pageControl = pageControl;
    })];
}

- (void)setupLastImageView:(UIImageView *)imageView {
    imageView.userInteractionEnabled = YES;
    
    [imageView addSubview:({
        UIButton *shareBtn = [[UIButton alloc] init];
        shareBtn.width = 100; // Notice: 设置中心点前一定要先设置宽高
        shareBtn.height = 50;
        shareBtn.centerX = imageView.width * 0.5;
        shareBtn.centerY = imageView.height * 0.6;
        shareBtn.backgroundColor = [UIColor redColor];
        shareBtn.imageView.backgroundColor = [UIColor blueColor];
        shareBtn.titleLabel.backgroundColor = [UIColor yellowColor];
        shareBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
        shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        
        shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        shareBtn;
    })];
    
    [imageView addSubview:({
        UIButton *startBtn = [[UIButton alloc] init];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        startBtn.size = startBtn.currentBackgroundImage.size;
        startBtn.centerX = imageView.width * 0.5;
        startBtn.centerY = imageView.height * 0.7;
        [startBtn addTarget:self action:@selector(startBtn) forControlEvents:UIControlEventTouchUpInside];
        startBtn;
    })];
}

- (void)shareBtnClick:(UIButton *)shareBtn {
    shareBtn.selected = !shareBtn.selected;
}

- (void)startBtn {
    // 切换控制器的方式:
    // 1.push, 依赖于 UINavigationController, 可逆, 旧控制器不会销毁.
    // 2.modal, 不依赖 UINavigationController, 可逆, 旧控制器不会销毁.
    // 3.切换 window 的根控制器, 旧控制器会销毁.
    SRKeyWindow.rootViewController = [[SRTabBarController alloc] init];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 1.2 四舍五入 1.2 + 0.5 = 1.7 强转为整数 (int)1.7 = 1
    // 1.6 四舍五入 1.6 + 0.5 = 2.1 强转为整数 (int)2.1 = 2
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / scrollView.width;
}

@end
