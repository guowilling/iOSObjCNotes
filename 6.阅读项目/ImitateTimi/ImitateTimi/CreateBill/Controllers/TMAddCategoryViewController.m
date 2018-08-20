
#import "TMAddCategoryViewController.h"
#import "TMAddCategoryCollectionViewCell.h"
#import "TMAddCategory.h"
#import "TMCategory.h"

#define kItemWidth 97/2.5

@interface TMAddCategoryViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *contaierView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TMAddCategory *selectedCategory;

@end

@implementation TMAddCategoryViewController

#pragma mark - Lazy Load

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        RLMResults *results = [[TMDataBaseManager defaultManager] queryAddCategorysWithMoneyType:self.paymentType];
        for (TMAddCategory *category in results) {
            [_dataSource addObject:category];
        }
    }
    return _dataSource;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationBar];
    
    [self setupContaierView];
    
    [self setupCollectionView];
    
    self.selectedCategory = self.dataSource.firstObject;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)setupNavigationBar {
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [cancelBtn setImage:[UIImage imageNamed:@"btn_item_close"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    label.text = @"添加分类";
    label.font = [UIFont systemFontOfSize:15.0f];
    self.navigationItem.titleView = label;
    
    UIButton *completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    completeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [completeBtn setTitleColor:LineColor forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(clickCompleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
}

- (void)setupContaierView {
    
    WEAKSELF
    self.contaierView = [UIView new];
    self.contaierView.layer.borderWidth = 0.6;
    self.contaierView.layer.borderColor = LineColor.CGColor;
    [self.view addSubview:self.contaierView];
    [self.contaierView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.mas_topLayoutGuide);
        make.height.equalTo(@50);
    }];
    
    self.imageView = [UIImageView new];
    self.imageView.image = ((TMAddCategory *)self.dataSource.firstObject).image;
    [self.contaierView addSubview:self.imageView];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(kItemWidth, kItemWidth));
        make.left.equalTo(weakSelf.contaierView).offset(10);
        make.centerY.equalTo(weakSelf.contaierView);
    }];
    
    self.textField = [UITextField new];
    self.textField.font = [UIFont systemFontOfSize:15.0];
    self.textField.placeholder = @"输入分类名称";
    [self.contaierView addSubview:self.textField];
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contaierView);
        make.left.equalTo(weakSelf.imageView.right).offset(5);
        make.right.equalTo(weakSelf.contaierView);
        make.height.equalTo(weakSelf.imageView);
    }];
}

- (void)setupCollectionView {
    
    WEAKSELF
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kItemWidth, kItemWidth);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[TMAddCategoryCollectionViewCell class] forCellWithReuseIdentifier:TMAddCategoryCollectionViewCellID];
    [self.view addSubview:self.collectionView];
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contaierView.bottom);
        make.left.right.bottom.equalTo(weakSelf.view);
    }];
}

#pragma mark - Actions

- (void)cancelBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickCompleteBtn:(UIButton *)sender {
    
    if (self.textField.text.length < 1) {
        [self showSVProgressHUD:@"请输入分类名称"];
    } else if (self.textField.text.length > 3) {
      [self showSVProgressHUD:@"分类名称不能超过4个字"];
    } else {
        TMCategory *category = [TMCategory new];
        category.categoryTitle = self.textField.text;
        category.categoryImageFileNmae = self.selectedCategory.categoryImageFileName;
        category.isIncome = self.selectedCategory.isIncome;
        [[TMDataBaseManager defaultManager] insertCategory:category];
        [[TMDataBaseManager defaultManager] deleteWithAddCategory:self.selectedCategory];
        [self cancelBtn:sender];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TMAddCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TMAddCategoryCollectionViewCellID forIndexPath:indexPath];
    TMAddCategory *category = self.dataSource[indexPath.row];
    cell.imageView.image = category.image;
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.textField becomeFirstResponder];
    
    TMAddCategory *category = self.dataSource[indexPath.row];
    self.imageView.image = category.image;
    self.selectedCategory = category;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

@end
