
#import "InlandCityViewController.h"
#import "RecommendHttpTool.h"
#import "CityCell.h"
#import "SectionHeaderView.h"
#import "CityHelper.h"
#import "YLYTableViewIndexView.h"
#import "LocationCityCell.h"
#import "HotCityCell.h"

@interface InlandCityViewController () <UITableViewDataSource, UITableViewDelegate,YLYTableViewIndexDelegate, LocationCityCellDelegate, HotCityCellDelegate>

@property (nonatomic, strong) NSDictionary *cityDatas;
@property (nonatomic, strong) NSArray *cityPreIndexes;
@property (nonatomic, strong) NSArray *cityIndexes;
@property (nonatomic, strong) NSArray *cityGroups;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *flotageLabel;

@end

@implementation InlandCityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initCityDatas];
    
    [self initTableView];
    
    [self initTableIndex];
    
    [self initFlotageLabel];
}

- (void)initCityDatas {
    
    _cityPreIndexes = @[@"当前城市", @"热门城市"];
    NSString *inlandPlistFilePath = [[NSBundle mainBundle] pathForResource:@"inLandCityGroup" ofType:@"plist"];
    _cityDatas   = [[NSDictionary alloc] initWithContentsOfFile:inlandPlistFilePath];
    _cityIndexes = [[_cityDatas allKeys] sortedArrayUsingSelector:@selector(compare:)];
    _cityGroups  = [_cityDatas allValues];
}

- (void)initTableView {
    
    _tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - SearchBarHeight)];
    _tableView.delegate        = (id)self;
    _tableView.dataSource      = (id)self;
    _tableView.backgroundColor = KBackgroundColor;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

- (void)initTableIndex {
    
    YLYTableViewIndexView *indexView = [[YLYTableViewIndexView alloc] initWithFrame:(CGRect){SCREEN_WIDTH - 25, 0, 25, SCREEN_HEIGHT}];
    CGRect rect = indexView.frame;
    rect.size.height = _cityIndexes.count * 16;
    rect.origin.y = (SCREEN_HEIGHT - 64 - rect.size.height) / 2;
    indexView.frame = rect;
    indexView.tableViewIndexDelegate = self;
    [self.view addSubview:indexView];
}

- (void)initFlotageLabel {
    
    _flotageLabel = [[UILabel alloc] init];
    _flotageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"flotage_backgroud"]];
    _flotageLabel.hidden = YES;
    _flotageLabel.textAlignment = NSTextAlignmentCenter;
    _flotageLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:_flotageLabel];
    [_flotageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _cityPreIndexes.count + _cityIndexes.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section <= 1) {
        return 1;
    } else {
        return [_cityDatas[_cityIndexes[section - 2]] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [LocationCityCell cellWithTableView:tableView];
        LocationCityCell *locationCityCell = (LocationCityCell *)cell;
        locationCityCell.delegate = self;
    } else if (indexPath.section == 1) {
        cell = [HotCityCell cellWithTableView:tableView];
        HotCityCell *hotCityCell = (HotCityCell *)cell;
        hotCityCell.delegate = self;
    } else {
        cell = [CityCell cellWithTableView:tableView];
        NSDictionary *cityDic = _cityDatas[_cityIndexes[indexPath.section - 2]][indexPath.row];
        ((CityCell *)cell).cityName = [[cityDic allKeys] firstObject];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return [LocationCityCell getCellHeight];
    } else if(indexPath.section == 1) {
        return [HotCityCell getCellHeight];
    } else {
        return [CityCell getCellHeight];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return [SectionHeaderView getSectionHeaderHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SectionHeaderView *headerView = [[SectionHeaderView alloc] init];
    if (section <= 1) {
        headerView.text = [_cityPreIndexes objectAtIndex:section];
    } else {
        headerView.text = [_cityIndexes objectAtIndex:section - 2];
    }
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section <= 1) {
        return;
    }
    
    NSDictionary *cityDic = _cityDatas[_cityIndexes[indexPath.section - 2]][indexPath.row];
    NSString *cityname = [[cityDic allKeys] firstObject];
    if ([_delegate respondsToSelector:@selector(inlandCityViewControllerDidSelectCity:)]) {
        [_delegate inlandCityViewControllerDidSelectCity:cityname];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - YLYTableViewIndexDelegate

- (void)tableViewIndex:(YLYTableViewIndexView *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title {
    
    // For safety should always be YES.
    if (index >= 0  && index < [_tableView numberOfSections]) {
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index + 2]
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:NO];
        self.flotageLabel.text = title;
    }
}

- (void)tableViewIndexTouchesBegan:(YLYTableViewIndexView *)tableViewIndex {
    
    self.flotageLabel.hidden = NO;
}

- (void)tableViewIndexTouchesEnd:(YLYTableViewIndexView *)tableViewIndex {
    
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [self.flotageLabel.layer addAnimation:animation forKey:nil];
    self.flotageLabel.hidden = YES;
}

- (NSArray *)tableViewIndexTitle:(YLYTableViewIndexView *)tableViewIndex {
    
    return _cityIndexes;
}

#pragma mark - Other delegate
- (void)locationCityCellDidSelectCity:(NSString *)city {
    
    [self.navigationController popViewControllerAnimated:YES];
    if ([_delegate respondsToSelector:@selector(inlandCityViewControllerDidSelectCity:)]) {
        [_delegate inlandCityViewControllerDidSelectCity:city];
    }
}

- (void)hotCityCellDidSelectCity:(NSString *)city {
    
    [self.navigationController popViewControllerAnimated:YES];
    if ([_delegate respondsToSelector:@selector(inlandCityViewControllerDidSelectCity:)]) {
        [_delegate inlandCityViewControllerDidSelectCity:city];
    }
}

@end
