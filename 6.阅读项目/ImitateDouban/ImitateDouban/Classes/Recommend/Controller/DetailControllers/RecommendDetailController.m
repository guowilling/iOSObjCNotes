
#import "RecommendDetailController.h"
#import "UIImage+ImageEffects.h"
#import "RecommendHttpTool.h"
#import "BLRColorComponents.H"
#import "DetailHeadView.h"
#import "DetailFirstCell.h"
#import "DetialSecondCell.h"
#import "MapViewController.h"

@interface RecommendDetailController () <UITableViewDelegate,UITableViewDataSource> {
    
    UILabel *_titleLabel;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *backBlurImageView;

@end

@implementation RecommendDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:16.0];
    _titleLabel.frame = CGRectMake(SCREEN_WIDTH/2 - 100, 20, 200, 20);
    _titleLabel.text = _recommendModel.title;
    _titleLabel.hidden = YES;
    self.navigationItem.titleView = _titleLabel;
    
    [self initTableView];
    
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeAll;
        self.automaticallyAdjustsScrollViewInsets = YES;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    [self.navigationController.navigationBar setTranslucent:YES];

    if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)]) {
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    }
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
}

- (void)initTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT )];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = UIEdgeInsetsMake(KActivityDetailHeadH, 0, 0, 0);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _backBlurImageView = [[UIImageView alloc] init];
    _backBlurImageView.frame = CGRectMake(0, -KActivityDetailHeadH, SCREEN_WIDTH, KActivityDetailHeadH);
    _backBlurImageView.userInteractionEnabled = YES;
    _backBlurImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_tableView addSubview:_backBlurImageView];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:_recommendModel.image] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
         [_backBlurImageView setImage:[image applyBlurWithCrop:CGRectMake(0, 0, SCREEN_HEIGHT, KActivityDetailHeadH)
                                                          resize:CGSizeMake(SCREEN_WIDTH, KActivityDetailHeadH)
                                                      blurRadius:[BLRColorComponents darkEffect].radius
                                                       tintColor:[BLRColorComponents darkEffect].tintColor
                                           saturationDeltaFactor:[BLRColorComponents darkEffect].saturationDeltaFactor maskImage:nil]];
     }];

    DetailHeadView *headView = [[DetailHeadView alloc] init];
    headView.frame = CGRectMake(0, -KActivityDetailHeadH , SCREEN_WIDTH, KActivityDetailHeadH);
    headView.recommendModel = _recommendModel;
    [_tableView addSubview:headView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < -KActivityDetailHeadH ) {
        CGRect frame = _backBlurImageView.frame;
        frame.origin.y = offsetY - 20;
        frame.size.height =  -offsetY + 20;
        _backBlurImageView.frame = frame;
    }
    
    if (offsetY > -64) {
        _titleLabel.hidden = NO;
    } else {
        _titleLabel.hidden = YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return [DetailFirstCell getCellHeight:_recommendModel];
    }
    return [DetialSecondCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        DetailFirstCell *firstCell = [DetailFirstCell cellWithTableView:tableView];
        firstCell.model = _recommendModel;
        return firstCell;
    }
    DetialSecondCell *secondCell = [DetialSecondCell cellWithTableView:tableView];
    secondCell.model = _recommendModel;
    switch (indexPath.row) {
        case 1:
            secondCell.title = @"即时讨论";
            break;
        case 2:
            secondCell.title = @"地址";
            break;
        default:
            break;
    }
    return secondCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        MapViewController *mapVC = [[MapViewController alloc] init];
        mapVC.activityName = _recommendModel.title;
        mapVC.address = _recommendModel.address;
        mapVC.geo = _recommendModel.geo;
        [self.navigationController pushViewController:mapVC animated:YES];
    }
}

@end
