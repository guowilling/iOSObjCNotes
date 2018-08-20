
#import <Masonry.h>
#import "TMCreateBillViewController.h"
#import "TMCreateHeaderView.h"
#import "TMCategoryCollectionViewFlowLayout.h"
#import "TMCategotyCollectionViewCell.h"
#import "TMCategory.h"
#import "TMDataBaseManager.h"
#import "CCColorCube.h"
#import "TMCalculatorView.h"
#import "TMBill.h"
#import "TMCategory.h"
#import "SZCalendarPicker.h"
#import "TMRemarkViewController.h"
#import "TMModifyCategoryNameView.h"
#import "TMAddCategoryViewController.h"
#import "NSString+TMNSString.h"

static NSString * const TMCategotyCollectionViewCellID = @"TMCategotyCollectionViewCell";

@interface TMCreateBillViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *incomeBtn;
@property (nonatomic, strong) UIButton *expendBtn;

@property (nonatomic, strong) TMCreateHeaderView *headerView;

@property (nonatomic, strong) UICollectionView *incomeCategoryCollectionView;

@property (nonatomic, strong) UICollectionView *expenCategoryCollectionView1;
@property (nonatomic, strong) UICollectionView *expenCategoryCollectionView2;
@property (nonatomic, strong) UIScrollView     *expendCategoryScrollView;

@property (nonatomic, strong) UIPageControl    *pageController;

@property (nonatomic, strong) NSArray *lastfewExpendCategorys;

@property (nonatomic, strong) UIImageView *selectCategoryImageView;

@property (nonatomic, strong) TMCalculatorView *calculatorView;

@property (nonatomic, strong) TMModifyCategoryNameView *modifyCategoryNameView;
@property (nonatomic, strong) UIView *modifyCategoryContainerView;

@property (nonatomic, strong) NSString *updateTimeStr;
@property (nonatomic, strong) NSString *remarks;
@property (nonatomic, strong) NSData *remarkPhotoData;
@property (nonatomic, strong) TMCategory *selectedCategory;
@property (nonatomic, assign, getter=isIcome) BOOL income;
@property (nonatomic, assign) double money;

@end

@implementation TMCreateBillViewController

#pragma mark - Lazy Load

- (TMCalculatorView *)calculatorView {
    
    if (!_calculatorView) {
        _calculatorView = [[[NSBundle mainBundle] loadNibNamed:@"TMCalculatorView" owner:nil options:nil] lastObject];
        _calculatorView.frame = CGRectMake(0, CGRectGetMaxY(_pageController.frame),
                                           SCREEN_SIZE.width, SCREEN_SIZE.height - CGRectGetMaxY(_pageController.frame));
    }
    return _calculatorView;
}

- (UIButton *)expendBtn {
    
    if (!_expendBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"支出" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:kSelectColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(clickExpendBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        
        _expendBtn = button;
    }
    return _expendBtn;
}

- (UIButton *)incomeBtn {
    
    if (!_incomeBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:@"收入" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:kSelectColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(clickIncomeBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        _incomeBtn = button;
    }
    return _incomeBtn;
}

- (UICollectionView *)expenCategoryCollectionView1 {
    
    if (!_expenCategoryCollectionView1) {
        _expenCategoryCollectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,
                                                                                          SCREEN_SIZE.width, (kCollectionCellWidth+20 + 10) * 4 - 10)
                                                          collectionViewLayout:[[TMCategoryCollectionViewFlowLayout alloc] init]];
        _expenCategoryCollectionView1.delegate = self;
        _expenCategoryCollectionView1.dataSource = self;
        _expenCategoryCollectionView1.backgroundColor = [UIColor whiteColor];
    }
    return _expenCategoryCollectionView1;
}

- (UICollectionView *)expenCategoryCollectionView2 {
    
    if (!_expenCategoryCollectionView2) {
        _expenCategoryCollectionView2 = [[UICollectionView alloc] initWithFrame:CGRectMake(SCREEN_SIZE.width, 0,
                                                                                           SCREEN_SIZE.width, (kCollectionCellWidth+20 + 10) * 4 -10)
                                                           collectionViewLayout:[[TMCategoryCollectionViewFlowLayout alloc] init]];
        _expenCategoryCollectionView2.delegate = self;
        _expenCategoryCollectionView2.dataSource = self;
        _expenCategoryCollectionView2.backgroundColor = [UIColor whiteColor];
    }
    return _expenCategoryCollectionView2;
}

- (UICollectionView *)incomeCategoryCollectionView {
    
    if (!_incomeCategoryCollectionView) {
        _incomeCategoryCollectionView = [[UICollectionView alloc] initWithFrame:kCollectionFrame
                                                           collectionViewLayout:[[TMCategoryCollectionViewFlowLayout alloc] init]];
        _incomeCategoryCollectionView.delegate = self;
        _incomeCategoryCollectionView.dataSource = self;
        _incomeCategoryCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _incomeCategoryCollectionView;
}

- (UIScrollView *)expendCategoryScrollView {
    
    if (!_expendCategoryScrollView) {
        _expendCategoryScrollView = [[UIScrollView alloc] initWithFrame:kCollectionFrame];
        _expendCategoryScrollView.contentSize = CGSizeMake(kCollectionFrame.size.width * 2, kCollectionFrame.size.height);
        _expendCategoryScrollView.delegate = self;
        _expendCategoryScrollView.pagingEnabled = YES;
        _expendCategoryScrollView.showsHorizontalScrollIndicator = NO;
        [_expendCategoryScrollView addSubview:self.expenCategoryCollectionView1];
        [_expendCategoryScrollView addSubview:self.expenCategoryCollectionView2];
    }
    return _expendCategoryScrollView;
}

- (UIPageControl *)pageController {
    
    if (!_pageController) {
        _pageController = [[UIPageControl alloc] initWithFrame:kPageControllerFrame];
        _pageController.numberOfPages = 2;
        _pageController.userInteractionEnabled = NO;
        _pageController.pageIndicatorTintColor = [UIColor colorWithWhite:0.829 alpha:1.000];
        _pageController.currentPageIndicatorTintColor = kSelectColor;
    }
    return _pageController;
}

- (UIImageView *)selectCategoryImageView {
    
    if (!_selectCategoryImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -30, kCollectionCellWidth-20, kCollectionCellWidth-20)];
        imageView.layer.cornerRadius = (kCollectionCellWidth - 20)/2;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        _selectCategoryImageView = imageView;
    }
    return _selectCategoryImageView;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationBar];
    
    WEAKSELF
    
    self.headerView = [[TMCreateHeaderView alloc] initWithFrame:kCreateBillHeaderViewFrame];
    [self.view addSubview:self.headerView];
    self.headerView.clickCategoryName = ^{
         weakSelf.modifyCategoryNameView.category = weakSelf.selectedCategory;
        [weakSelf.view bringSubviewToFront:weakSelf.modifyCategoryContainerView];
        [weakSelf.modifyCategoryNameView becomeFirstResponder];
    };
    
    [self.view addSubview:self.selectCategoryImageView];
    [self.view sendSubviewToBack:self.selectCategoryImageView];
    
    [self.view addSubview:self.incomeCategoryCollectionView];
    [self.view sendSubviewToBack:self.incomeCategoryCollectionView];
    
    UIView *clapboard = [[UIView alloc] initWithFrame:kCollectionFrame];
    clapboard.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:clapboard];
    
    [self.view bringSubviewToFront:self.headerView];
    
    [self.view addSubview:self.expendCategoryScrollView];
    [self.view addSubview:self.pageController];
    
    self.modifyCategoryContainerView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.modifyCategoryContainerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    [self.view addSubview:self.modifyCategoryContainerView];
    
    self.modifyCategoryNameView = [[TMModifyCategoryNameView alloc] initWithFrame:CGRectMake(37.5, 166, 300, 140)];
    self.modifyCategoryNameView.clickSureBtn = ^ {
        if ([weakSelf.modifyCategoryNameView.categoryName isEqualToString:@""] || weakSelf.modifyCategoryNameView.categoryName.length>3) {
            [weakSelf showSVProgressHUD:@"长度错误!"];
        } else {
            [weakSelf.selectedCategory modifyCategoryTitle:weakSelf.modifyCategoryNameView.categoryName];
            [weakSelf.headerView categoryImageWithFileName:weakSelf.selectedCategory.categoryImageFileNmae andCategoryName:weakSelf.selectedCategory.categoryTitle];
            [weakSelf.incomeCategoryCollectionView reloadData];
            [weakSelf.expenCategoryCollectionView1 reloadData];
            [weakSelf.expenCategoryCollectionView2 reloadData];
        }
    };
    [self.modifyCategoryContainerView addSubview:self.modifyCategoryNameView];
    [self.view sendSubviewToBack:self.modifyCategoryContainerView];
    
    [self setupCalculatorView];
    
    [self.incomeCategoryCollectionView registerClass:[TMCategotyCollectionViewCell class] forCellWithReuseIdentifier:TMCategotyCollectionViewCellID];
    [self.expenCategoryCollectionView1 registerClass:[TMCategotyCollectionViewCell class] forCellWithReuseIdentifier:TMCategotyCollectionViewCellID];
    [self.expenCategoryCollectionView2 registerClass:[TMCategotyCollectionViewCell class] forCellWithReuseIdentifier:TMCategotyCollectionViewCellID];
    
    if (!self.isUpdade) {
        [self setupCreateBill];
        return;
    }
    [self setupUpdataBill];
    if (self.bill.isIncome.boolValue) {
        [self updateBillForIncome];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self reloadData];
}

- (void)reloadData {
    
    RLMResults *results = [[TMDataBaseManager defaultManager] queryCategorysWithPaymentType:MoneyTypeExpend];
    
    NSMutableArray *allCategorys = [NSMutableArray array];
    for (TMCategory *category in results) {
        [allCategorys addObject:category];
    }
    NSRange range = NSMakeRange(24, results.count-24);
    self.lastfewExpendCategorys = [allCategorys subarrayWithRange:range];
    [self.incomeCategoryCollectionView reloadData];
    [self.expenCategoryCollectionView2 reloadData];
}

- (void)setupNavigationBar {
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    self.incomeBtn.frame = CGRectMake(0, 0, titleView.bounds.size.width/2, titleView.bounds.size.height);
    self.expendBtn.frame = CGRectMake(titleView.bounds.size.width/2, 0, titleView.bounds.size.width/2, titleView.bounds.size.height);
    [titleView addSubview:self.incomeBtn];
    [titleView addSubview:self.expendBtn];
    self.navigationItem.titleView = titleView;
    
    self.expendBtn.selected = YES;
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [backBtn setImage:[UIImage imageNamed:@"btn_item_close"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)setupCalculatorView {
    
    WEAKSELF
    
    [self.view addSubview:self.calculatorView];
    
    self.calculatorView.passValuesBlock = ^(NSString *string) {
        [weakSelf.headerView updateMoney:string];
        if (!weakSelf.isUpdade) {
            weakSelf.bill.money = @(string.doubleValue);
            return;
        }
        if (string.floatValue > 0.0) {
            weakSelf.money = string.doubleValue;
        }
    };
    
    self.calculatorView.didClickSaveBtnBlock = ^{
        if (!weakSelf.isUpdade) {
            if (weakSelf.bill.money.floatValue <= 0.0) {
                [weakSelf showSVProgressHUD:@"请输入有效金额!"];
                return;
            }
            weakSelf.bill.category = weakSelf.selectedCategory;
            NSString *bookID = [NSString readUserDefaultOfSelectedBookID];
            TMBooks *book = [[TMDataBaseManager defaultManager] queryBooksWithBookID:bookID];
            weakSelf.bill.books = book;
            [[TMDataBaseManager defaultManager] insertWithBill:weakSelf.bill];
            [weakSelf dismiss];
        } else {
            if (weakSelf.money <= 0.0) {
                [weakSelf showSVProgressHUD:@"请输入有效金额!"];
                return;
            }
            [weakSelf updateBill];
            [weakSelf dismiss];
        }
    };
    
    self.calculatorView.didClickDateBtnBlock = ^{
        [weakSelf calendatPicker];
    };
    
    self.calculatorView.didClickRemarkBtnBlock = ^ {
        [weakSelf runInMainQueue:^{
            TMRemarkViewController *remarkVC = [[TMRemarkViewController alloc] init];
            remarkVC.passbackBlock = ^(NSString *remarks,NSData *remarkPhotoData) {
                if (weakSelf.isUpdade) {
                    weakSelf.remarks = remarks;
                    weakSelf.remarkPhotoData = remarkPhotoData;
                } else {
                    weakSelf.bill.reMarks = remarks;
                    weakSelf.bill.remarkPhoto = remarkPhotoData;
                }
            };
            remarkVC.bill = weakSelf.bill;
            UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:remarkVC];
            [weakSelf presentViewController:navC animated:YES completion:nil];
        }];
    };
}

- (void)setupCreateBill {
    
    self.bill = [TMBill new];
    self.bill.dateStr = [NSString currentDateStr];
    self.bill.isIncome = @(NO);
    self.selectedCategory = [[TMDataBaseManager defaultManager] queryCategorysWithPaymentType:MoneyTypeExpend].firstObject;
    [self.headerView categoryImageWithFileName:self.selectedCategory.categoryImageFileNmae andCategoryName:self.selectedCategory.categoryTitle];
    [self.headerView animationWithBgColor:[UIColor colorWithRed:0.485 green:0.686 blue:0.667 alpha:1.000]];
     self.headerView.backgroundColor = [UIColor colorWithRed:0.485 green:0.686 blue:0.667 alpha:1.000];
}

- (void)setupUpdataBill {
    
    [self.headerView categoryImageWithFileName:self.bill.category.categoryImageFileNmae andCategoryName:self.bill.category.categoryTitle];
    
    CCColorCube *imageColor = [[CCColorCube alloc] init];
    NSArray *colors = [imageColor extractColorsFromImage:self.bill.category.categoryImage flags:CCAvoidBlack count:1];
    self.headerView.backgroundColor = colors.firstObject;
    
    [self.headerView updateMoney:[NSString stringWithFormat:@"%@.00", self.bill.money.stringValue]];
    
    NSArray *colorss = [imageColor extractColorsFromImage:self.bill.category.categoryImage flags:CCAvoidBlack count:1];
    [self.headerView animationWithBgColor:colorss.firstObject];
     self.headerView.backgroundColor = colorss.firstObject;
    
    [self.calculatorView setTimeWithTimeString:self.bill.dateStr];
    
    self.money = self.bill.money.doubleValue;
    self.updateTimeStr = self.bill.dateStr;
    self.remarks = self.bill.reMarks;
    self.remarkPhotoData = self.bill.remarkPhoto;
    self.selectedCategory = self.bill.category;
}

- (void)updateBillForIncome {
    
    self.income = YES;
    
    self.incomeBtn.selected = YES;
    
    self.expendBtn.selected = NO;
    
    [self.view bringSubviewToFront:self.incomeCategoryCollectionView];
    [self.view bringSubviewToFront:self.headerView];
    [self.view sendSubviewToBack:self.expendCategoryScrollView];
    
    self.pageController.numberOfPages = 1;
    
    [self.headerView categoryImageWithFileName:self.bill.category.categoryImageFileNmae andCategoryName:self.bill.category.categoryTitle];
    
    CCColorCube *imageColor = [[CCColorCube alloc] init];
    NSArray *colors = [imageColor extractColorsFromImage:self.bill.category.categoryImage flags:CCAvoidBlack count:1];
    [self.headerView animationWithBgColor:colors.firstObject];
    
    [self.incomeCategoryCollectionView reloadData];
}

- (void)updateBill {
    
    [self.bill updateIncome:@(self.isIcome)];
    [self.bill updateMoney:@(self.money)];
    [self.bill updateDateStr:self.updateTimeStr];
    [self.bill updateRemarks:self.remarks];
    [self.bill updateCategory:self.selectedCategory];
    [self.bill updateRemarkPhoto:self.remarkPhotoData];
}

#pragma mark - Actions

- (void)calendatPicker {
    
    SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
    calendarPicker.today = [NSDate date];
    calendarPicker.date = calendarPicker.today;
    calendarPicker.frame = CGRectMake(0, SCREEN_SIZE.height - (self.calculatorView.bounds.size.height + 50),
                                      SCREEN_SIZE.width, self.calculatorView.bounds.size.height + 50);
    WEAKSELF
    calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
        NSString *time = nil;
        if (month < 10) {
            time = [NSString stringWithFormat:@"%li-0%li-%li",year,month,day];
        }
        if (day < 10) {
            time = [NSString stringWithFormat:@"%li-%li-0%li",year,month,day];
        }
        if (month < 10 && day < 10) {
            time = [NSString stringWithFormat:@"%li-0%li-0%li",year,month,day];
        }
        if (weakSelf.isUpdade) {
            weakSelf.updateTimeStr = time;
        } else {
            weakSelf.bill.dateStr = time;
        }
        [weakSelf.calculatorView setTimeWithTimeString:time];
    };
}

- (void)clickIncomeBtn:(UIButton *)sender {
    
    TMCategory *firstIncomeCategory = [[TMDataBaseManager defaultManager] queryCategorysWithPaymentType:MoneyTypeIncome].firstObject;
    self.selectedCategory = firstIncomeCategory;
    if (!self.isUpdade) {
        self.bill.isIncome = @(YES);
    } else {
        self.income = YES;
    }

    sender.selected = YES;
    self.expendBtn.selected = NO;
    [self.view bringSubviewToFront:self.incomeCategoryCollectionView];
    [self.view bringSubviewToFront:self.headerView];
    [self.view sendSubviewToBack:self.expendCategoryScrollView];

    [self.headerView categoryImageWithFileName:firstIncomeCategory.categoryImageFileNmae andCategoryName:firstIncomeCategory.categoryTitle];

    self.pageController.numberOfPages = 1;
    
    CCColorCube *imageColor = [[CCColorCube alloc] init];
    NSArray *colors = [imageColor extractColorsFromImage:firstIncomeCategory.categoryImage flags:CCAvoidBlack count:1];
    [self.headerView animationWithBgColor:colors.firstObject];
    
    [self.incomeCategoryCollectionView reloadData];
}

- (void)clickExpendBtn:(UIButton *)sender {
    
    TMCategory *firstExpendCategory = [[TMDataBaseManager defaultManager] queryCategorysWithPaymentType:MoneyTypeExpend].firstObject;
    self.selectedCategory = firstExpendCategory;
    if (!self.isUpdade) {
        self.selectedCategory = firstExpendCategory;
        self.bill.isIncome = @NO;
    } else {
        self.income = NO;
    }
    
    sender.selected = YES;
    self.incomeBtn.selected = NO;
    [self.view bringSubviewToFront:self.expendCategoryScrollView];
    [self.view bringSubviewToFront:self.headerView];
    [self.view sendSubviewToBack:self.incomeCategoryCollectionView];

    [self.headerView categoryImageWithFileName:firstExpendCategory.categoryImageFileNmae andCategoryName:firstExpendCategory.categoryTitle];

    self.pageController.numberOfPages = 2;
    
    CCColorCube *imageColor = [[CCColorCube alloc] init];
    NSArray *colors = [imageColor extractColorsFromImage:firstExpendCategory.categoryImage flags:CCAvoidBlack count:1];
    [self.headerView animationWithBgColor:colors.firstObject];
    
    [self.expenCategoryCollectionView1 reloadData];
    [self.expenCategoryCollectionView2 reloadData];
}

- (void)dismiss {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == self.incomeCategoryCollectionView) {
        return [[TMDataBaseManager defaultManager] numberOfCategoryCountWithMoneyType:MoneyTypeIncome] + 1;
    } else if (collectionView == self.expenCategoryCollectionView1) {
        return 24;
    }
    return self.lastfewExpendCategorys.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TMCategotyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TMCategotyCollectionViewCellID forIndexPath:indexPath];
    if (collectionView == self.incomeCategoryCollectionView) {
        if (indexPath.row == [[TMDataBaseManager defaultManager] numberOfCategoryCountWithMoneyType:MoneyTypeIncome]) {
            TMCategory *category = [TMCategory new];
            category.categoryImageFileNmae = @"type_add";
            category.categoryTitle = @"编辑";
            cell.categoty = category;
        } else {
            cell.categoty = [[TMDataBaseManager defaultManager] queryCategorysWithPaymentType:MoneyTypeIncome][indexPath.row];
        }
    } else if (collectionView == self.expenCategoryCollectionView1) {
        cell.categoty = [[TMDataBaseManager defaultManager] queryCategorysWithPaymentType:MoneyTypeExpend][indexPath.row];
    } else {
        if (indexPath.row == self.lastfewExpendCategorys.count) {
            TMCategory *category = [TMCategory new];
            category.categoryImageFileNmae = @"type_add";
            category.categoryTitle = @"编辑";
            cell.categoty = category;
        } else {
            cell.categoty = self.lastfewExpendCategorys[indexPath.row];
        }
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TMCategotyCollectionViewCell *cell = nil;
    TMCategory *category = nil;
    if (collectionView == self.incomeCategoryCollectionView) {
        if (indexPath.row == [[TMDataBaseManager defaultManager] numberOfCategoryCountWithMoneyType:MoneyTypeIncome]) {
            [self transitionToAddCategoryViewController:YES];
            return;
        }
        cell = (TMCategotyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        category = [[TMDataBaseManager defaultManager] queryCategorysWithPaymentType:MoneyTypeIncome][indexPath.row];
    } else if (collectionView == self.expenCategoryCollectionView1) {
        cell = (TMCategotyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        category = [[TMDataBaseManager defaultManager] queryCategorysWithPaymentType:MoneyTypeExpend][indexPath.row];
    } else {
        if (indexPath.row == self.lastfewExpendCategorys.count) {
            [self transitionToAddCategoryViewController:NO];
            return;
        }
        cell = (TMCategotyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        category = self.lastfewExpendCategorys[indexPath.row];
    }
    [self animationWithCell:cell];
    
    self.selectedCategory = category;
    
    [self.headerView categoryImageWithFileName:category.categoryImageFileNmae andCategoryName:category.categoryTitle];

    CCColorCube *imageColor = [[CCColorCube alloc] init];
    NSArray *colors = [imageColor extractColorsFromImage:category.categoryImage flags:CCAvoidBlack count:1];
    [self.headerView animationWithBgColor:colors.firstObject];
}

- (void)animationWithCell:(TMCategotyCollectionViewCell *)cell {
    
    self.selectCategoryImageView.image = cell.categoryImageView.image;
    CGPoint center = cell.center;
    
    CGFloat y =  CGRectGetMaxY(cell.frame);
    center.y = kMaxNBY + y + 10;
    self.selectCategoryImageView.center = center;
    
    WEAKSELF
    [UIView animateWithDuration:0.05 animations:^{
        weakSelf.selectCategoryImageView.center = kHeaderCategoryImageCenter;
    } completion:^(BOOL finished) {
        [weakSelf.view sendSubviewToBack:weakSelf.selectCategoryImageView];
    }];
    [self.view bringSubviewToFront:self.selectCategoryImageView];
}

- (void)transitionToAddCategoryViewController:(BOOL)isIncomeCategory {
    
    RLMResults *results = nil;
    if (isIncomeCategory) {
        results = [[TMDataBaseManager defaultManager] queryAddCategorysWithMoneyType:MoneyTypeIncome];
    } else {
        results = [[TMDataBaseManager defaultManager] queryAddCategorysWithMoneyType:MoneyTypeExpend];
    }
    if (results.count==0) {
        [self showSVProgressHUD:@"图标已用完, 快去整理一下你的分类吧."];
        return;
    }
    TMAddCategoryViewController *createBillVC = [[TMAddCategoryViewController alloc] init];
    if (isIncomeCategory) {
        createBillVC.paymentType = MoneyTypeIncome;
    } else {
        createBillVC.paymentType = MoneyTypeExpend;
    }
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionPush;
    animation.subtype = @"fromBottom";
    animation.duration = 0.5;
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:createBillVC];
    navC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:navC animated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGPoint point = scrollView.contentOffset;
    NSInteger index = round(point.x/scrollView.frame.size.width);
    self.pageController.currentPage = index;
}

@end
