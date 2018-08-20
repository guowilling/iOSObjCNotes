
#import "SearchCityViewController.h"
#import "YLYSearchBar.h"
#import "CityCell.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "CityHelper.h"

@interface SearchCityViewController () {
    
    YLYSearchBar *_searchTF;
    UIView *_warningView;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *searchResults;

@end

@implementation SearchCityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self initWarningLabel];
    
    [self initSearchBar];
    
    [self initTableView];
}

- (void)initWarningLabel {
    
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel *warningL = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, (SCREEN_HEIGHT - 40)/2 - 100, 100, 40)];
    warningL.text = @"无结果";
    warningL.font = [UIFont systemFontOfSize:25];
    warningL.textColor = [UIColor grayColor];
    [bgView addSubview:warningL];
    [self.view addSubview:bgView];
    _warningView = bgView;
    _warningView.hidden = YES;
}

- (void)initSearchBar {
    
    UIView *searchView = [[UIView alloc] init];
    searchView.backgroundColor = [UIColor clearColor];
    searchView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    
    _searchTF = [[YLYSearchBar alloc] init];
    _searchTF.keyboardType = UIKeyboardTypeWebSearch;
    _searchTF.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _searchTF.layer.borderWidth = 0.2;
    _searchTF.layer.cornerRadius = 4;
    _searchTF.delegate = (id<UITextFieldDelegate>)self;
    _searchTF.backgroundColor = KBackgroundColor;
    _searchTF.frame = CGRectMake(0, 5, SCREEN_WIDTH - 60, 32);
    [_searchTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [searchView addSubview:_searchTF];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(SCREEN_WIDTH - 65, 5, 60, 32);
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:17.f];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:TheThemeColor forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction)
           forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:cancelButton];
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.titleView = searchView;
    [_searchTF becomeFirstResponder];
}

- (void)initTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableView.dataSource = (id<UITableViewDataSource>)self;
    _tableView.delegate = (id<UITableViewDelegate>)self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [AppTools colorWithHexString:@"f8f8f8"];
    [self.view addSubview:_tableView];
}

- (void)cancelAction {
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.75;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromBottom;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [CityCell getCellHeight];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CityCell *cell = [CityCell cellWithTableView:tableView];
    cell.cityName = _searchResults[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self cancelAction];
    NSString *cityName = _searchResults[indexPath.row];
    if ([_delegate respondsToSelector:@selector(searchCityViewControllerDidSelectCity:)]) {
        [_delegate searchCityViewControllerDidSelectCity:cityName];
    }
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidChange:(UITextField *)textField {
    
    [self searchCityWithText:textField.text];
}

- (void)searchCityWithText:(NSString *)searchText {
    
    if (searchText.length > 0) {
        _searchResults = [[NSMutableArray alloc] init];
        if ([ChineseInclude isIncludeChineseInString:searchText]) {
            NSArray *allCityName = [CityHelper getAllCityName];
            for (NSString *cityname in allCityName) {
                NSRange result = [cityname rangeOfString:searchText options:NSCaseInsensitiveSearch];
                if (result.length > 0) {
                    [_searchResults addObject:cityname];
                }
            }
        } else {
            NSArray *allCityName = [CityHelper getAllCityName];
            for (NSString *cityname in allCityName) {
                if ([ChineseInclude isIncludeChineseInString:cityname]) {
                    NSString *pinYinHeadString = [PinYinForObjc chineseConvertToPinYinHead:cityname];
                    NSRange result = [pinYinHeadString rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    if (result.length > 0) {
                        [_searchResults addObject:cityname];
                    }
                } else {
                    NSRange result = [cityname rangeOfString:searchText options:NSCaseInsensitiveSearch];
                    if (result.length > 0) {
                        [_searchResults addObject:cityname];
                    }
                }
            }
        }
    }
    
    if (_searchResults.count > 0) {
        _warningView.hidden = YES;
    } else {
        _warningView.hidden = NO;
    }
    
    [_tableView reloadData];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    [_searchTF resignFirstResponder];
}

@end
