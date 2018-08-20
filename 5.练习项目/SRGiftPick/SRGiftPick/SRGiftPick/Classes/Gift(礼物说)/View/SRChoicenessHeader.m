//
//  SRChoicenessHeader.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRChoicenessHeader.h"
#import "SRBanner.h"
#import "SRBannerTarget.h"
#import "SRPromotion.h"
#import "SRVerticalButton.h"
#import "UIButton+WebCache.h"
#import "SRChannelViewController.h"
#import "SRGuideDetailViewController.h"
#import "SRBrandViewController.h"
#import "SRWebViewController.h"
#import "SRPageScrollView.h"

@interface SRChoicenessHeader () <SRPageScrollViewDelegate>

@property (weak, nonatomic) IBOutlet SRPageScrollView *pageScrollView;
@property (weak, nonatomic) IBOutlet UIView *buttonsContainer;

@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSArray *promotions;

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation SRChoicenessHeader

- (AFHTTPSessionManager *)sessionManager {
    
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.session.configuration.timeoutIntervalForRequest = 5;
    }
    return _sessionManager;
}

- (void)dealloc {
    
    [self.sessionManager invalidateSessionCancelingTasks:YES];
}

+ (instancetype)choicenessHeader {
    
    SRChoicenessHeader *headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    headerView.pageScrollView.delegate = headerView;
    [headerView getBannersData];
    [headerView getPromotionsData];
    return headerView;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
//    self.pageScrollView.backgroundColor = SRRandomColor;
//    self.buttonsContainer.backgroundColor = SRRandomColor;
}


#pragma mark - Network request

- (void)getBannersData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"channel"] = @"iOS";
    [self.sessionManager GET:@"http://api.liwushuo.com/v1/banners" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        self.banners = [SRBanner objectArrayWithKeyValuesArray:responseObject[@"data"][@"banners"]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

- (void)getPromotionsData {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"gender"] = @"1";
    params[@"generation"] = @"1";
    [self.sessionManager GET:@"http://api.liwushuo.com/v2/promotions" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        self.promotions = [SRPromotion objectArrayWithKeyValuesArray:responseObject[@"data"][@"promotions"]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"error: %@", error);
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
    }];
}

-  (void)setBanners:(NSArray *)banners {
    
    _banners = banners;
    
    NSArray *imageURLStrings = [self.banners valueForKey:@"image_url"];
    [self.pageScrollView setImageURLStrings:imageURLStrings];
    [self.pageScrollView startAutoPagingWithDuration:5.0];
}

- (void)setPromotions:(NSArray *)promotions {
    
    _promotions = promotions;

    [self.buttonsContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat btnW = SRScreenW / self.promotions.count;
    CGFloat btnH = self.buttonsContainer.sr_height;
    for (int i = 0; i < self.promotions.count; i++) {
        SRPromotion *promotion = self.promotions[i];
        SRVerticalButton *btn = [[SRVerticalButton alloc] init];
        btn.tag = i;
        btn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitle:promotion.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:promotion.color] forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:promotion.icon_url] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(promotionBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsContainer addSubview:btn];
//        btn.backgroundColor = SRRandomColor;
    }
}

- (void)promotionBtnOnClick:(SRVerticalButton *)btn {
    
    UINavigationController *navC = [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers firstObject];
    switch (btn.tag) {
        case 0:
        {
            SRChannelViewController *channelVC = [[SRChannelViewController alloc] init];
            channelVC.firstPageURL = @"http://api.liwushuo.com/v1/collections/22/posts?gender=1&generation=1&limit=20&offset=0";
            channelVC.dataName = @"posts";
            channelVC.title = @"每日十件美好小物";
            [navC pushViewController:channelVC animated:YES];
            break;
        }
            
        case 1:
        {
            SRBrandViewController *brandVC = [[SRBrandViewController alloc] init];
            [navC pushViewController:brandVC animated:YES];
            break;
        }
            
        case 2:
        {
            SRLog(@"每日签到");
            break;
        }
            
        case 3:
        {
            SRLog(@"天天刮奖");
            break;
        }
    }
}

#pragma mark - SRPageScrollViewDelegate

- (void)pageScrollView:(SRPageScrollView *)pageScrollView didClickImageAtIndex:(NSInteger)index {
    
    SRBanner *banner = self.banners[index];
    UINavigationController *navC = [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers firstObject];
    
    if ([banner.type isEqualToString:@"collection"]) {
        NSString *firstPageURL = [NSString stringWithFormat:@"http://api.liwushuo.com/v1/%@s/%@/posts?gender=1&generation=1&limit=20&offset=0", banner.type, banner.target_id];
        SRChannelViewController *channelVC = [[SRChannelViewController alloc] init];
        channelVC.firstPageURL = firstPageURL;
        channelVC.dataName = @"posts";
        channelVC.title = banner.target.title;
        [navC pushViewController:channelVC animated:YES];
    }
    
    if ([banner.type isEqualToString:@"url"]) {
        SRLog(@"%@", banner.target_url);
        if ([banner.target_url rangeOfString:@"liwushuo://"].location != NSNotFound) {
            return;
        }
        SRWebViewController *webVC = [[SRWebViewController alloc] init];
        webVC.URLString = banner.target_url;
        [navC pushViewController:webVC animated:YES];
    }
    if ([banner.type isEqualToString:@"post"]) {
        SRGuideDetailViewController *guideDetailVC = [[SRGuideDetailViewController alloc] init];
        guideDetailVC.ID = [banner.target_id intValue];
        [navC pushViewController:guideDetailVC animated:YES];
    }
}

@end
