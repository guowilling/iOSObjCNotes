
#import "MovieViewController.h"
#import "MovieMenuView.h"
#import "HotFilmController.h"
#import "NewFilmController.h"

@interface MovieViewController () <MovieMenuViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *backgroundScrollView;
@property (nonatomic, strong) MovieMenuView *movieMenuView;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initMenuView];
    
    [self initControllers];
    
    [self initScrollView];
}

- (void)initMenuView {
    
    _movieMenuView = [[MovieMenuView alloc] init];
    _movieMenuView.backgroundColor = [UIColor whiteColor];
    _movieMenuView.frame = CGRectMake(0, NAV_BAR_HEIGHT, SCREEN_WIDTH, MovieMenuHeight);
    _movieMenuView.delegate = self;
    [self.view addSubview:_movieMenuView];
}

- (void)initControllers {

    [self addChildViewController:[[HotFilmController alloc] init]];
    [self addChildViewController:[[NewFilmController alloc] init]];
}

- (void)initScrollView {
    
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT + MovieMenuHeight, SCREEN_WIDTH, SCREEN_HEIGHT - MovieMenuHeight - NAV_BAR_HEIGHT - TAB_BAR_HEIGHT)];
    self.backgroundScrollView.backgroundColor = KBackgroundColor;
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backgroundScrollView.delegate = self;
    self.backgroundScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.childViewControllers.count, 0);
    [self.view addSubview:self.backgroundScrollView];
    [self.backgroundScrollView setContentOffset:CGPointMake(1, 0) animated:YES];
}

- (void)loadChildViewControllerByIndex:(NSUInteger)index {
    
    UIViewController *showingVC = self.childViewControllers[index];
    if ([showingVC isViewLoaded]) {
        return;
    }
    showingVC.view.frame = CGRectMake(index * self.backgroundScrollView.width, 0, self.backgroundScrollView.width, self.backgroundScrollView.height);
    [self.backgroundScrollView addSubview:showingVC.view];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    int pageIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
    [self loadChildViewControllerByIndex:pageIndex];
    [_movieMenuView bottomLineAnimationBtnIndex:pageIndex];
    [self movieMenuViewDidSelectIndex:pageIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int pageIndex = scrollView.contentOffset.x/SCREEN_WIDTH;
    [self loadChildViewControllerByIndex:pageIndex];
    [_movieMenuView bottomLineAnimationBtnIndex:pageIndex];
    [self movieMenuViewDidSelectIndex:pageIndex];
}

- (void)movieMenuViewDidSelectIndex:(int)index {
    
    [self loadChildViewControllerByIndex:index];
    [self.backgroundScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0) animated:NO];
}

@end
