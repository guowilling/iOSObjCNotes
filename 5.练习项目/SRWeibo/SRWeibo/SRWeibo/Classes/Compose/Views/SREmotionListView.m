//
//  SREmotionListView.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/29.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SREmotionListView.h"
#import "SREmotionPageView.h"

@interface SREmotionListView () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView  *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation SREmotionListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        UIScrollView *scrollView = [[UIScrollView alloc] init];
//        scrollView.backgroundColor = SRRandomColor;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
//        pageControl.backgroundColor = SRRandomColor;
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"]; // 通过KVC 设置U IPageControl 圆点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)]; // Notice: 最近表情需要删除旧的pageView.
    
    NSInteger pageCount = (emotions.count - 1 + SREmotionMaxCount) / SREmotionMaxCount;
    for (int i = 0; i < pageCount; i++) {
        SREmotionPageView *pageView = [[SREmotionPageView alloc] init];
        NSRange range;
        range.location = i * SREmotionMaxCount;
        NSInteger left = emotions.count - range.location;
        if (left >= SREmotionMaxCount) {
            range.length = SREmotionMaxCount;
        } else {
            range.length = left;
        }
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
    self.pageControl.numberOfPages = pageCount;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    self.scrollView.width = self.width;
    self.scrollView.height = self.height - 25;
    NSInteger count = self.scrollView.subviews.count;
    self.scrollView.contentSize = CGSizeMake(self.width * count, 0);
    for (int i = 0; i < count; i++) {
        SREmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.x = i * self.scrollView.width;
        pageView.y = 0;
        pageView.width = self.scrollView.width;
        pageView.height = self.scrollView.height;
    }
    
    self.pageControl.x = 0;
    self.pageControl.y = self.scrollView.height;
    self.pageControl.width = self.width;
    self.pageControl.height = 25;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

@end
