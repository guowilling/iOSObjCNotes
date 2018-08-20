
#import "OutlandCityViewController.h"
#import "RecommendHttpTool.h"
#import "CityCell.h"
#import "SectionHeaderView.h"
#import "CityHelper.h"
#import "YLYTableViewIndexView.h"

@interface OutlandCityViewController () <YLYTableViewIndexDelegate>

@property (nonatomic, strong) NSDictionary *cityDatas;
@property (nonatomic, strong) NSArray *cityIndexes;
@property (nonatomic, strong) NSArray *cityGroups;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *flotageLabel;

@end

@implementation OutlandCityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //self.flotageLabel.hidden = YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initCityDatas];
    
    [self initTableView];
    
    [self initFlotageLabel];
}

- (void)initCityDatas {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"outLandCityGroup" ofType:@"plist"];
    _cityDatas   = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    _cityIndexes = [[_cityDatas allKeys] sortedArrayUsingSelector:@selector(compare:)];
    _cityGroups  = [_cityDatas allValues];
}

- (void)initTableView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - SearchBarHeight)];
    _tableView.delegate        = (id<UITableViewDelegate>)self;
    _tableView.dataSource      = (id<UITableViewDataSource>) self;
    _tableView.backgroundColor = KBackgroundColor;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

- (void)initFlotageLabel {
    
    _flotageLabel = [[UILabel alloc] init];
    _flotageLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"flotage_backgroud"]];
    _flotageLabel.hidden = YES;
    _flotageLabel.textAlignment = NSTextAlignmentCenter;
    _flotageLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.flotageLabel];
    [_flotageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    YLYTableViewIndexView *indexView = [[YLYTableViewIndexView alloc] initWithFrame:(CGRect){SCREEN_WIDTH - 20,0,20,SCREEN_HEIGHT}];
    indexView.tableViewIndexDelegate = self;
    [self.view addSubview:indexView];
    
    CGRect rect = indexView.frame;
    rect.size.height = _cityIndexes.count * 16;
    rect.origin.y = (SCREEN_HEIGHT - 64 - rect.size.height) / 2;
    indexView.frame = rect;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _cityIndexes.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SectionHeaderView *headerView = [[SectionHeaderView alloc] init];
    headerView.text = [_cityIndexes objectAtIndex:section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return [SectionHeaderView getSectionHeaderHeight];
}

- (NSArray *)sectionIndexsAtIndexes:(NSIndexSet *)indexes {
    
    return _cityIndexes;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [_cityDatas[_cityIndexes[section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [CityCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CityCell *cell = [CityCell cellWithTableView:tableView];
    NSDictionary *cityDic = _cityDatas[_cityIndexes[indexPath.section]][indexPath.row];
    NSString *cityname = [[cityDic allKeys] firstObject];
    cell.cityName = cityname;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *cityDic = _cityDatas[_cityIndexes[indexPath.section]][indexPath.row];
    NSString *cityname = [[cityDic allKeys] firstObject];
    if ([_delegate respondsToSelector:@selector(outlandCityViewControllerDidSelectCity:)]) {
        [_delegate outlandCityViewControllerDidSelectCity:cityname];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -YLYTableViewIndexDelegate

- (void)tableViewIndex:(YLYTableViewIndexView *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title {
    
    if ([_tableView numberOfSections] > index && index > -1){ // for safety should always be YES
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
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

@end
