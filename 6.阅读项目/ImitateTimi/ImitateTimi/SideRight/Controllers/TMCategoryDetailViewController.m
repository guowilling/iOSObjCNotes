
#import <UIViewController+MMDrawerController.h>
#import "TMCategoryDetailViewController.h"
#import "TMCategoryDetailCell.h"
#import "TMBill.h"
#import "TMCategory.h"
#import "NSArray+TMNSArray.h"
#import "NSString+TMNSString.h"

#define kAttributedStringColor [UIColor colorWithWhite:0.395 alpha:1.000]

@interface TMCategoryDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *headerContainerView;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIImageView *categoryImageView;
@property (nonatomic, strong) UILabel *categoryNameLabel;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *verticalLineView;

@property (nonatomic, strong) RLMResults *results;
@property (nonatomic, strong) NSMutableArray *bills;

@end

@implementation TMCategoryDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupHeaderView];
    
    [self setupTableView];
    
    [self setupVerticalLineView];
    
    [self setupUIData];
    
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 50, 50)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"button_edge"] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithWhite:0.575 alpha:1.000] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)setupHeaderView {
    
    WEAKSELF
    self.headerContainerView = [UIView new];
    [self.view addSubview:self.headerContainerView];
    [self.headerContainerView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(weakSelf.view);
        make.height.equalTo(weakSelf.view).multipliedBy(0.25);
    }];
    
    self.grayView = [UIView new];
    self.grayView.backgroundColor = [UIColor colorWithWhite:0.880 alpha:1.000];
    [self.headerContainerView addSubview:self.grayView];
    [self.grayView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(weakSelf.headerContainerView);
        make.height.equalTo(weakSelf.headerContainerView).multipliedBy(0.7);
    }];
    
    self.countLabel = [UILabel new];
    [self.grayView addSubview:self.countLabel];
    [self.countLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.grayView).offset(18);
        make.bottom.equalTo(weakSelf.grayView).offset(-5);
    }];
    
    self.moneyLabel  = [UILabel new];
    self.moneyLabel.font = [UIFont systemFontOfSize:20];
    self.moneyLabel.textColor = [UIColor colorWithWhite:0.190 alpha:1.000];
    [self.grayView addSubview:self.moneyLabel];
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.grayView).offset(-5);
        make.bottom.equalTo(weakSelf.countLabel);
    }];
    
    self.categoryImageView = [UIImageView new];
    [self.grayView addSubview:self.categoryImageView];
    [self.categoryImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.grayView);
        make.centerY.equalTo(weakSelf.grayView.bottom);
        make.size.equalTo(CGSizeMake(40, 40));
    }];
    
    self.categoryNameLabel = [UILabel new];
    self.categoryNameLabel.font = [UIFont systemFontOfSize:15.0];
    [self.headerContainerView addSubview:self.categoryNameLabel];
    [self.categoryNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.headerContainerView);
        make.bottom.equalTo(weakSelf.headerContainerView).offset(-5);
    }];
}

- (void)setupTableView {
    
    WEAKSELF
    self.tableView = [[UITableView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = 55;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[TMCategoryDetailCell class] forCellReuseIdentifier:TMCategoryDetailCellID];
    [self.view addSubview:self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerContainerView.bottom);
        make.left.right.bottom.equalTo(weakSelf.view);
    }];
}

- (void)setupVerticalLineView {
    
    WEAKSELF
    self.verticalLineView = [UIView new];
    self.verticalLineView.backgroundColor = LineColor;
    [self.view addSubview:self.verticalLineView];
    [self.verticalLineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerContainerView.bottom);
        make.width.equalTo(1);
        make.centerX.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
    }];
}

- (void)setupUIData {
    
    self.results = [[TMDataBaseManager defaultManager] queryBillWithBookID:[NSString readUserDefaultOfSelectedBookID]
                                                        beginsWithContains:self.dateString
                                                             categoryTitle:self.categoryName];
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%li",self.results.count]
                                                                                attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20.0],
                                                                                             NSForegroundColorAttributeName: kAttributedStringColor}];
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@" 笔"
                                                                                attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10.0],
                                                                                             NSForegroundColorAttributeName: kAttributedStringColor}];
    [string1 appendAttributedString:string2];
    self.countLabel.attributedText = string1;
    if (self.results.count == 0) {
        self.moneyLabel.text = @"0.00";
        self.categoryNameLabel.text = self.categoryName;
        if (self.type == MoneyTypeIncome) {
            self.categoryImageView.image = [UIImage imageNamed:@"type_big_0"];
        } else {
            self.categoryImageView.image = [UIImage imageNamed:@"type_big_1"];
        }
        return;
    }
    TMBill *bill = self.results.firstObject;
    self.categoryImageView.image = bill.category.categoryImage;
    self.categoryNameLabel.text = bill.category.categoryTitle;
    float money = [TMCalculatorManager queryAllMoneyWithCategotyTitleOfBookID:[NSString readUserDefaultOfSelectedBookID]
                                                                categoryTitle:self.categoryName
                                                                      dateStr:self.dateString];
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",money];
    [self resetBill];
}

- (void)resetBill {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (TMBill *bill in self.results) {
        [array addObject:bill];
    }
    NSArray *receives = [NSArray accordingToDateStrSortArray:array ascending:NO];
    self.bills = [NSMutableArray array];
    NSString *previous;
    for (NSInteger i=0; i<receives.count; i++) {
        TMBill *bill = receives[i];
        if (i == 0) {
            [self.bills addObject:bill];
            previous = bill.dateStr;
            continue;
        }
        TMBill *theBill = [TMBill new];
        if ([previous isEqualToString:bill.dateStr]) {
            theBill = bill;
            theBill.same = YES;
            [self.bills addObject:theBill];
        } else if ([[previous substringToIndex:7] isEqualToString:[bill.dateStr substringToIndex:7]]) {
            theBill = bill;
            theBill.partSame = YES;
            [self.bills addObject:theBill];
        } else {
            [self.bills addObject:bill];
        }
        previous = bill.dateStr;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.bills.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TMCategoryDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:TMCategoryDetailCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TMBill *bill = self.bills[indexPath.row];
    cell.bill = bill;
    return cell;
}

- (void)backBtnAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
