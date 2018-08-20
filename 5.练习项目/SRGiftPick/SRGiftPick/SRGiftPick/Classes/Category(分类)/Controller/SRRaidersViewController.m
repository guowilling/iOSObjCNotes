//
//  SRRaidersViewController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRRaidersViewController.h"
#import "SRChannel.h"
#import "SRChannelGroup.h"
#import "SRChannelCell.h"
#import "SRChanneHeadeReusableView.h"
#import "SRChannelViewController.h"
#import "SRCollection.h"
#import "SRRaidersHeader.h"

@interface SRRaidersViewController () <SRRaidersHeaderDelegate>

@property (nonatomic, weak  ) SRRaidersHeader *headerView;
@property (nonatomic, strong) NSArray *collections;

@property (nonatomic, strong) NSMutableArray *channelGroups;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation SRRaidersViewController

- (instancetype)init {

    return [super initWithCollectionViewLayout:({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemMargin = 10.0;
        CGFloat lineMargin = 10.0;
        flowLayout.minimumInteritemSpacing = itemMargin;
        flowLayout.minimumLineSpacing = lineMargin;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, itemMargin, 0, itemMargin);
        CGFloat itemW = (SRScreenW - 5 * itemMargin) * 0.25;
        CGFloat itemH = itemW * 1.5;
        flowLayout.itemSize = CGSizeMake(itemW, itemH);
        //flowLayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 50); // 为什么写在这里会报错, why?
        _flowLayout = flowLayout;
    })];
}

#pragma mark - Lazy load

- (AFHTTPSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.session.configuration.timeoutIntervalForRequest = 15.0;
    }
    return _sessionManager;
}

- (NSMutableArray *)channelGroups {
    
    if (!_channelGroups) {
        _channelGroups = [NSMutableArray array];
    }
    return _channelGroups;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupHeaderView];
    
    [self setupCollectionView];
    
    [self getHeaderViewData];
    
    [self getCollectionViewData];
}

#pragma mark - Setup UI

- (void)setupHeaderView {
    
    SRRaidersHeader *headerView = [SRRaidersHeader raiderHeaderView];
    headerView.delegate = self;
    self.headerView = headerView;
    [self.collectionView addSubview:headerView];
    [headerView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.collectionView.top);
        make.left.right.equalTo(self.view);
        make.height.equalTo(150);
    }];
    [headerView setNeedsLayout];
    [headerView layoutIfNeeded];
    
//    headerView.backgroundColor = SRRandomColor;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(headerView.sr_height, 0, 0, 0);
}

- (void)setupCollectionView {
    
    self.flowLayout.headerReferenceSize = CGSizeMake(SRScreenW, 44);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SRChannelCell class]) bundle:nil]
          forCellWithReuseIdentifier:channelCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SRChanneHeadeReusableView class]) bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:channelHeaderID];
//    self.collectionView.backgroundColor = SRRandomColor;
}

#pragma mark - 网络请求

- (void)getHeaderViewData {
    
    if (self.headerView.collections.count > 0) {
        return;
    }
    
    NSString *URLString = @"http://api.liwushuo.com/v1/collections?limit=6&offset=0";
    [self.sessionManager GET:URLString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self.headerView.collections = [SRCollection objectArrayWithKeyValuesArray:responseObject[@"data"][@"collections"]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        SRLog(@"error: %@", error);
    }];
}

- (void)getCollectionViewData {
    
    NSString *URLString = @"http://api.liwushuo.com/v1/channel_groups/all?";
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self.sessionManager GET:URLString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        self.channelGroups = [SRChannelGroup objectArrayWithKeyValuesArray:responseObject[@"data"][@"channel_groups"]];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        SRLog(@"error: %@", error);
    }];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.channelGroups.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    SRChannelGroup *group = self.channelGroups[section];
    return group.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SRChannelCell *cell = [SRChannelCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    SRChannelGroup *group = self.channelGroups[indexPath.section];
    SRChannel *channel = group.channels[indexPath.item];
    cell.channel = channel;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    SRChanneHeadeReusableView *reusableView = [SRChanneHeadeReusableView reuseViewWithCollectionView:collectionView foxIndexPath:indexPath];
    SRChannelGroup *group = self.channelGroups[indexPath.section];
    reusableView.channelGroup = group;
    return reusableView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SRChannelGroup *group = self.channelGroups[indexPath.section];
    SRChannel *channel = group.channels[indexPath.row];
    SRChannelViewController *channelVC = [[SRChannelViewController alloc] init];
    channelVC.title = channel.name;
    channelVC.dataName = @"items";
    channelVC.firstPageURL = [self itemsChannelURLWithNumber:channel.ID];
    [self.navigationController pushViewController:channelVC animated:YES];
}

#pragma mark - RaiderHeaderViewDelegate

- (void)raiderHeader:(SRRaidersHeader *)raiderHeader didClickImageView:(SRRaiderHeaderImageView *)imageView {
    
    SRCollection *collection = imageView.collection;
    SRChannelViewController *channelVC = [[SRChannelViewController alloc] init];
    channelVC.title = collection.title;
    channelVC.dataName = @"posts";
    channelVC.firstPageURL = [self collectionsChannelURLWithNumber:collection.ID];
    [self.navigationController pushViewController:channelVC animated:YES];
}

- (NSString *)itemsChannelURLWithNumber:(NSInteger)number {
    
    NSMutableString *URLStringM = [NSMutableString stringWithString:@"http://api.liwushuo.com/v1/channels/"];
    [URLStringM appendFormat:@"%ld", (long)number];
    [URLStringM appendString:@"/items?limit=20&offset=0"];
    return URLStringM;
}

- (NSString *)collectionsChannelURLWithNumber:(NSInteger)number {
    
    NSMutableString *URLStringM = [NSMutableString stringWithString:@"http://api.liwushuo.com/v1/collections/"];
    [URLStringM appendFormat:@"%ld", (long)number];
    [URLStringM appendString:@"/posts?gender=1&generation=1&limit=20&offset=0"];
    return URLStringM;
}

@end
