
#import "MovieDetailController.h"
#import "BLRColorComponents.h"
#import "UIImage+ImageEffects.h"
#import "UIBarButtonItem+Extension.h"
#import "TranslucentNavBar.h"
#import "AvatarsModel.h"
#import "MovieDetailHeadView.h"
#import "MovieHttpTool.h"
#import "MovieDetailIntroCell.h"

@interface MovieDetailController () <UITableViewDataSource, UITableViewDelegate> {
    
    TranslucentNavBar   *_navgationBar;
    MovieDetailHeadView *_detailHeadView;
    DetailMovieModel    *_deatilMovieModel;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *expandZoomImageView;

@end

@implementation MovieDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initTableView];
    
    [self setupNavgationbar];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)setupNavgationbar {
    
    _navgationBar = [[TranslucentNavBar alloc] init];
    _navgationBar.title = _movieModel.title;
    _navgationBar.orgTitle = _movieModel.original_title;
    [self.view addSubview:_navgationBar];
    _navgationBar.barHidden = YES;
}

- (void)initTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT )];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = UIEdgeInsetsMake(KMovieDetailHeadH, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _expandZoomImageView = [[UIImageView alloc] init];
    _expandZoomImageView.frame = CGRectMake(0, -KMovieDetailHeadH, SCREEN_WIDTH, KMovieDetailHeadH);
    _expandZoomImageView.userInteractionEnabled = YES;
    _expandZoomImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_tableView addSubview: _expandZoomImageView];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:_movieModel.images.medium] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
        // ...
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [_expandZoomImageView setImage:[image applyBlurWithCrop:CGRectMake(0, 0, SCREEN_HEIGHT, KMovieDetailHeadH) resize:CGSizeMake(SCREEN_WIDTH, KMovieDetailHeadH) blurRadius:[BLRColorComponents darkEffect].radius tintColor:[BLRColorComponents darkEffect].tintColor saturationDeltaFactor:[BLRColorComponents darkEffect].saturationDeltaFactor maskImage:nil]];
    }];
    
    _detailHeadView = [[MovieDetailHeadView alloc] init];
    _detailHeadView.frame = CGRectMake(0, -KMovieDetailHeadH , SCREEN_WIDTH, KMovieDetailHeadH );
    _detailHeadView.model = _movieModel;
    [_tableView addSubview:_detailHeadView];
}

- (void)loadData {
    
    [MovieHttpTool getMovieInfoWithID:_movieModel.ID movieInfoBlock:^(DetailMovieModel *movieModel) {
        _deatilMovieModel = movieModel;
        _detailHeadView.infoModel = movieModel;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return [MovieDetailIntroCell heightWithModel:_deatilMovieModel];
    } else {
        return 100;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        MovieDetailIntroCell *introCell = [MovieDetailIntroCell cellWithTableView:tableView];
        introCell.indexPath = indexPath;
        introCell.block = ^(NSIndexPath *path) {
            [tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
        };
        [introCell configCellWithModel:_deatilMovieModel];
        return introCell;
    } else {
        static NSString *cellIndertifer = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndertifer];
        }
        cell.textLabel.text = @"测试数据";
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat yOffset  = scrollView.contentOffset.y;
    if (yOffset < -KMovieDetailHeadH ) {
        CGRect f = _expandZoomImageView.frame;
        f.origin.y = yOffset - 20;
        f.size.height =  -yOffset + 20;
        _expandZoomImageView.frame = f;
    }
    
    if (yOffset > -64) {
        _navgationBar.barHidden = NO;
    } else {
        _navgationBar.barHidden = YES;
    }
}

- (void)dealloc {
    
    _tableView.delegate = nil;
}

@end
