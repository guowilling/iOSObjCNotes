
#import "PickCityViewController.h"
#import "OutlandCityViewController.h"
#import "InlandCityViewController.h"
#import "LocationHelper.h"
#import "SearchCityViewController.h"

@interface PickCityViewController () <InlandCityViewControllerDelegate, OutlandCityViewControllerDelegate, SearchCityViewControllerDelegate>

@property (nonatomic, strong) InlandCityViewController *inlandCityVC;
@property (nonatomic, strong) OutlandCityViewController *outlandCityVC;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;

@end

@implementation PickCityViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSegmentedControl];
    
    [self addChildControllers];
    
    [self setupSearchBar];
    
    [self setupScrollView];
}

- (void)setupSegmentedControl {
    
    NSArray *items = [[NSArray alloc] initWithObjects:@"国内", @"国外", nil];
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    _segmentedControl.frame = CGRectMake(0, 0, 180, 30);
    _segmentedControl.tintColor = TheThemeColor;
    [_segmentedControl setSelectedSegmentIndex:0];
    [_segmentedControl addTarget:self
                          action:@selector(segmentedControlAction:)
                forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _segmentedControl;
}

- (void)addChildControllers {
    
    _inlandCityVC = [[InlandCityViewController alloc] init];
    _outlandCityVC = [[OutlandCityViewController alloc] init];
    _inlandCityVC.delegate = self;
    _outlandCityVC.delegate = self;
    [self addChildViewController:_inlandCityVC];
    [self addChildViewController:_outlandCityVC];
}

- (void)setupSearchBar {
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SearchBarHeight)];
    searchBar.placeholder = @"输入城市名查询";
    searchBar.userInteractionEnabled = YES;
    searchBar.backgroundImage = [UIImage imageNamed:@"searchBarBackImage"];
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = KBackgroundColor;
    
    UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    coverBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, SearchBarHeight);
    [coverBtn addTarget:self action:@selector(showSearchViewController)
       forControlEvents:UIControlEventTouchUpInside];
    [searchBar addSubview:coverBtn];
    [self.view addSubview:searchBar];
}

- (void)setupScrollView {
    
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SearchBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SearchBarHeight)];
    self.backgroundScrollView.backgroundColor = [UIColor whiteColor];
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.delegate = (id<UIScrollViewDelegate>)self;
    self.backgroundScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
    [self.view addSubview:self.backgroundScrollView];
    for (int i = 0; i < 2; i++) {
        UIViewController *viewController = self.childViewControllers[i];
        viewController.view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.backgroundScrollView addSubview:viewController.view];
    }
    [self.backgroundScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
}

- (void)showSearchViewController {
    
    SearchCityViewController *searchCityController = [[SearchCityViewController alloc] init];
    searchCityController.delegate = self;
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:searchCityController];
    navC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:navC animated:YES completion:nil];
}

- (void)segmentedControlAction:(id)sender {
    
    NSInteger selectedIndex = [sender selectedSegmentIndex];
    [self.backgroundScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*selectedIndex, 0)
                                       animated:NO];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger pageIndex = (NSInteger)scrollView.contentOffset.x/SCREEN_WIDTH;
    [_segmentedControl setSelectedSegmentIndex:pageIndex];
}

#pragma mark - InlandCityViewControllerDelegate

- (void)inlandCityViewControllerDidSelectCity:(NSString *)city {
    
    if ([_delegate respondsToSelector:@selector(PickCityViewControllerDidSelectCity:)]) {
        [_delegate PickCityViewControllerDidSelectCity:city];
    }
}

#pragma mark - OutlandCityViewControllerDelegate

- (void)outlandCityViewControllerDidSelectCity:(NSString *)city {
    
    if ([_delegate respondsToSelector:@selector(PickCityViewControllerDidSelectCity:)]) {
        [_delegate PickCityViewControllerDidSelectCity:city];
    }
}

#pragma mark - SearchCityViewControllerDelegate

- (void)searchCityViewControllerDidSelectCity:(NSString *)city {
    
    if ([_delegate respondsToSelector:@selector(PickCityViewControllerDidSelectCity:)]) {
        [_delegate PickCityViewControllerDidSelectCity:city];
    }
}

@end
