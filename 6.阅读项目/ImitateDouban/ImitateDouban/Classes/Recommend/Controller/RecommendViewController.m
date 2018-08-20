
#import "RecommendViewController.h"
#import "MJRefresh.h"
#import "RecommendHttpTool.h"
#import "RecommendModel.h"
#import "RecommendCell.h"
#import "LocationHelper.h"
#import "CityHelper.h"
#import "RecommendDetailController.h"
#import "DXPopover.h"
#import "CategoryTableView.h"
#import "RecommendHeadView.h"
#import "PickCityViewController.h"

@interface RecommendViewController () <UITableViewDataSource, UITableViewDelegate, RecommendHeadViewDelegate, PickCityViewControllerDelegate, CategoryTableViewDelegate>

@property (nonatomic, copy) NSString *cityID;

@property (nonatomic, strong) NSMutableArray *recommendModels;

@property (nonatomic, strong) UIButton  *titleLBtn;
@property (nonatomic, strong) DXPopover *popover;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSDictionary *categoies;
@property (nonatomic, copy) NSString *currentCategoryType;

@property (nonatomic, assign, getter=isSelectCity) BOOL selectCity;
@property (nonatomic, copy) NSString *currentCity;
@property (nonatomic, copy) NSString *currentLocation;

@end

@implementation RecommendViewController

#pragma mark - getters and setters

- (NSString *)currentLocation {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentLocation];
}

- (void)setCurrentLocation:(NSString *)currentLocation {
    
    [[NSUserDefaults standardUserDefaults] setObject:currentLocation forKey:kCurrentLocation];
}

- (NSString *)currentCity {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCity];
}

- (void)setCurrentCity:(NSString *)currentCity {
    
    [[NSUserDefaults standardUserDefaults] setValue:currentCity forKey:kCurrentCity];
}

- (BOOL)isSelectCity {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:kIsSelectCity];
}

- (void)setSelectCity:(BOOL)selectCity {
    
    [[NSUserDefaults standardUserDefaults] setBool:selectCity forKey:kIsSelectCity];
}

- (NSString *)currentCategoryType {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCategoryType];
}

- (void)setCurrentCategoryType:(NSString *)currentCategoryType {
    
    [[NSUserDefaults standardUserDefaults] setObject:currentCategoryType forKey:kCurrentCategoryType];
}

- (NSDictionary *)categoies {
    
    if (!_categoies) {
        _categoies = [[NSDictionary alloc] initWithObjects:@[@"热门", @"音乐", @"戏剧", @"展览", @"讲座", @"聚会", @"运动", @"旅行", @"公益", @"电影"]
                                                   forKeys:@[@"all", @"music", @"drama", @"exhibition", @"salon", @"party", @"sports", @"travel", @"commonweal", @"film"]];
    }
    return _categoies;
}

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _recommendModels = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNavBar];
    
    [self setupTableView];
    
    [self loadData];
}

- (void)setupNavBar {
    
    _titleLBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.currentCategoryType) {
        [_titleLBtn setTitle:[self.categoies objectForKey:self.currentCategoryType]
                    forState:UIControlStateNormal];
    } else {
        [_titleLBtn setTitle:[self.categoies objectForKey:@"all"]
                    forState:UIControlStateNormal];
    }
    [_titleLBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_titleLBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [_titleLBtn setImage:[UIImage imageNamed:@"LuckyMoney_ChangeArrow"] forState:UIControlStateNormal];
    [_titleLBtn addTarget:self action:@selector(showPopover)
         forControlEvents:UIControlEventTouchUpInside];
    _titleLBtn.frame = CGRectMake(0, 0, 80, 40);
    [_titleLBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 60, 0, 0)];
    [_titleLBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    self.navigationItem.titleView = _titleLBtn;
}

- (void)showPopover {
    
    if (_popover) {
        return;
    }
    self.navigationItem.titleView.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.3
          initialSpringVelocity:5
                        options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            self.navigationItem.titleView.transform = CGAffineTransformIdentity;
                        } completion:nil];
    _popover = [DXPopover new];
    _popover.maskType = DXPopoverMaskTypeBlack;
    _popover.contentInset = UIEdgeInsetsZero;
    _popover.backgroundColor = [UIColor whiteColor];
    CategoryTableView *categoryTableView = [[CategoryTableView alloc] initWithFrame:CGRectMake(0, 0, 150, 400)];
    categoryTableView.delegate = self;
    categoryTableView.backgroundColor = [UIColor clearColor];
    CGPoint startPoint = CGPointMake(CGRectGetMidX(self.navigationItem.titleView.frame), CGRectGetMaxY(self.navigationItem.titleView.frame) + 20);
    [self.popover showAtPoint:startPoint
               popoverPostion:DXPopoverPositionDown
              withContentView:categoryTableView
                       inView:self.view];
    __weak typeof(self) weakSelf = self;
    _popover.didDismissHandler = ^{
        weakSelf.popover = nil;
    };
}

- (void)setupTableView {

    _tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44)];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.backgroundColor = KBackgroundColor;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    RecommendHeadView *headView = [[RecommendHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    if (self.isSelectCity) {
        headView.currentCityLabel.text = self.currentCity;
    } else {
        if (self.currentLocation) {
            headView.currentCityLabel.text = self.currentLocation;
        } else {
            headView.currentCityLabel.text = @"北京";
        }
    }
    headView.delegate = self;
    _tableView.tableHeaderView = headView;
    
    __weak typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshDataWithCityID:weakSelf.cityID];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreDataWithCityID:weakSelf.cityID];
    }];
}

- (void)loadData {
    
    if (self.isSelectCity) {
        NSString *cityname = self.currentCity;
        self.cityID = [CityHelper getCityIDByName:cityname];
        [self refreshDataWithCityID:_cityID];
    } else {
        if (self.currentLocation) {
            self.cityID = [CityHelper getCityIDByName:self.currentLocation];
            [self refreshDataWithCityID:self.cityID];
            
            LocationHelper *manager = [LocationHelper sharedLocationManager];
            __weak RecommendViewController *weekSelf = self;
            [manager currentLocation:^(CLLocation *currentLocation, NSString *cityName) {
                if ([self.currentLocation isEqualToString:cityName]) {
                    return;
                }
                self.currentLocation = cityName;
                RecommendHeadView *headView = (RecommendHeadView *)self.tableView.tableHeaderView;
                headView.currentCityLabel.text = cityName;
                weekSelf.cityID = [CityHelper getCityIDByName:cityName];
                [weekSelf refreshDataWithCityID:weekSelf.cityID];
            }];
        } else {
            self.currentCategoryType = @"all";
            self.currentLocation = @"北京";
            self.cityID = [CityHelper getCityIDByName:@"北京"];
            [self refreshDataWithCityID:self.cityID];
          
            LocationHelper *manager = [LocationHelper sharedLocationManager];
            [manager currentLocation:^(CLLocation *currentLocation, NSString *cityName) {
                RecommendHeadView *headView = (RecommendHeadView *)self.tableView.tableHeaderView;
                headView.currentCityLabel.text = cityName;
            }];
        }
    }
}

- (void)refreshDataWithCityID:(NSString *)cityID {
    
    [self.tableView.mj_header beginRefreshing];
    
    __weak typeof(self)weakSelf = self;
    [RecommendHttpTool getRecommendList:0
                                    loc:self.cityID
                                   type:self.currentCategoryType
                             arrayBlock:^(NSMutableArray *resultArray) {
                                 [weakSelf.tableView.mj_header endRefreshing];
                                 [weakSelf.tableView.mj_footer resetNoMoreData];
                                 _recommendModels = resultArray;
                                 [weakSelf.tableView reloadData];
                             }];
}

- (void)loadMoreDataWithCityID:(NSString *)cityID {
    
    //[_titleLBtn setTitle:self.categoies[self.currentCategoryType] forState:UIControlStateNormal];
    __weak typeof(self)weakSelf = self;
    [RecommendHttpTool getRecommendList:_recommendModels.count
                                    loc:_cityID
                                   type:self.currentCategoryType
                             arrayBlock:^(NSMutableArray *resultArray) {
                                 [weakSelf.tableView.mj_footer endRefreshing];
                                 [_recommendModels addObjectsFromArray:resultArray];
                                 [weakSelf.tableView reloadData];
                             }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _recommendModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecommendModel *model = [_recommendModels objectAtIndex:indexPath.row];
    return [RecommendCell getCellHeight:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RecommendModel *model = [_recommendModels objectAtIndex:indexPath.row];
    RecommendCell *activityCell = [RecommendCell cellWithTableView:tableView];
    activityCell.model = model;
    return activityCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RecommendModel *model = [_recommendModels objectAtIndex:indexPath.row];
    RecommendDetailController *detailVC = [[RecommendDetailController alloc] init];
    detailVC.recommendModel = model;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - RecommendHeadViewDelegate

- (void)recommendHeadViewTapAction {
    
    PickCityViewController *pickCityVC = [[PickCityViewController alloc] init];
    pickCityVC.delegate = self;
    [self.navigationController pushViewController:pickCityVC animated:YES];
}

#pragma mark - PickCityViewControllerDelegate

- (void)PickCityViewControllerDidSelectCity:(NSString *)city {
    
    if (!city) {
        return;
    }
    RecommendHeadView *headView = (RecommendHeadView *)self.tableView.tableHeaderView;
    headView.currentCityLabel.text = city;
    [self setCurrentCity:city];
    self.selectCity = YES;
    self.cityID = [CityHelper getCityIDByName:city];
    [self refreshDataWithCityID:self.cityID];
}

#pragma mark - CategoryTableViewDelegate

- (void)categoryTableViewDidSelectCategory:(NSString *)categoryName {
    
    [self.popover dismiss];
    
    [_titleLBtn setTitle:categoryName forState:UIControlStateNormal];
    
    NSString *categoryType = [[self.categoies allKeysForObject:categoryName] firstObject];
    self.currentCategoryType = categoryType;
    
    [self refreshDataWithCityID:self.cityID];
}

@end
