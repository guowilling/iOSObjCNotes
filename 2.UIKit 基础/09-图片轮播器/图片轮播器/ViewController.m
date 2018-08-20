//
//  ViewController.m
//  图片轮播器
//
//  Created by 郭伟林 on 15/9/16.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

#define kImageCount 5

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger index;

@end

@implementation ViewController

- (UIScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 300)];
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(kImageCount * _scrollView.bounds.size.width, 0);
        _scrollView.delegate = self;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (_pageControl ==nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = kImageCount;
        CGSize size = [_pageControl sizeForNumberOfPages:kImageCount];
        _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(self.scrollView.center.x, 300);
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.enabled = NO;
        //[_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_pageControl];
    }
    return _pageControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    for (int i = 0; i < kImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.scrollView.bounds];
        NSString *imageName = [NSString stringWithFormat:@"火影%d", i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        imageView.image = image;
        [self.scrollView addSubview:imageView];
    }
    
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
        CGRect frame = imageView.frame;
        frame.origin.x = idx * frame.size.width;
        imageView.frame = frame;
    }];
    
    self.pageControl.currentPage = self.index;
    [self startTimer];
}

- (void)startTimer {
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)updateTimer {
    NSLog(@"%s", __func__);
    self.index = (self.pageControl.currentPage + 1) % kImageCount;
    CGFloat x = self.index * self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
    self.pageControl.currentPage = self.index;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
    NSLog(@"%f", self.scrollView.contentOffset.x);
    NSInteger page = self.scrollView.contentOffset.x / self.scrollView.bounds.size.width;
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"%s", __func__);
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"%s", __func__);
    [self startTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"%s", __func__);
}

@end
