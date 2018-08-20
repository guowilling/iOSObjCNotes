//
//  SRGiftsViewController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRGiftsViewController.h"
#import "SRCategory.h"
#import "SRCategoryCell.h"
#import "SRSubCategory.h"
#import "SRSubCategoryCell.h"
#import "SRSubCategoryHeaderReusableView.h"
#import "SRItemViewController.h"

@interface SRGiftsViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic, assign, getter=isDown) BOOL down;
@property (nonatomic, assign, getter=isFlag) BOOL flag;

@end

@implementation SRGiftsViewController

#pragma mark - Lazy load

- (AFHTTPSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.session.configuration.timeoutIntervalForRequest = 5;
    }
    return _sessionManager;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setupTableView];
    
    [self setupCollectionView];
    
    [self sendHTTPRequest];
}

#pragma mark - Setup UI

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.rowHeight = 40;
    [self.view addSubview:tableView];
    [tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
        make.width.equalTo(70);
    }];
    self.tableView = tableView;
//    self.tableView.backgroundColor = SRRandomColor;
}

- (void)setupCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat kItemMargin = 10.0;
    CGFloat kLineMargin = 10.0;
    flowLayout.minimumInteritemSpacing = kItemMargin;
    flowLayout.minimumLineSpacing = kLineMargin;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    flowLayout.headerReferenceSize = CGSizeMake(self.collectionView.bounds.size.width, 44);
    CGFloat itemW = (SRScreenW - 5 * kItemMargin) * 0.25;
    CGFloat itemH = itemW * 1.5;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    [collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.bottom.equalTo(self.mas_bottomLayoutGuide);
        make.left.equalTo(self.tableView.right);
    }];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SRSubCategoryCell class]) bundle:nil]
     forCellWithReuseIdentifier:subCategoryCellID];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SRSubCategoryHeaderReusableView class]) bundle:nil]
     forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            withReuseIdentifier:subCategoryHeaderID];
    self.collectionView = collectionView;
//    self.collectionView.backgroundColor = SRRandomColor;
}

#pragma mark - Network request

- (void)sendHTTPRequest {
    
    NSString *URLString = @"http://api.liwushuo.com/v2/item_categories/tree?";
    [SVProgressHUD showWithStatus:@"正在加载"];
    [self.sessionManager GET:URLString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        [SVProgressHUD dismiss];
        [self setCategories:[SRCategory objectArrayWithKeyValuesArray:responseObject[@"data"][@"categories"]]];
        [self.tableView reloadData];
        [self.collectionView reloadData];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络错误"];
        SRLog(@"error: %@", error);
    }];
}

#pragma mark - TableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SRCategoryCell *cell = [SRCategoryCell cellWithTableView:tableView];
    SRCategory *category = self.categories[indexPath.row];
    cell.category = category;
    return cell;
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.flag = YES;
    NSIndexPath *subIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
    [self.collectionView selectItemAtIndexPath:subIndexPath animated:YES scrollPosition: UICollectionViewScrollPositionTop];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.categories.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    SRCategory *category = self.categories[section];
    return category.subcategories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SRSubCategoryCell *cell = [SRSubCategoryCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    SRCategory *category = self.categories[indexPath.section];
    SRSubCategory *subCategory = category.subcategories[indexPath.row];
    cell.subCategory = subCategory;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    SRSubCategoryHeaderReusableView *reusableView = [SRSubCategoryHeaderReusableView resuableViewWithCollectionView:collectionView forIndexPath:indexPath];
    SRCategory *category = self.categories[indexPath.section];
    reusableView.category = category;
    return reusableView;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SRCategory *category = self.categories[indexPath.section];
    SRSubCategory *subCategory = category.subcategories[indexPath.row];
    SRItemViewController *itemVC = [[SRItemViewController alloc] init];
    itemVC.firstPageURL = [self subCategoryURLWithNumber:subCategory.ID];
    itemVC.title = subCategory.name;
    [self.navigationController pushViewController:itemVC animated:YES];
}

- (NSString *)subCategoryURLWithNumber:(NSInteger)number {
    
    NSMutableString *channelURL = [NSMutableString stringWithString:@"http://api.liwushuo.com/v1/item_subcategories/"];
    [channelURL appendFormat:@"%ld", (long)number];
    [channelURL appendString:@"/items?limit=20&offset=0"];
    return channelURL;
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isFlag == YES) {
        return;
    }
    
    SRCategory *category = self.categories[indexPath.section];
    if (indexPath.row == category.subcategories.count - 1 && self.isDown) { // 最后一个 item 消失并向下滚时更改 tableView 的选中行
        NSInteger section = indexPath.section + 1; // 消失的是上一个 section 所以 +1
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:section inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isFlag == YES) {
        return;
    }
    
    SRCategory *category = self.categories[indexPath.section];
    if (indexPath.row == category.subcategories.count / 2 && !self.isDown) { // 有一半 item 展示出来并向上滚时更改 tableView 的选中行
        NSInteger section = indexPath.section; // 显示的是当前的 section
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:section inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    static CGFloat previousOffsetY = 0;
    if ([scrollView isKindOfClass:[UICollectionView class]]) { // 一定要判断, 不然会有 bug.
        if (previousOffsetY <= scrollView.contentOffset.y) {
            self.down = YES;
        } else {
            self.down = NO;
        }
        previousOffsetY = scrollView.contentOffset.y;
        if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.sr_height + 20) {
            if (self.flag == YES) return;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.categories.count - 1 inSection:0];
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.flag = NO; // 手动滚动 collectionView 时让 collectionView 决定 tableVew 的选中行
}

@end
