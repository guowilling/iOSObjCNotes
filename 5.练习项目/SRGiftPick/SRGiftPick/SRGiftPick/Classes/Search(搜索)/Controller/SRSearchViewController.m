//
//  SRSerachViewController.m
//  SR礼物说
//
//  Created by 郭伟林 on 15/10/3.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRSearchViewController.h"
#import "SRSegmentControl.h"
#import "SRChannelViewController.h"
#import "SRItemViewController.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "SRHotWordsFooter.h"
#import "SRHotWordsHeader.h"
#import "SRHotWordsCell.h"
#import "SRUserDefaults.h"

static NSString * const reuseItemIdentifier   = @"hotWordItem";
static NSString * const reuseHeaderIdentifier = @"hotWordHeader";
static NSString * const reuseFooterIdentifier = @"hotWordFooter";

static const CGFloat SRHotWordsCellHorizontalMargin = 15;
static const CGFloat SRHotWordsCellVerticalMargin   = 7;
static const CGFloat SRHotWordsReuseHeaderH         = 30;
static const CGFloat SRHotWordsReuseFootertH        = 40;
static const CGFloat SRHotWordsCollectionMargin     = 10;
static const CGFloat SRsegementControlH             = 44;

@interface SRSearchViewController () <UISearchBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) UICollectionView *hotWordsCollectionView;
@property (weak, nonatomic) UIView *resultContainer;
@property (weak, nonatomic) UIView *giftResultView;
@property (weak, nonatomic) UIView *guideResultView;

@property (weak, nonatomic) UISearchBar *searchBar;
@property (weak, nonatomic) SRSegmentControl *segementControl;

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) NSArray *hotWords;
@property (strong, nonatomic) NSMutableArray *searchHistory;
@property (strong, nonatomic) NSMutableArray *collectionViewData;

@end

@implementation SRSearchViewController

#pragma mark - Lazy load

- (AFHTTPSessionManager *)sessionManager {
    
    if (_sessionManager == nil) {
        _sessionManager = [AFHTTPSessionManager manager];
    }
    return _sessionManager;
}

- (NSMutableArray *)searchHistory {
    
    if (_searchHistory == nil) {
        _searchHistory = @[].mutableCopy;
    }
    return _searchHistory;
}

- (NSMutableArray *)collectionViewData {
    
    if (_collectionViewData == nil) {
        _collectionViewData = [NSMutableArray array];
        if (self.searchHistory.count > 0) {
            [_collectionViewData addObject:self.searchHistory];
        }
    }
    return _collectionViewData;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = SRBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNavBar];
    
    [self setupHotWordsCollectionView];
    
    [self setupResultContainerView];
    
    [self getHotWordsData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.searchHistory addObjectsFromArray:[SRUserDefaults objectForKey:SRSaveKeySearchHistory]];
    
    [self.searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.searchBar endEditing:YES];
}

- (void)setupNavBar {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(cancelSearch)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:nil
                                                                            action:nil]; // 隐藏返回按钮
    self.navigationItem.leftBarButtonItem = nil; // 显示返回按钮
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SRScreenW, 44)];
    searchBar.delegate = self;
    [searchBar setTintColor:SRThemeColor];
    self.navigationItem.titleView = searchBar;
    self.searchBar = searchBar;
    
    for (UIView *subview in searchBar.subviews) { // 移除 searchBar 背景视图
        if ([subview isKindOfClass:[UIView class]] && subview.subviews.count > 0) {
            [[subview.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
}

- (void)setupHotWordsCollectionView {
    
    UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    layout.minimumInteritemSpacing = SRHotWordsCollectionMargin;
    layout.minimumLineSpacing = SRHotWordsCollectionMargin;
    layout.headerReferenceSize = CGSizeMake(SRScreenW, SRHotWordsReuseHeaderH);
    UICollectionView *hotWordsCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SRScreenW, SRScreenH) collectionViewLayout:layout];
    hotWordsCollectionView.delegate = self;
    hotWordsCollectionView.dataSource = self;
    hotWordsCollectionView.backgroundColor = SRRGBColor(249, 249, 249);
    hotWordsCollectionView.contentInset = UIEdgeInsetsMake(0, SRHotWordsCollectionMargin, SRHotWordsReuseFootertH, SRHotWordsCollectionMargin);
    [self.view addSubview:hotWordsCollectionView];
    self.hotWordsCollectionView = hotWordsCollectionView;
    
    [self.hotWordsCollectionView registerClass:[SRHotWordsCell class] forCellWithReuseIdentifier:reuseItemIdentifier];
    [self.hotWordsCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SRHotWordsHeader class]) bundle:nil]
                  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                         withReuseIdentifier:reuseHeaderIdentifier];
    [self.hotWordsCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SRHotWordsFooter class]) bundle:nil]
                  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                         withReuseIdentifier:reuseFooterIdentifier];
    
//    self.hotWordsCollectionView.backgroundColor = SRRandomColor;
}

- (void)setupResultContainerView {
    
    UIView *resultContainerView = [[UIView alloc] init];
    resultContainerView.frame = CGRectMake(0, 64, SRScreenW, SRScreenH);
    [self.view addSubview:resultContainerView];
    resultContainerView.backgroundColor = [UIColor whiteColor];
    self.resultContainer = resultContainerView;
    self.resultContainer.hidden = YES;
    
    SRSegmentControl *segementControl = [SRSegmentControl segmentControl];
    segementControl.frame = CGRectMake(0, 0, SRScreenW, SRsegementControlH);
    segementControl.ltTitle = @"攻略";
    segementControl.rtTitle = @"礼物";
    [segementControl ltSegementAddTarget:self selector:@selector(guideButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [segementControl rtSegementAddTarget:self selector:@selector(giftButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.resultContainer addSubview:segementControl];
    _segementControl = segementControl;
    
//    self.resultContainer.backgroundColor = SRRandomColor;
}

- (void)getHotWordsData {
    
    [self.sessionManager GET:@"http://api.liwushuo.com/v1/search/hot_words?" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self.hotWords = responseObject[@"data"][@"hot_words"];
        self.searchBar.placeholder = @"大兄弟, 我是占位字符!";
        [self.collectionViewData insertObject:self.hotWords atIndex:0];
        [self.hotWordsCollectionView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        SRLog(@"error: %@", error);
    }];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self searchWithHotWord:searchBar.text];
}

- (void)searchWithHotWord:(NSString *)hotWord {
    
    if (![self.searchHistory containsObject:hotWord]) {
        [self.searchHistory addObject:hotWord];
        [SRUserDefaults setObject:self.searchHistory forKey:SRSaveKeySearchHistory];
    }
    
    [self setupGuideResultViewWithHotWord:hotWord];
    [self setupGiftResultViewWithHotWord:hotWord];
    
    self.hotWordsCollectionView.hidden = YES;
    self.resultContainer.hidden = NO;
    self.giftResultView.hidden = YES;
    self.guideResultView.hidden = NO;
    [self.searchBar endEditing:YES];
}

- (void)setupGuideResultViewWithHotWord:(NSString *)keyWord {
    
    SRChannelViewController *channelVC = [[SRChannelViewController alloc] init];
    channelVC.dataName = @"posts";
    channelVC.firstPageURL = [NSString stringWithFormat:@"http://api.liwushuo.com/v1/search/post?keyword=%@&limit=20&offset=0&sort=", [keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    channelVC.view.frame = CGRectMake(0, SRsegementControlH, self.resultContainer.sr_width, self.resultContainer.sr_height);
    [self addChildViewController:channelVC];
    [self.resultContainer addSubview:channelVC.view];
    self.guideResultView = channelVC.view;
}

- (void)setupGiftResultViewWithHotWord:(NSString *)keyWord {
    
    SRItemViewController *itemVC = [[SRItemViewController alloc] init];
    itemVC.firstPageURL = [NSString stringWithFormat:@"http://api.liwushuo.com/v1/search/item?keyword=%@&limit=20&offset=0&sort=", [keyWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    itemVC.view.frame = CGRectMake(0, SRsegementControlH, self.resultContainer.sr_width, self.resultContainer.sr_height - SRsegementControlH);
    [self addChildViewController:itemVC];
    [self.resultContainer addSubview:itemVC.view];
    self.giftResultView = itemVC.view;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.collectionViewData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.collectionViewData[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SRHotWordsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseItemIdentifier forIndexPath:indexPath];
    cell.title = self.collectionViewData[indexPath.section][indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderIdentifier forIndexPath:indexPath];
        ((SRHotWordsHeader *)reusableView).title = indexPath.section == 0 ? @"大家都在搜" : @"搜索历史";
    } else {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:reuseFooterIdentifier forIndexPath:indexPath];
        [((SRHotWordsFooter *)reusableView) addTarget:self action:@selector(clearSearchHistory) forControlEvents:UIControlEventTouchUpInside];
    }
    return reusableView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *hotWord = self.collectionViewData[indexPath.section][indexPath.row];
    [self searchWithHotWord:hotWord];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = indexPath.section == 0 ? self.hotWords[indexPath.item] : self.searchHistory[indexPath.item];
    CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : SRHotWordsFont} context:nil];
    CGFloat itemW = rect.size.width + SRHotWordsCellHorizontalMargin * 2;
    CGFloat itemH = rect.size.height + SRHotWordsCellVerticalMargin * 2;
    return CGSizeMake(itemW, itemH);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section; {
    
    if (section == self.collectionViewData.count - 1 && self.collectionViewData.lastObject == self.searchHistory) {
        return CGSizeMake(SRScreenW, SRHotWordsReuseFootertH);
    }
    return CGSizeZero;
}

#pragma mark - Monitor method

- (void)guideButtonOnClick {
    
    self.guideResultView.hidden = NO;
    self.giftResultView.hidden = YES;
}

- (void)giftButtonOnClick {
    
    self.guideResultView.hidden = YES;
    self.giftResultView.hidden = NO;
}

- (void)cancelSearch {
    
    self.resultContainer.hidden = YES;
    self.hotWordsCollectionView.hidden = NO;
    [self.searchBar resignFirstResponder];
}

- (void)clearSearchHistory {
    
    [self.collectionViewData removeObject:self.searchHistory];
    [self setSearchHistory:nil];
    [SRUserDefaults setObject:nil forKey:SRSaveKeySearchHistory];
    [self.hotWordsCollectionView reloadData];
}

@end
