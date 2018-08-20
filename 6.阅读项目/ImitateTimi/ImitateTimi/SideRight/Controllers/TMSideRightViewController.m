
#import "TMSideRightViewController.h"
#import "iCarousel.h"
#import "TMDataBaseManager.h"
#import "TMLabel.h"
#import "TMCalculatorManager.h"
#import "TMPieView.h"
#import "TMBill.h"
#import "TMCategory.h"
#import "CCColorCube.h"
#import "TMCategoryDetailViewController.h"
#import "NSArray+TMNSArray.h"
#import "NSString+TMNSString.h"

#define kNameFont       15
#define kMoneyFont      12
#define kICarViewHeight 60

@interface TMSideRightViewController () <iCarouselDelegate, iCarouselDataSource>

@property (nonatomic, strong) UILabel *leftItemLabel;
@property (nonatomic, strong) UILabel *rightItemLabel;

@property (nonatomic, copy) NSMutableAttributedString *leftAttributedString;
@property (nonatomic, copy) NSMutableAttributedString *leftAttributedString2;
@property (nonatomic, copy) NSMutableAttributedString *rightAttributedString;
@property (nonatomic, copy) NSMutableAttributedString *rightAttributedString2;

/** 月份数据源 */
@property (nonatomic, strong) NSArray *items;
/** 上选择的索引 iCar */
@property (nonatomic, assign) NSInteger prevoiusIndex;

/** 年份 */
@property (nonatomic, strong) TMLabel *yearLabel;

@property (nonatomic, strong) iCarousel *iCar;

/** 排序之后的key */
@property (nonatomic, strong) NSArray *sortDicKeys;

/** key:time value:月份 */
@property (nonatomic, strong) NSMutableDictionary *dic;

@property (nonatomic, strong) TMPieView *pieView;
@property (nonatomic, strong) NSDictionary *pieDic;

@property (nonatomic, assign,getter=isSelectedExpend) BOOL selectedExpend;

@property (nonatomic, copy) NSString *currentDateString;

@property (nonatomic, strong) UILabel *categoryTitleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UIView  *redLineView;

@property (nonatomic, strong) UIButton *categoryBtn;
@property (nonatomic, strong) UILabel  *percentLabel;
@property (nonatomic, strong) UILabel  *countLabel;

@property (nonatomic, strong) UIButton *rotateBtn;

@property (nonatomic, assign) NSInteger currentIndex;

/** 上一次选择 pieView 的索引 */
@property (nonatomic, assign) NSInteger previousSelectedOfPieViewIndex;

/** 第一次取得 max percent */
@property (nonatomic, assign,getter=isFirst) BOOL first;

/** 上一次的 ALL TMBill Count */
@property (nonatomic, assign) NSInteger previousCount;

/** 上一次选择的账本ID */
@property (nonatomic, strong) NSString *previousBookID;

@end

@implementation TMSideRightViewController

#pragma mark - Lazy Load

- (NSMutableAttributedString *)leftAttributedString {
    
    if (!_leftAttributedString) {
        _leftAttributedString = [[NSMutableAttributedString alloc] initWithString:@"总收入"
                                                                       attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kNameFont],
                                                                                    NSForegroundColorAttributeName: [UIColor blackColor]}];
    }
    return _leftAttributedString;
}

- (NSMutableAttributedString *)leftAttributedString2 {
    
    if (!_leftAttributedString2) {
        float money = [TMCalculatorManager queryAllIncomeOrExpendOfBookID:[NSString readUserDefaultOfSelectedBookID] moneyType:MoneyTypeIncome];
        _leftAttributedString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%.2f",money]
                                                                        attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kMoneyFont],
                                                                                     NSForegroundColorAttributeName: kSelectColor}];
    }
    return _leftAttributedString2;
}

- (NSMutableAttributedString *)rightAttributedString {
    
    if (!_rightAttributedString) {
        _rightAttributedString = [[NSMutableAttributedString alloc] initWithString:@"总支出"
                                                                        attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kNameFont],
                                                                                     NSForegroundColorAttributeName: [UIColor blackColor]}];
    }
    return _rightAttributedString;
}

- (NSMutableAttributedString *)rightAttributedString2 {
    
    if (!_rightAttributedString2) {
        float money = [TMCalculatorManager queryAllIncomeOrExpendOfBookID:[NSString readUserDefaultOfSelectedBookID] moneyType:MoneyTypeExpend];
        _rightAttributedString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n%.2f",money]
                                                                         attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kMoneyFont],
                                                                                      NSForegroundColorAttributeName: kSelectColor} ];
    }
    return _rightAttributedString2;
}

- (NSArray *)items {
    
    if (!_items) {
        _items = @[@"JAN\n1月", @"FEB\n2月", @"MAR\n3月",
                   @"APR\n4月", @"MAY\n5月", @"JUN\n6月",
                   @"JUL\n7月", @"AUG\n8月", @"SEP\n9月", @"OCT\n10月", @"NOV\n11月", @"DEC\n12月", @"ALL\n全部"];
    }
    return _items;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.dic = [NSMutableDictionary dictionary];
    self.pieDic = [NSDictionary dictionary];
    self.selectedExpend = YES;
    self.first = YES;
    self.currentDateString = @"ALL";
    self.previousSelectedOfPieViewIndex = -1;

    self.previousBookID = [NSString readUserDefaultOfSelectedBookID];
    
    self.previousCount = [[TMDataBaseManager defaultManager] numberOfAllBillCountWithBookID:[NSString readUserDefaultOfSelectedBookID]];
    
    NSDictionary *dic = [[TMDataBaseManager defaultManager] queryAllBillsNoneRepeatWithBookID:[NSString readUserDefaultOfSelectedBookID]];
    [self filterMonthWithDateArray:dic.allKeys];

    [self setupLeftItemLabel];
    
    [self setupRightItemLabel];
    
    [self setupICarousel];
    
    [self setupYearLabel];
    
    [self setupCategoryTitleLabel];
    
    [self setupMoneyLabel];
    
    [self setupRedLineView];
    
    [self setupPieView];
    
    [self setupCategoryBtn];
    
    [self setupPercentLabel];
    
    [self setupCountLabel];
    
    [self setupRotateBtn];
    
    [self tapRightItemLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    if ([[TMDataBaseManager defaultManager] numberOfAllBillCountWithBookID:[NSString readUserDefaultOfSelectedBookID]] != self.previousCount ||
        ![[NSString readUserDefaultOfSelectedBookID] isEqualToString:self.previousBookID]) {
 
        self.previousCount = [[TMDataBaseManager defaultManager] numberOfAllBillCountWithBookID:[NSString readUserDefaultOfSelectedBookID]];
        self.previousBookID = [NSString readUserDefaultOfSelectedBookID];
        [self tapRightItemLabel];
        [self.dic removeAllObjects];
        NSDictionary *dic = [[TMDataBaseManager defaultManager] queryAllBillsNoneRepeatWithBookID:[NSString readUserDefaultOfSelectedBookID]];
        [self filterMonthWithDateArray:dic.allKeys];
        [self.iCar scrollToItemAtIndex:self.sortDicKeys.count animated:NO];
      
        float expendMoney = [TMCalculatorManager queryAllIncomeOrExpendOfBookID:[NSString readUserDefaultOfSelectedBookID]
                                                                      moneyType:MoneyTypeExpend];
        [self updateMoneyWithAttributedString:self.rightAttributedString
                              withMoneyString:[NSString stringWithFormat:@"%.2f", expendMoney]
                                       toView:self.rightItemLabel];
    
        float incomeMoney = [TMCalculatorManager queryAllIncomeOrExpendOfBookID:[NSString readUserDefaultOfSelectedBookID]
                                                                      moneyType:MoneyTypeIncome];
        [self updateMoneyWithAttributedString:self.leftAttributedString
                              withMoneyString:[NSString stringWithFormat:@"%.2f", incomeMoney]
                                       toView:self.leftItemLabel];
    }
}

- (void)setupLeftItemLabel {
    
    [self.leftAttributedString appendAttributedString:self.leftAttributedString2];
    self.leftItemLabel = [UILabel new];
    self.leftItemLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *leftTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLeftItemLabel)];
    [self.leftItemLabel addGestureRecognizer:leftTapGR];
    self.leftItemLabel.numberOfLines = 2;
    self.leftItemLabel.attributedText = self.leftAttributedString;
    [self.view addSubview:self.leftItemLabel];
    [self.leftItemLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(25);
    }];
}

- (void)setupRightItemLabel {
    
    WEAKSELF
    [self.rightAttributedString appendAttributedString:self.rightAttributedString2];
    self.rightItemLabel = [UILabel new];
    self.rightItemLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *rightTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRightItemLabel)];
    [self.rightItemLabel addGestureRecognizer:rightTapGR];
    self.rightItemLabel.numberOfLines = 2;
    self.rightItemLabel.textAlignment = NSTextAlignmentRight;
    self.rightItemLabel.attributedText = self.rightAttributedString;
    [self.view addSubview:self.rightItemLabel];
    [self.rightItemLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.centerY.equalTo(weakSelf.leftItemLabel);
    }];
}

- (void)setupICarousel {
    
    WEAKSELF
    iCarousel *iCar = [iCarousel new];
    iCar.layer.borderWidth = 0.5;
    iCar.layer.borderColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0].CGColor;
    iCar.type = iCarouselTypeLinear;
    iCar.delegate = self;
    iCar.dataSource = self;
    iCar.pagingEnabled = YES;
    iCar.bounces = YES;
    iCar.bounceDistance = 1.0f;
    [iCar scrollToItemAtIndex:self.sortDicKeys.count animated:NO];
    [self.view addSubview:iCar];
    [iCar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.leftItemLabel.bottom).offset(10);
        make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, kICarViewHeight));
    }];
    self.iCar = iCar;
}

- (void)setupYearLabel {
    
    WEAKSELF
    self.yearLabel = [TMLabel new];
    [self.view addSubview:self.yearLabel];
    [self.yearLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.iCar.bottom);
        make.centerX.equalTo(weakSelf.view);
    }];
    [self updateYearLabel];
    self.yearLabel.textColor = LineColor;
    self.yearLabel.textAlignment = NSTextAlignmentCenter;
    self.yearLabel.backgroundColor = [UIColor whiteColor];
    self.yearLabel.font = [UIFont systemFontOfSize:12.0f];
}

- (void)setupCategoryTitleLabel {
    
    WEAKSELF
    self.categoryTitleLabel = [UILabel new];
    self.categoryTitleLabel.numberOfLines = 2;
    self.categoryTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.categoryTitleLabel];
    [self.categoryTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.yearLabel.bottom).offset(30);
    }];
    self.categoryTitleLabel.text = @"网购";
}

- (void)setupMoneyLabel {
    
    WEAKSELF
    self.moneyLabel = [UILabel new];
    [self.view addSubview:self.moneyLabel];
    [self.moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.categoryTitleLabel.bottom).offset(5);
    }];
    self.moneyLabel.text = @"123456789.00";
    self.moneyLabel.textColor = LineColor;
}

- (void)setupRedLineView {
    
    WEAKSELF
    self.redLineView = [UIView new];
    self.redLineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.redLineView];
    [self.redLineView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(1);
        make.top.equalTo(weakSelf.moneyLabel.bottom).offset(5);
        make.height.equalTo(20);
        make.centerX.equalTo(weakSelf.view);
    }];
}

- (void)setupPieView {
    
    WEAKSELF
    self.pieView = [TMPieView new];
    self.pieView.lineWidth = 30;
    self.pieView.animationStrokeColor = LineColor;
    self.pieView.layer.cornerRadius = 200/2;
    self.pieView.layer.masksToBounds = YES;
    [self.view addSubview:self.pieView];
    [self.pieView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(200, 200));
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.redLineView.bottom).offset(5);
    }];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPieView:)];
    [self.pieView addGestureRecognizer:tapGR];
}

- (void)setupCategoryBtn {
    
    WEAKSELF
    self.categoryBtn = [UIButton new];
    [self.categoryBtn setImage:[UIImage imageNamed:@"type_big_1"] forState:UIControlStateNormal];
    [self.categoryBtn addTarget:self action:@selector(clickCategoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.categoryBtn];
    [self.categoryBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(97/2.5, 97/2.5));
        make.centerX.equalTo(weakSelf.view);
        make.centerY.equalTo(weakSelf.pieView);
    }];
}

- (void)setupPercentLabel {
    
    WEAKSELF
    self.percentLabel = [UILabel new];
    self.percentLabel.text = @"88%";
    [self.view addSubview:self.percentLabel];
    [self.percentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.categoryBtn.bottom).offset(5);
    }];
}

- (void)setupCountLabel {
    
    WEAKSELF
    self.countLabel = [UILabel new];
    self.countLabel.text = @"1笔";
    self.countLabel.textColor = [UIColor colorWithWhite:0.729 alpha:1.000];
    [self.view addSubview:self.countLabel];
    [self.countLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.pieView.bottom).offset(20);
        make.centerX.equalTo(weakSelf.view);
    }];
}

- (void)setupRotateBtn {
    
    WEAKSELF
    self.rotateBtn = [UIButton new];
    [self.rotateBtn setImage:[UIImage imageNamed:@"btn_pieChart_rotation"] forState:UIControlStateNormal];
    [self.rotateBtn addTarget:self action:@selector(clickRotateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rotateBtn];
    [self.rotateBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(self.countLabel.bottom).offset(10);
        make.size.equalTo(CGSizeMake(40, 40));
    }];
}

#pragma mark - Actions

- (void)tapLeftItemLabel {
    
    self.first = YES;
    self.selectedExpend = NO;
    
    [self updateColorWithAttributedString:self.leftAttributedString titleColor:kSelectColor moneyColor:kSelectColor toView:self.leftItemLabel];
    [self updateColorWithAttributedString:self.rightAttributedString titleColor:[UIColor blackColor] moneyColor:LineColor toView:self.rightItemLabel];
 
    self.pieDic = [[TMDataBaseManager defaultManager] queryPieDataWithBookID:[NSString readUserDefaultOfSelectedBookID]
                                                                   dateSting:self.currentDateString
                                                                    moneyType:MoneyTypeIncome];
    [self reloadPieSectionAndSectionColorsWithDictionary:self.pieDic];
}

- (void)tapRightItemLabel {
    
    self.first = YES;
    self.selectedExpend = YES;
    
    [self updateColorWithAttributedString:self.rightAttributedString titleColor:kSelectColor moneyColor:kSelectColor toView:self.rightItemLabel];
    [self updateColorWithAttributedString:self.leftAttributedString titleColor:[UIColor blackColor] moneyColor:LineColor toView:self.leftItemLabel];

    self.pieDic = [[TMDataBaseManager defaultManager] queryPieDataWithBookID:[NSString readUserDefaultOfSelectedBookID]
                                                                   dateSting:self.currentDateString
                                                                   moneyType:MoneyTypeExpend];
    [self reloadPieSectionAndSectionColorsWithDictionary:self.pieDic];
}

- (void)clickCategoryBtn:(UIButton *)sender {
    
    TMCategoryDetailViewController *piewDetailVC = [TMCategoryDetailViewController new];
    piewDetailVC.categoryName = self.categoryTitleLabel.text;
    piewDetailVC.dateString = self.currentDateString;
    piewDetailVC.type = self.isSelectedExpend ? MoneyTypeExpend : MoneyTypeIncome;
    [self presentViewController:piewDetailVC animated:YES completion:nil];
}

- (void)clickRotateBtn:(UIButton *)sender {
    
    self.currentIndex = self.previousSelectedOfPieViewIndex + 1;
    NSArray *allKeys = self.pieDic.allKeys;
    if (self.currentIndex>allKeys.count-1) {
        self.currentIndex=0;
    }
    CGFloat angle = [self getRotatingAngleWithLayerIndex:self.currentIndex];
    [self rotateAnimationByAngle:angle];
}

- (void)tapPieView:(UITapGestureRecognizer *)tap {
    CGPoint point = [tap locationInView:tap.view];
    self.currentIndex = [self.pieView getLayerIndexWithPoint:point];
    if (self.currentIndex<0 || self.currentIndex>self.pieDic.allKeys.count-1) {
        return;
    }
    CGFloat angle = [self getTapRotatingAngleWithLayerIndex:self.currentIndex];
    [self rotateAnimationByAngle:angle];
}

#pragma mark - Assist Methods

- (void)reloadPieSectionAndSectionColorsWithDictionary:(NSDictionary *)dic {
    
    self.pieView.transform = CGAffineTransformIdentity;
    
    NSArray *allValues = dic.allValues;
    NSMutableArray *sections = [NSMutableArray array];
    NSMutableArray *sectionColors = [NSMutableArray array];
    [allValues enumerateObjectsUsingBlock:^(TMBill *bill, NSUInteger idx, BOOL * _Nonnull stop) {
        [sections addObject:bill.money];
        CCColorCube *imageColor = [[CCColorCube alloc] init];
        NSArray *colors = [imageColor extractColorsFromImage:bill.category.categoryImage flags:CCAvoidBlack count:1];
        [sectionColors addObject:colors.firstObject];
    }];
    if (sections.count==0) {
        [sections addObject:@100];
        [sectionColors addObject:LineColor];
    }
    self.pieView.sections = sections;
    self.pieView.sectionColors = sectionColors;
    WEAKSELF
    [self.pieView reloadDataCompletion:^{
        weakSelf.currentIndex = [weakSelf getCurrentIndexWithDictionary:weakSelf.pieDic];
        CGFloat angle = [weakSelf getRotatingAngleWithLayerIndex:weakSelf.currentIndex];
        [weakSelf rotateAnimationByAngle:angle];
    }];
}

- (NSInteger)getCurrentIndexWithDictionary:(NSDictionary *)pieDic {
    
    NSArray *allKeys = pieDic.allKeys;
    TMBill *firstBill = pieDic[allKeys.firstObject];
    float maxBill = firstBill.category.percent;
    NSInteger index = 0;
    for (NSInteger i=1; i<pieDic.allValues.count; i++) {
        NSString *key = allKeys[i];
        TMBill *bill = pieDic[key];
        if (maxBill < bill.category.percent) {
            maxBill = bill.category.percent;
            index = i;
        }
    }
    return index;
}

- (CGFloat )getRotatingAngleWithLayerIndex:(NSInteger )layerIndex {
    
    if (layerIndex == self.previousSelectedOfPieViewIndex) {
        return 0;
    }
    NSArray *alllKays = self.pieDic.allKeys;
    if (alllKays.count == 0 || alllKays.count == 1) {
        return 0;
    }
    CGFloat angle = 0;
    if (self.isFirst) {
        self.first = NO;
        NSString *key = alllKays[layerIndex];
        TMBill *indexBill = self.pieDic[key];
        angle += [self getLayerAngleWithBill:indexBill]/2;
        
        for (NSInteger i=0; i<layerIndex ; i++) {
            NSString *key = alllKays[i];
            TMBill *bill = self.pieDic[key];
            angle +=[self getLayerAngleWithBill:bill];
        }
        angle = M_PI - angle;
        self.previousSelectedOfPieViewIndex = layerIndex;
        return angle;
    }
    if (layerIndex == 0) {
        NSString *firstKey = alllKays.firstObject;
        TMBill *firstBill = self.pieDic[firstKey];
        angle += [self getLayerAngleWithBill:firstBill]/2;
        NSString *lastKey = alllKays.lastObject;
        TMBill *lastBill = self.pieDic[lastKey];
        angle += [self getLayerAngleWithBill:lastBill]/2;
    } else {
        NSString *previousKey = alllKays[layerIndex-1];
        TMBill *previousBill = self.pieDic[previousKey];
        angle += [self getLayerAngleWithBill:previousBill]/2;
        NSString *nextKey = alllKays[layerIndex];
        TMBill *nextBill = self.pieDic[nextKey];
        angle += [self getLayerAngleWithBill:nextBill]/2;
    }
    self.previousSelectedOfPieViewIndex = layerIndex;
    return -angle;
}

- (CGFloat)getLayerAngleWithBill:(TMBill *)bill {
    
    float radius = 50;
    float roundS = radius * radius * M_PI;
    float arcS = roundS * bill.category.percent/100;
    float arcL = (2 * arcS)/radius;
    CGFloat angle = 180 * arcL / (M_PI * radius);
    return angle * M_PI/180;
}

- (void)rotateAnimationByAngle:(CGFloat )angle {
    
    [UIView animateWithDuration:.5f animations:^{
        self.pieView.transform = CGAffineTransformRotate(self.pieView.transform, angle);
    } completion:^(BOOL finished) {
        [self reloadPieViewAttachedDataWithLayerIndex:self.currentIndex];
    }];
}

- (void)reloadPieViewAttachedDataWithLayerIndex:(NSInteger)index {
    
    if (self.pieDic.allKeys.count==0 || index>self.pieDic.allKeys.count-1) {
        if (self.isSelectedExpend) {
            [self.categoryBtn setImage:[UIImage imageNamed:@"type_big_1"] forState:UIControlStateNormal];
        } else {
            [self.categoryBtn setImage:[UIImage imageNamed:@"type_big_0"] forState:UIControlStateNormal];
        }
        self.categoryTitleLabel.text = @"一般";
        self.moneyLabel.text = @"0.00";
        self.percentLabel.text = @"0%";
        self.countLabel.text = @"0笔";
        return;
    }
    NSString *key = self.pieDic.allKeys[index];
    TMBill *bill = self.pieDic[key];
    [self.categoryBtn setImage:bill.category.categoryImage forState:UIControlStateNormal];
    self.categoryTitleLabel.text = key;
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",bill.money.floatValue];
    self.percentLabel.text = [NSString stringWithFormat:@"%.2f%%",bill.category.percent];
    self.countLabel.text = [NSString stringWithFormat:@"%li笔",bill.count];
}

- (CGFloat)getTapRotatingAngleWithLayerIndex:(NSInteger)layerIndex {
    
    if (layerIndex == self.previousSelectedOfPieViewIndex) {
        return 0;
    }
    NSArray *alllKays = self.pieDic.allKeys;
    if (alllKays.count==0 || alllKays.count==1) {
        return 0;
    }
    CGFloat angle = 0;
    if (self.previousSelectedOfPieViewIndex < layerIndex) {
        for (NSInteger i = self.previousSelectedOfPieViewIndex; i <= layerIndex; i++) {
            NSString *key = alllKays[i];
            if (i==self.previousSelectedOfPieViewIndex||i==layerIndex) {
                TMBill *bill = self.pieDic[key];
                angle += [self getLayerAngleWithBill:bill]/2;
            } else {
                TMBill *theBill = self.pieDic[key];
                angle += [self getLayerAngleWithBill:theBill];
            }
        }
        self.previousSelectedOfPieViewIndex = layerIndex;
        return -angle;
    }
    
    for (NSInteger j = layerIndex; j <= self.previousSelectedOfPieViewIndex; j++) {
        NSString *key = alllKays[j];
        if (j == self.previousSelectedOfPieViewIndex || j == layerIndex) {
            TMBill *bill = self.pieDic[key];
            angle += [self getLayerAngleWithBill:bill]/2;
        } else {
            TMBill *theBill = self.pieDic[key];
            angle += [self getLayerAngleWithBill:theBill];
        }
    }
    self.previousSelectedOfPieViewIndex = layerIndex;
    return angle;
}

- (void)filterMonthWithDateArray:(NSArray *)array {
    
    for (NSString *dateStr in array) {
        NSString *yearAndMonth = [dateStr substringToIndex:7];
        BOOL contains = [self containsMonth:yearAndMonth];
        if (!contains) {
            NSRange range = NSMakeRange(5, 2);
            NSString *month = [dateStr substringWithRange:range];
            month = self.items[month.integerValue - 1];
            [self.dic setValue:month forKey:dateStr];
        }
    }
    [self.dic setValue:self.items.lastObject forKey:@"ALL"];
    self.sortDicKeys = [NSArray sortArray:self.dic.allKeys ascending:YES];
    [self.iCar reloadData];
}

- (BOOL)containsMonth:(NSString *)yearAndMonth {
    
    if (self.dic.allKeys.count == 0) {
        return NO;
    } else {
        for (NSInteger i = 0; i < self.dic.allKeys.count ; i++) {
            if ([self.dic.allKeys[i] isEqualToString:@"ALL"]) {
                continue;
            }
            if ([[self.dic.allKeys[i] substringToIndex:7] isEqualToString:yearAndMonth]) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)updateColorWithAttributedString:(NSMutableAttributedString *)attributedString
                             titleColor:(UIColor *)titleColor
                             moneyColor:(UIColor *)moneyColor
                                 toView:(UILabel *)sender
{
    [attributedString beginEditing];
    NSRange titleRange = NSMakeRange(0, 3);
    [attributedString setAttributes:@{
                                      NSFontAttributeName:[UIFont systemFontOfSize:kNameFont],
                                      NSForegroundColorAttributeName:titleColor
                                      } range:titleRange];
    NSRange moneyRange = NSMakeRange(3, attributedString.length - 3);
    [attributedString setAttributes:@{
                                      NSFontAttributeName:[UIFont systemFontOfSize:kNameFont],
                                      NSForegroundColorAttributeName:moneyColor
                                      } range:moneyRange];
    [attributedString endEditing];
    sender.attributedText = attributedString;
}

- (void)updateStringWithAttributedString:(NSMutableAttributedString *)attributedString
                                  toView:(UILabel *)sender
                               withMonth:(BOOL)month
{
    [attributedString beginEditing];
    NSRange range = NSMakeRange(0, 1);
    month ? [attributedString replaceCharactersInRange:range withString:@"月"]:[attributedString replaceCharactersInRange:range withString:@"总"];
    [attributedString endEditing];
    sender.attributedText = attributedString;
}

- (void)updateMoneyWithAttributedString:(NSMutableAttributedString *)attributedString
                        withMoneyString:(NSString *)moneyString
                                 toView:(UILabel *)sender
{
    [attributedString beginEditing];
    NSInteger length = attributedString.length;
    NSRange range = NSMakeRange(4, length-4);
    [attributedString replaceCharactersInRange:range withString:moneyString];
    [attributedString endEditing];
    sender.attributedText = attributedString;
}

#pragma mark - iCarouselDataSource

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    
    return self.sortDicKeys.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    
    UIView *iCarView = view;
    UILabel *label = nil;
    if (!iCarView) {
        iCarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kICarViewHeight, kICarViewHeight)];
        label = [[UILabel alloc] initWithFrame:iCarView.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 1;
        label.numberOfLines = 2;
        label.textColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00];
        label.font = [UIFont systemFontOfSize:15.0f];
        [iCarView addSubview:label];
    } else {
        label = [view viewWithTag:1];
    }
    NSString *key = self.sortDicKeys[index];
    label.text = self.dic[key];
    return iCarView;
}

#pragma mark - iCarouselDelegate

- (CGFloat)carouselItemWidth:(iCarousel *)carousel {
    
    return kICarViewHeight + 5.0f;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
    
    return CATransform3DTranslate(transform, offset * kICarViewHeight, 0, 0);
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    
    self.first = YES;
    self.previousSelectedOfPieViewIndex = -1;
    NSString *key = self.sortDicKeys[carousel.currentItemIndex];
    
    // update yearLabel and switch the corresponding bill.
    if (![key isEqualToString:@"ALL"]) {
        self.yearLabel.text = [key substringToIndex:4];
        self.currentDateString = key;
    } else {
        self.currentDateString = @"ALL";
        [self updateYearLabel];
    }
    
    // update income or expend type, and money.
    if (carousel.currentItemIndex != self.sortDicKeys.count-1) {
        [self updateStringWithAttributedString:self.leftAttributedString toView:self.leftItemLabel withMonth:YES];
        [self updateStringWithAttributedString:self.rightAttributedString toView:self.rightItemLabel withMonth:YES];
        float incomeMoney = [TMCalculatorManager queryMonthAllIncomeOrExpendOfBookID:[NSString readUserDefaultOfSelectedBookID] dateString:key moneyType:MoneyTypeIncome];
        [self updateMoneyWithAttributedString:self.leftAttributedString withMoneyString:[NSString stringWithFormat:@"%.2f",incomeMoney] toView:self.leftItemLabel];
        float expendMoney = [TMCalculatorManager queryMonthAllIncomeOrExpendOfBookID:[NSString readUserDefaultOfSelectedBookID] dateString:key moneyType:MoneyTypeExpend];
        [self updateMoneyWithAttributedString:self.rightAttributedString withMoneyString:[NSString stringWithFormat:@"%.2f",expendMoney] toView:self.rightItemLabel];
        [self reloadPieViewDataWithDateString:key];
    } else {
        [self updateStringWithAttributedString:self.leftAttributedString toView:self.leftItemLabel withMonth:NO];
        [self updateStringWithAttributedString:self.rightAttributedString toView:self.rightItemLabel withMonth:NO];
        float expendMoney = [TMCalculatorManager queryAllIncomeOrExpendOfBookID:[NSString readUserDefaultOfSelectedBookID] moneyType:MoneyTypeExpend];
        [self updateMoneyWithAttributedString:self.rightAttributedString withMoneyString:[NSString stringWithFormat:@"%.2f",expendMoney] toView:self.rightItemLabel];
        float incomeMoney = [TMCalculatorManager queryAllIncomeOrExpendOfBookID:[NSString readUserDefaultOfSelectedBookID] moneyType:MoneyTypeIncome];
        [self updateMoneyWithAttributedString:self.leftAttributedString withMoneyString:[NSString stringWithFormat:@"%.2f",incomeMoney] toView:self.leftItemLabel];
        [self reloadPieViewDataWithDateString:@"ALL"];
    }
    
    // update item color.
    if (carousel.currentItemIndex != self.prevoiusIndex) {
        UIView *view = [carousel itemViewAtIndex:self.prevoiusIndex];
        UILabel *label = [view viewWithTag:1];
        label.textColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00];
    }
    
    UIView *view = carousel.currentItemView;
    self.prevoiusIndex = carousel.currentItemIndex;
    UILabel *label = [view viewWithTag:1];
    label.textColor = kSelectColor;
}

- (void)reloadPieViewDataWithDateString:(NSString *)dateString {

    if (self.isSelectedExpend) {
        self.pieDic = [[TMDataBaseManager defaultManager] queryPieDataWithBookID:[NSString readUserDefaultOfSelectedBookID]
                                                                       dateSting:dateString
                                                                       moneyType:MoneyTypeExpend];
        [self reloadPieSectionAndSectionColorsWithDictionary:self.pieDic];
    } else {
        self.pieDic = [[TMDataBaseManager defaultManager] queryPieDataWithBookID:[NSString readUserDefaultOfSelectedBookID]
                                                                       dateSting:dateString
                                                                       moneyType:MoneyTypeIncome];
        [self reloadPieSectionAndSectionColorsWithDictionary:self.pieDic];
    }
}

- (void)updateYearLabel {
    
    NSString *firstKey = self.sortDicKeys.firstObject;
    NSInteger count = self.sortDicKeys.count;
    if (self.sortDicKeys.count<2) {
        self.yearLabel.text = [NSString stringWithFormat:@"%@",[[NSString currentDateStr] substringToIndex:4]];
        return;
    }
    NSString *lastKey = self.sortDicKeys[count-2];
    if (![[firstKey substringToIndex:4] isEqualToString:[lastKey substringToIndex:4]]) {
        self.yearLabel.text = [NSString stringWithFormat:@"%@~%@",[firstKey substringToIndex:4],[lastKey substringToIndex:4]];
    } else {
        self.yearLabel.text = [NSString stringWithFormat:@"%@",[firstKey substringToIndex:4]];
    }
}

@end
