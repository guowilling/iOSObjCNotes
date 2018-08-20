//
//  SRPageScrollView.m
//  SR礼物说
//
//  Created by 郭伟林 on 15/10/2.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRPageScrollView.h"

#define kPageControlHeight    50
#define kPageControlEachWidth 50
#define kDefaultDuration      2.0

@interface SRPageScrollView () <UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView  *scrollView;
@property (weak, nonatomic) UIPageControl *pageControl;

@property (weak, nonatomic) UIImageView *leftImageView;
@property (weak, nonatomic) UIImageView *currentImageView;
@property (weak, nonatomic) UIImageView *rightImageView;

@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic, getter=isAutoPaging) BOOL autoPaging;

@end

@implementation SRPageScrollView

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
        [self createImageView];
    }
    return  self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setup];
    [self createImageView];
}

- (void)setup {
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = YES;
    scrollView.scrollEnabled = NO;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    [self addSubview:scrollView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.hidesForSinglePage = YES;
    self.pageControl = pageControl;
    [self addSubview:pageControl];
    
    self.autoPaging = NO;
    self.pagingInterval = kDefaultDuration;
    self.pageControlPostion = PageControlPositionBottomCenter;
}

- (void)createImageView {
    
    UIImageView *leftImageView = [[UIImageView alloc] init];
    UIImageView *currentImageView = [[UIImageView alloc] init];
    UIImageView *rightImageView = [[UIImageView alloc] init];
    
    [self.scrollView addSubview:leftImageView];
    [self.scrollView addSubview:currentImageView];
    [self.scrollView addSubview:rightImageView];
    
    self.leftImageView = leftImageView;
    self.currentImageView = currentImageView;
    self.rightImageView = rightImageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    self.currentImageView.userInteractionEnabled = YES;
    [self.currentImageView addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)tapGesture {
    
    if ([self.delegate respondsToSelector:@selector(pageScrollView:didClickImageAtIndex:)]) {
        [self.delegate pageScrollView:self didClickImageAtIndex:self.currentImageView.tag];
    }
}

- (void)setImages:(NSArray *)images {
    
    if (!images || images.count == 0) {
        return;
    }
    
    _images = images;
    
    // 设置默认图片
    self.currentImageView.image = images[0];
    self.currentImageView.tag = 0;
    
    if (images.count > 1) {
        // 设置左右图片
        self.leftImageView.image = images[images.count - 1];
        self.rightImageView.image = images[1];
        self.leftImageView.tag = images.count - 1;
        self.rightImageView.tag = 1;
    }
    
    self.pageControl.numberOfPages = images.count;
    [self setPageControlPostion];
    
    // 显示中间的图片
    CGFloat imageViewW = self.scrollView.bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(imageViewW, 0)];

    self.scrollView.scrollEnabled = (self.images.count > 1);
    if (self.isAutoPaging) {
        [self startAutoPaging];
    }
}

- (void)setImageURLStrings:(NSArray *)imageURLStrings {
    
    _imageURLStrings = imageURLStrings;
    
    NSMutableArray *imagesTemp = [NSMutableArray arrayWithCapacity:imageURLStrings.count];
    
    // 下载显示第一张图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[imageURLStrings firstObject]]]];
        if (image) {
            [imagesTemp addObject:image];
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.currentImageView.image = image;
            
            // 显示中间的图片
            CGFloat imageViewW = self.scrollView.bounds.size.width;
            [self.scrollView setContentOffset:CGPointMake(imageViewW, 0)];
            
            self.pageControl.numberOfPages = imageURLStrings.count;
            [self setPageControlPostion];
        });
        
        // 下载剩余图片
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (NSInteger i = 1; i < imageURLStrings.count; i++) {
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLStrings[i]]]];
                if (image) {
                    [imagesTemp addObject:image];
                }
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.images = imagesTemp;
            });
        });
    });
}

#pragma mark - 布局

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    
    CGFloat imageViewW = self.scrollView.bounds.size.width;
    CGFloat imageViewH = self.scrollView.bounds.size.height;
    
    self.leftImageView.frame = CGRectMake(0, 0, imageViewW, imageViewH);
    self.currentImageView.frame = CGRectMake(imageViewW, 0, imageViewW, imageViewH);
    self.rightImageView.frame = CGRectMake(imageViewW * 2, 0, imageViewW, imageViewH);
    
    self.scrollView.contentSize = CGSizeMake(imageViewW * 3, 0);
    
    [self setPageControlPostion];
    
    [self updateContent];
}

- (void)setPageControlPostion {
    
    CGFloat pageControlCenterX = 0;
    CGFloat pageControlCenterY = 0;
    if (PageControlPositionBottomCenter == self.pageControlPostion) {
        pageControlCenterX = self.bounds.size.width / 2.0;
    } else if (PageControlPositionBottomRight == self.pageControlPostion) {
        pageControlCenterX = self.bounds.size.width - MAX(self.images.count, self.imageURLStrings.count) * kPageControlEachWidth / 2.0;
    }
    pageControlCenterY = self.bounds.size.height - kPageControlHeight / 4.0;
    self.pageControl.center = CGPointMake(pageControlCenterX, pageControlCenterY);
}

#pragma mark - 轮播

- (void)startAutoPagingWithDuration:(NSTimeInterval)pagingInterval {
    
    [self stopTimer];

    self.autoPaging = YES;
    
    self.pagingInterval = pagingInterval;
    
    [self startTimer];
}

- (void)startAutoPaging {
    
    [self stopTimer];
    
    self.autoPaging = YES;
    
    [self startTimer];
}

- (void)stopAutoPaging {
    
    self.autoPaging = NO;
    
    [self stopTimer];
}

- (void)startTimer {
    
    if (self.images.count <= 1) {
        return;
    }
    if (self.timer) {
        return;
    }
    self.timer = [NSTimer timerWithTimeInterval:self.pagingInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)nextPage {
    
    if (self.scrollView.contentOffset.x != 0) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width * 2, 0) animated:YES];
    }
}


- (void)updateContent {
    
    // 更新显图片的内容和索引
    
    CGFloat scrollViewW = self.scrollView.bounds.size.width;
    
    if (self.images.count <= 1) {
        return;
    }
    
    if (self.scrollView.contentOffset.x > scrollViewW) { // 向前滚动
        // 先设置左边的 tag 为当前图片 tag, 再改变当前图片 tag.
        self.leftImageView.tag = self.currentImageView.tag;
        self.currentImageView.tag = self.rightImageView.tag;
        self.rightImageView.tag = (self.rightImageView.tag + 1) % self.images.count;
    } else if (self.scrollView.contentOffset.x < scrollViewW) { // 向后滚动
        // 先设置右边的 tag 为当前图片 tag, 再改变当前图片 tag.
        self.rightImageView.tag = self.currentImageView.tag;
        self.currentImageView.tag = self.leftImageView.tag;
        self.leftImageView.tag = (self.leftImageView.tag - 1 + self.images.count) % self.images.count;
    }
    
    self.leftImageView.image = self.images[self.leftImageView.tag];
    self.currentImageView.image = self.images[self.currentImageView.tag];
    self.rightImageView.image = self.images[self.rightImageView.tag];
    
    // 移动至中间的 UIImageView currentImageView.
    [self.scrollView setContentOffset:CGPointMake(scrollViewW, 0) animated:NO];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.images.count <= 1) {
        return;
    }
    
    if (self.scrollView.contentOffset.x > self.scrollView.bounds.size.width * 1.5) {
        self.pageControl.currentPage = self.rightImageView.tag;
    } else if (self.scrollView.contentOffset.x < self.scrollView.bounds.size.width * 0.5) {
        self.pageControl.currentPage = self.leftImageView.tag;
    } else {
        self.pageControl.currentPage = self.currentImageView.tag;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView { // 手动拖拽
    
    [self updateContent];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView { // 定时器方式
    
    [self updateContent];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (self.isAutoPaging) {
        [self stopTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    if (self.isAutoPaging) {
        [self startTimer];
    }
}

#pragma mark - Public Methods

- (void)setCurrentPageColor:(UIColor *)currentPageColor {
    
    _currentPageColor = currentPageColor;
    
    self.pageControl.currentPageIndicatorTintColor = currentPageColor;
}

- (void)setOtherPageColor:(UIColor *)otherPageColor {
    
    _otherPageColor = otherPageColor;
    
    self.pageControl.pageIndicatorTintColor = otherPageColor;
}

- (void)setPageControlPostion:(PageControlPosition)pageControlPostion {
    
    _pageControlPostion = pageControlPostion;
    
    [self layoutSubviews];
}

- (void)setPagingInterval:(NSTimeInterval)pagingInterval {
    
    _pagingInterval = pagingInterval > 0 ? pagingInterval : kDefaultDuration;
    
    if (self.isAutoPaging) {
        [self startAutoPaging];
    }
}

@end
