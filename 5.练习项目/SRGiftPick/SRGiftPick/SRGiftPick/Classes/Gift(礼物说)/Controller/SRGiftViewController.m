//
//  SRGiftViewController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/4.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRGiftViewController.h"
#import "SRChannelViewController.h"
#import "SRChoicenessViewController.h"
#import "SRSearchViewController.h"
#import "SREditChannelsView.h"

static const int SRChannelBtnMaxVisibleCount = 5;

@interface SRGiftViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *channelScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UIView *editChannelsTitleView;

@property (nonatomic, strong) NSMutableArray *channelBtns;
@property (nonatomic, weak  ) UIButton *currentChannelBtn;
@property (nonatomic, weak  ) UIView *redIndicator;
@property (nonatomic, weak  ) SREditChannelsView *editChannelsView;

@end

@implementation SRGiftViewController

#pragma mark - Lazy Load

- (NSMutableArray *)channelBtns {
    if (!_channelBtns) {
        _channelBtns = [NSMutableArray array];
    }
    return _channelBtns;
}

- (SREditChannelsView *)editChannelsView {
    if (!_editChannelsView) {
        SREditChannelsView *editChannelsView = [[SREditChannelsView alloc] init];
        editChannelsView.sr_x = 0;
        editChannelsView.sr_y = 64 + 35;
        editChannelsView.sr_width = SRScreenW;
        editChannelsView.sr_height = SRScreenH - editChannelsView.sr_y - 49;
        editChannelsView.backgroundColor = [UIColor whiteColor];
        [self.view insertSubview:editChannelsView aboveSubview:self.contentScrollView];
        self.editChannelsView = editChannelsView;
        self.editChannelsView.transform = CGAffineTransformMakeTranslation(0, -editChannelsView.sr_height);
    }
    return _editChannelsView;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNavBar];
    
    [self setupChildViewControllers];
    
    [self setupChannelBtns];
    
    [self setupContentScrollView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.redIndicator.sr_height = 2.5;
    self.redIndicator.sr_y = self.channelScrollView.sr_height - self.redIndicator.sr_height;
    
    CGFloat btnW = self.channelScrollView.sr_width / SRChannelBtnMaxVisibleCount;
    CGFloat btnH = self.channelScrollView.sr_height;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIButton *btn = self.channelBtns[i];
        btn.sr_x = i * btnW;
        btn.sr_width = btnW;
        btn.sr_height = btnH;
        if (i == 0 && self.currentChannelBtn == btn) {
            [btn.titleLabel sizeToFit];
            self.redIndicator.sr_centerX = btn.sr_centerX;
            self.redIndicator.sr_width = btn.titleLabel.sr_width;
        }
    }
    
    self.channelScrollView.contentSize = CGSizeMake(self.channelBtns.count * btnW, 0);
}

#pragma mark - Setup UI

- (void)setupNavBar {
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"camera"]
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(scanQRCodeAction)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"find"]
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(findAction)];
}

- (void)setupChildViewControllers {
    NSString *dataName = @"items";
    
    [self setupChildViewController:[[SRChoicenessViewController alloc] init] withTitle:@"精选"
                      firstPageURL:[self URLStringWithNumber:100]
                          dataName:dataName];
    
    [self setupChildViewController:[[SRChannelViewController alloc] init] withTitle:@"数码" firstPageURL:[self URLStringWithNumber:121] dataName:dataName];
    [self setupChildViewController:[[SRChannelViewController alloc] init] withTitle:@"运动" firstPageURL:[self URLStringWithNumber:123] dataName:dataName];
    [self setupChildViewController:[[SRChannelViewController alloc] init] withTitle:@"娱乐" firstPageURL:[self URLStringWithNumber:120] dataName:dataName];
    [self setupChildViewController:[[SRChannelViewController alloc] init] withTitle:@"美食" firstPageURL:[self URLStringWithNumber:118] dataName:dataName];
    [self setupChildViewController:[[SRChannelViewController alloc] init] withTitle:@"礼物" firstPageURL:[self URLStringWithNumber:111] dataName:dataName];
}

- (void)setupChildViewController:(SRChannelViewController *)vc
                       withTitle:(NSString *)title
                    firstPageURL:(NSString *)firstPageURL
                        dataName:(NSString *)dataName
{
    vc.title = title;
    vc.dataName = dataName;
    vc.firstPageURL = firstPageURL;
    [self addChildViewController:vc];
}

- (NSString *)URLStringWithNumber:(NSInteger)number {
    NSMutableString *URLStringM = [NSMutableString stringWithString:@"https://api.liwushuo.com/v1/channels/"];
    [URLStringM appendFormat:@"%zd", number];
    [URLStringM appendString:@"/items?limit=20&offset=0"];
    return URLStringM;
}

- (void)setupChannelBtns {
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:[self.childViewControllers[i] title] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:SRThemeColor forState:UIControlStateDisabled];
        [btn addTarget:self action:@selector(channelBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.channelScrollView addSubview:btn];
        [self.channelBtns addObject:btn];
        if (i == 0) {
            btn.enabled = NO;
            self.currentChannelBtn = btn;
        }
    }
    UIView *redIndicator = [[UIView alloc] init];
    redIndicator.backgroundColor = SRThemeColor;
    [self.channelScrollView addSubview:redIndicator];
    self.redIndicator = redIndicator;
}

- (void)setupContentScrollView {
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.delegate = self;
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * SRScreenW, 0);
    
    // show first VC
    UIViewController *showingVC = self.childViewControllers[0];
    showingVC.view.frame = CGRectMake(0, 0, self.contentScrollView.sr_width, self.contentScrollView.sr_height);
    [self.contentScrollView addSubview:showingVC.view];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / SRScreenW;
    UIButton *channelBtn = self.channelBtns[index];
    CGFloat channelScrollViewOffsetX = channelBtn.sr_centerX - self.channelScrollView.sr_width * 0.5;
    channelScrollViewOffsetX = MIN(MAX(0, channelScrollViewOffsetX), self.channelScrollView.contentSize.width - self.channelScrollView.sr_width);
    [self.channelScrollView setContentOffset:CGPointMake(channelScrollViewOffsetX, 0) animated:YES];
    
    [self setDisableChannelBtn:channelBtn];
    [self loadChildControllerViewOfIndex:index];
}

#pragma mark - Monitor method

- (void)scanQRCodeAction {
    SRLog(@"二维码扫描");
}

- (void)findAction {
    SRSearchViewController *vc = [[SRSearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)channelBtnOnClick:(UIButton *)btn {
    CGFloat contentScrollViewOffsetX = (btn.sr_x / btn.sr_width) * SRScreenW;
    [self.contentScrollView setContentOffset:CGPointMake(contentScrollViewOffsetX, 0) animated:YES];
}

- (IBAction)editChannelsBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.editChannelsTitleView.hidden = !self.editChannelsTitleView.hidden;
    [self editChannelsView];
    [UIView animateWithDuration:0.4 animations:^{
        sender.imageView.transform = CGAffineTransformRotate(sender.imageView.transform, M_PI);
        if (sender.selected) {
            self.editChannelsView.transform = CGAffineTransformIdentity;
        } else {
            self.editChannelsView.transform = CGAffineTransformMakeTranslation(0, -self.editChannelsView.sr_height);
        }
    } completion:^(BOOL finished) {
        if (!sender.selected) {
            [self.editChannelsView removeFromSuperview];
        }
    }];
}

#pragma mark - Tool Methods

- (void)setDisableChannelBtn:(UIButton *)btn {
    self.currentChannelBtn.enabled = YES;
    self.currentChannelBtn = btn;
    self.currentChannelBtn.enabled = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.redIndicator.sr_centerX = btn.sr_centerX;
        self.redIndicator.sr_width = btn.titleLabel.sr_width;
    }];
}

- (void)loadChildControllerViewOfIndex:(NSUInteger)index {
    UIViewController *showingVC = self.childViewControllers[index];
    if ([showingVC isViewLoaded]) {
        return;
    }
    showingVC.view.frame = CGRectMake(index * SRScreenW, 0, SRScreenW, self.contentScrollView.sr_height);
    [self.contentScrollView addSubview:showingVC.view];
}

@end
