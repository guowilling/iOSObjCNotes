
#import "MeViewController.h"
#import "OAuthViewController.h"
#import "UserAccountTool.h"
#import "MeHttpTool.h"

@interface MeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initTableView];
    
    [MeHttpTool userInfosSuccess:^(UserInfos *user) {
        NSLog(@"user : %@", user);
    } failure:^(UserInfos *user, NSError *error) {
        NSLog(@"user : %@; error : %@", user, error);
    }];
}

- (void)initTableView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT )];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndertifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndertifer];
    }
    cell.textLabel.text = @"OAuth授权登录";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OAuthViewController *outhVC = [[OAuthViewController alloc] init];
    [self.navigationController pushViewController:outhVC animated:YES];
}

- (void)dealloc {
    
    _tableView.delegate = nil;
}

@end
