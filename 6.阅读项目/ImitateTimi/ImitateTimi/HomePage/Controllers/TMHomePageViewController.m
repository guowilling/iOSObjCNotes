
#import <MMDrawerBarButtonItem.h>
#import <UIViewController+MMDrawerController.h>
#import "TMHomePageViewController.h"
#import "TMDataBaseManager.h"
#import "TMBill.h"
#import "TMCategory.h"
#import "TMTimeLineCell.h"
#import "TMTimeLineMenuView.h"
#import "TMHeaderView.h"
#import "TMCalculatorManager.h"
#import "TMCreateBillViewController.h"
#import "CCColorCube.h"
#import "TMDetailTableViewController.h"
#import "TMPresentedTransition.h"
#import "TMDismissedTransition.h"
#import "TMCategoryButton.h"
#import "NSString+TMNSString.h"
#import "NSArray+TMNSArray.h"

#define kTitleTextFont 14.0f

NSString * const TMHomePageNeedReloadNotifiation = @"homePageNeedReloadNotifiation";

@interface TMHomePageViewController () <UITableViewDelegate, UITableViewDataSource, TMTimeLineCellDelegate, TMTimeLineMenuViewDelegate, TMHeaderViewDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) TMBooks *books;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TMTimeLineMenuView *timeLineMenuView;
@property (nonatomic, strong) TMTimeLineCell *selectedTimeLineCell;

@property (nonatomic, strong) TMHeaderView *headerView;

@property (nonatomic, strong) UIView *dropdownLineView;
@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, assign, getter=isTitleBtnOpened) BOOL titleBtnOpened;
@property (nonatomic, strong) UILabel *newsBooksLabel;

@property (nonatomic, strong) TMBill *selectedBill;
@property (nonatomic, strong) RLMResults *results;
@property (nonatomic, strong) NSMutableArray *bills;
@property (nonatomic, strong) RLMNotificationToken *notificationToken;

@end

@implementation TMHomePageViewController

- (void)dealloc {
    
    NSLog(@"%s", __func__);
    
    [_notificationToken stop];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Lazy Load

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kHeaderViewHeight, SCREEN_SIZE.width, SCREEN_SIZE.height - kHeaderViewHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = LinebgColor;
        _tableView.rowHeight = 64.0;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (UILabel *)newsBooksLabel {
    
    if (!_newsBooksLabel) {
        _newsBooksLabel = [UILabel new];
        _newsBooksLabel.text = @"新账本";
        _newsBooksLabel.textColor = LineColor;
        _newsBooksLabel.font = [UIFont systemFontOfSize:20.0f];
    }
    return _newsBooksLabel;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _books = [[TMDataBaseManager defaultManager] queryBooksWithBookID:[NSString readUserDefaultOfSelectedBookID]];
    
    [self setupTimeLineMenuView];
    
    [self setupDropdownLineView];
    
    [self setupHeaderView];
    
    [self setupTableView];
    
    WEAKSELF
    _notificationToken = [[TMBill allObjects] addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
        [weakSelf.headerView calculateMoney];
        [weakSelf loadPieView];
        [weakSelf loadBillData];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homePageNeedReload) name:TMHomePageNeedReloadNotifiation object:nil];
}

- (void)setupTimeLineMenuView {
    
    self.timeLineMenuView = [[TMTimeLineMenuView alloc] initWithFrame:self.view.frame];
    self.timeLineMenuView.timeLineMenuDelegate = self;
    [self.view addSubview:self.timeLineMenuView];
}

- (void)setupDropdownLineView {
    
    self.dropdownLineView = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_SIZE.width-1)/2, 0 , 1, 0)];
    self.dropdownLineView.backgroundColor = LineColor;
    [self.tableView addSubview:self.dropdownLineView];
    [self.tableView sendSubviewToBack:self.dropdownLineView];
}

- (void)setupHeaderView {
    
    WEAKSELF
    
    self.headerView = [[TMHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, kHeaderViewHeight)];
    self.headerView.backgroundColor = LinebgColor;
    self.headerView.headerViewDelegate = self;
    [self.view addSubview:self.headerView];
    
    UIButton *menuBtn = [UIButton new];
    [menuBtn setImage:[UIImage imageNamed:@"btn_menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:menuBtn];
    [menuBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(40, 40));
        make.left.equalTo(10);
        make.top.equalTo(25);
    }];
    
    UIButton *titleBtn = [UIButton new];
    titleBtn.alpha = 0.7;
    titleBtn.layer.cornerRadius = 25/2;
    titleBtn.layer.borderWidth = 1.5;
    titleBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:kTitleTextFont];
    [titleBtn setBackgroundColor:[UIColor colorWithWhite:0.278 alpha:0.500]];
    [titleBtn setTitle:_books.bookName forState:UIControlStateNormal];
    [titleBtn setTintColor:[UIColor whiteColor]];
    [titleBtn addTarget:self action:@selector(titleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:titleBtn];
    _titleBtn = titleBtn;
    [titleBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo([weakSelf titleBtnSizeWithTitle:weakSelf.books.bookName]);
        make.centerX.equalTo(weakSelf.headerView);
        make.centerY.equalTo(menuBtn);
    }];
    
    UIButton *cameraBtn = [UIButton new];
    [cameraBtn setImage:[UIImage imageNamed:@"btn_camera"] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(cameraBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:cameraBtn];
    [cameraBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(menuBtn);
        make.centerY.equalTo(menuBtn);
        make.right.equalTo(-10);
    }];
    
    [self.headerView calculateMoney];
}

- (void)setupTableView {
    
    WEAKSELF
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[TMTimeLineCell class] forCellReuseIdentifier:timeLineCellID];
    
    [self.tableView addSubview:self.newsBooksLabel];
    [self.tableView sendSubviewToBack:self.newsBooksLabel];
    [self.newsBooksLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.tableView).offset(30);
    }];
}

#pragma mark - Notification

- (void)homePageNeedReload {
    
    [self.headerView calculateMoney];
    [self loadPieView];
    [self loadBillData];
  
    _books = [[TMDataBaseManager defaultManager] queryBooksWithBookID:[NSString readUserDefaultOfSelectedBookID]];
  
    [_titleBtn setTitle:_books.bookName forState:UIControlStateNormal];
   
    CGFloat width = [self titleBtnSizeWithTitle:_books.bookName].width;
    [_titleBtn updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(width);
    }];
}

- (void)loadBillData {
    
    self.bills = [NSMutableArray array];
    self.results = [[TMDataBaseManager defaultManager] queryAllBillsWithBookID:[NSString readUserDefaultOfSelectedBookID]];
    if (self.results.count == 0) {
        [self.tableView bringSubviewToFront:self.newsBooksLabel];
        TMBill *bill = [TMBill new];
        bill.dateStr = [NSString currentDateStr];
        bill.empty = YES;
        [self.bills addObject:bill];
        [self.tableView reloadData];
        return;
    }
    
    [self.tableView sendSubviewToBack:self.newsBooksLabel];
    NSMutableArray *arrayM = [[NSMutableArray alloc] init];
    for (TMBill *bill in self.results) {
        [arrayM addObject:bill];
    }
    NSArray *sortedArray = [NSArray accordingToDateStrSortArray:arrayM ascending:NO];
    NSString *previousDateStr;
    for (NSInteger i = 0; i < sortedArray.count; i++) {
        TMBill *bill = sortedArray[i];
        if (i == 0) {
            [self.bills addObject:bill];
            previousDateStr = bill.dateStr;
        } else {
            TMBill *aBill = [TMBill new];
            if ([previousDateStr isEqualToString:bill.dateStr]) {
                aBill = bill;
                aBill.same = YES;
                [self.bills addObject:aBill];
            } else {
                [self.bills addObject:bill];
            }
            previousDateStr = bill.dateStr;
        }
    }
    [self.tableView reloadData];
}

- (void)loadPieView {
    
    NSDictionary *pieData = [[TMDataBaseManager defaultManager] queryPieDataWithBookID:[NSString readUserDefaultOfSelectedBookID]
                                                                             dateSting:@"ALL"
                                                                             moneyType:MoneyTypeAll];
    NSArray *allValues = pieData.allValues;
    NSMutableArray *sections = [NSMutableArray array];
    NSMutableArray *sectionColors = [NSMutableArray array];
    WEAKSELF
    [self runInGlobalQueue:^{
        [allValues enumerateObjectsUsingBlock:^(TMBill *bill, NSUInteger idx, BOOL * _Nonnull stop) {
            [sections addObject:bill.money];
            CCColorCube *colorCube = [[CCColorCube alloc] init];
            NSArray *colors = [colorCube extractColorsFromImage:bill.category.categoryImage flags:CCAvoidBlack count:1];
            [sectionColors addObject:colors.firstObject];
        }];
        if (sections.count == 0) {
            [sections addObject:@100];
            [sectionColors addObject:LineColor];
        }
        [weakSelf runInMainQueue:^{
            [weakSelf.headerView loadPieViewWithSection:sections colors:sectionColors];
        }];
    }];
}

#pragma mark - Actions

- (void)menuBtnAction:(UIButton *)sender {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)cameraBtnAction:(UIButton *)sender {
    
    NSLog(@"click CameraBtn");
}

- (void)titleBtnAction:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3f delay:0.2f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.titleBtn setBackgroundColor:[UIColor colorWithRed:1.000 green:0.812 blue:0.124 alpha:1.000]];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.titleBtn setBackgroundColor:[UIColor colorWithWhite:0.278 alpha:0.500]];
        } completion:nil];
    }];
    
    NSString *titleString = nil;
    if (!self.isTitleBtnOpened) {
        self.titleBtnOpened = YES;
        titleString = [NSString stringWithFormat:@"余额 %.2f", [TMCalculatorManager queryBalanceOfAllBillsWithBookID:[NSString readUserDefaultOfSelectedBookID]]];
        CGFloat width = [self titleBtnSizeWithTitle:titleString].width;
        [self.titleBtn updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(width);
        }];
    } else {
        self.titleBtnOpened = NO;
        CGFloat width = [self titleBtnSizeWithTitle:self.books.bookName].width;
        [self.titleBtn updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(width);
        }];
        titleString = _books.bookName;
    }
    [self.titleBtn setTitle:titleString forState:UIControlStateNormal];
}

- (CGSize)titleBtnSizeWithTitle:(NSString *)title {
    
    CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kTitleTextFont]}].width + 20;
    return CGSizeMake(width, 25);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.bills.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TMTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:timeLineCellID forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    if (indexPath.row == self.bills.count - 1) {
        cell.isLastBill = YES;
    }
    TMBill *bill = self.bills[indexPath.row];
    cell.timeLineBill = bill ;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TMBill *bill = self.bills[indexPath.row];
    if (bill.isEmpty) {
        return;
    }
    TMDetailTableViewController *detailVC = [[TMDetailTableViewController alloc] init];
    detailVC.currentIndex = indexPath.row;
    [self presentViewController:detailVC animated:YES completion:nil];
}

#pragma mark - TMTimeLineCellDelegate

- (void)didClickCategoryBtnWithIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedBill = self.bills[indexPath.row];
    if (self.selectedBill.isEmpty) {
        return;
    }
    self.selectedTimeLineCell = [self.tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = [self.tableView rectForRowAtIndexPath:indexPath];
    CGRect rectInSuperview = [self.tableView convertRect:rect toView:self.tableView.superview];
    self.timeLineMenuView.currentImage = self.selectedTimeLineCell.categoryImageBtn.currentImage;
    [self.timeLineMenuView showTimeLineMenuViewWithRect:rectInSuperview ];
}

#pragma mark - TMTimeLineMenuViewDelegate

- (void)hiddenCellLabelWithBool:(BOOL)hidden {
    
    [self.selectedTimeLineCell cellLabelWithHidden:hidden];
}

- (void)clickDeleteBtn {
    
    [self.timeLineMenuView dismiss];
    
    WEAKSELF
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                             message:@"您是否确定要删除所选账目?"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                         }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [[TMDataBaseManager defaultManager] deleteWithBill:weakSelf.selectedBill];
                                                       }];
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)clickUpdateBtn {
    
    TMCreateBillViewController *createBillVC = [TMCreateBillViewController new];
    createBillVC.update = YES;
    createBillVC.bill = self.selectedBill;
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:createBillVC];
    navC.transitioningDelegate = self;
    WEAKSELF
    [self presentViewController:navC animated:YES completion:^{
        [weakSelf.timeLineMenuView dismiss];
    }];
}

#pragma mark - TMHeaderViewDelegate

- (void)didClickPieInCreateBtn {

    TMCreateBillViewController *createBillVC = [[TMCreateBillViewController alloc] init];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:createBillVC];
    navC.transitioningDelegate = self;
    [self presentViewController:navC animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [TMPresentedTransition new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [TMDismissedTransition new];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat y = [scrollView.panGestureRecognizer translationInView:self.tableView].y;
    if (y <= 0) {
        return;
    }
    self.dropdownLineView.frame = CGRectMake((SCREEN_SIZE.width-1)/2, -y, 1, y);
    [self.tableView bringSubviewToFront:self.dropdownLineView];
    [self.headerView animationWithCreateBtnDuration:1.0f angle:y];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY < -60) {
        [self didClickPieInCreateBtn];
    }
}

@end
