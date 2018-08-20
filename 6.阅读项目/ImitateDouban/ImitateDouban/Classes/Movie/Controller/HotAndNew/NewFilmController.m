
#import "NewFilmController.h"
#import "MovieDetailController.h"
#import "MovieHttpTool.h"
#import "MovieModel.h"
#import "MovieCell.h"
#import "MJRefresh.h"

@interface NewFilmController ()

@property (nonatomic, strong) NSMutableArray *filmDatas;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NewFilmController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _filmDatas = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initTableView];
}

- (void)initTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - MovieMenuHeight - NAV_BAR_HEIGHT - TAB_BAR_HEIGHT)];
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.dataSource = (id<UITableViewDataSource>) self;;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = KBackgroundColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    __weak __typeof(self) weakSelf = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    [_tableView.mj_header beginRefreshing];
}

- (void)loadNewData{
    
    __weak NewFilmController *weakSelf = self;
    [MovieHttpTool getComingsoonWithStart:0 arrayBlock:^(NSMutableArray *array) {
        _filmDatas = array;
        [weakSelf.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
    }];
}

- (void)loadMoreData{
    
    __weak NewFilmController *weakSelf = self;
    [MovieHttpTool getComingsoonWithStart:_filmDatas.count arrayBlock:^(NSMutableArray *array) {
        [_filmDatas addObjectsFromArray: array];
        [weakSelf.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _filmDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieModel *model = [_filmDatas objectAtIndex:indexPath.row];
    return [MovieCell getCellHeight:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *hotCell = [MovieCell cellWithTableView:tableView];
    hotCell.model = [_filmDatas objectAtIndex:indexPath.row];
    return hotCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MovieDetailController *detailVC = [[MovieDetailController alloc] init];
    detailVC.movieModel = [_filmDatas objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
