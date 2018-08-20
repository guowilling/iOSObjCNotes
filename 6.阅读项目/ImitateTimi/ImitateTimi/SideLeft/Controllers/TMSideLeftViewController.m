
#import <UIViewController+MMDrawerController.h>
#import "TMSideLeftViewController.h"
#import "TMSideLeftHeaderView.h"
#import "TMSideLeftCell.h"
#import "TMSideLeftButton.h"
#import "TMAddBookView.h"
#import "TMHomePageViewController.h"
#import "NSString+TMNSString.h"

#define kMenuOperationBtnTitleFont [UIFont systemFontOfSize:13.0f]

static NSString * const collectionViewCellID = @"TMSideLeftCell";

@interface TMSideLeftViewController () <UICollectionViewDelegate, UICollectionViewDataSource, TMSideLeftCellDelegate>

@property (nonatomic, strong) TMSideLeftHeaderView *headerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) RLMResults *results;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) TMAddBookView *addBookView;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, assign) NSInteger previousSelectedBook;

@property (nonatomic, assign, getter=isEditing) BOOL editing;
@property (nonatomic, strong) NSIndexPath *editSelectedIndexPath;

@property (nonatomic, strong) TMSideLeftButton *cancelBtn;
@property (nonatomic, strong) TMSideLeftButton *deleteBtn;
@property (nonatomic, strong) TMSideLeftButton *editBtn;
@property (nonatomic, strong) TMSideLeftButton *exploreBtn;

@property (nonatomic, assign,getter=isUpdating) BOOL updating;
@property (nonatomic, strong) TMBooks *updatingBook;

@end

@implementation TMSideLeftViewController

#pragma mark - Lazy Load

- (TMSideLeftButton *)exploreBtn {
    
    if (!_exploreBtn) {
        _exploreBtn = [TMSideLeftButton new];
        [_exploreBtn setImage:[UIImage imageNamed:@"Earth"] forState:UIControlStateNormal];
        [_exploreBtn setTitle:@"探索" forState:UIControlStateNormal];
        _exploreBtn.titleLabel.font = kMenuOperationBtnTitleFont;
        [_exploreBtn addTarget:self action:@selector(clickExploreBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exploreBtn;
}

- (TMSideLeftButton *)cancelBtn {
    
    if (!_cancelBtn) {
        _cancelBtn = [TMSideLeftButton new];
        [_cancelBtn setImage:[UIImage imageNamed:@"menu_operation_cancel"] forState:UIControlStateNormal];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(clickCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.titleLabel.font = kMenuOperationBtnTitleFont;
    }
    return _cancelBtn;
}

- (TMSideLeftButton *)deleteBtn {
    
    if (!_deleteBtn) {
        _deleteBtn = [TMSideLeftButton new];
        [_deleteBtn setImage:[UIImage imageNamed:@"menu_operation_delete"] forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(clickDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.titleLabel.font = kMenuOperationBtnTitleFont;
    }
    return _deleteBtn;
}

- (TMSideLeftButton *)editBtn {
    
    if (!_editBtn) {
        _editBtn = [TMSideLeftButton new];
        [_editBtn setImage:[UIImage imageNamed:@"menu_operation_edit"] forState:UIControlStateNormal];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(clickEditBtn:) forControlEvents:UIControlEventTouchUpInside];
        _editBtn.titleLabel.font = kMenuOperationBtnTitleFont;
    }
    return _editBtn;
}

#pragma mark - Lifecycle

- (void)setupHeaderView {
    
    WEAKSELF
    self.headerView = [TMSideLeftHeaderView new];
    [self.view addSubview:self.headerView];
    [self.headerView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(SCREEN_SIZE.width-50);
        make.height.equalTo(140);
        make.top.equalTo(weakSelf.view);
    }];
}

- (void)setupCollectionView {
    
    WEAKSELF
    CGFloat width = SCREEN_SIZE.width - 50 - 20 * 2 - 10 * 3 ;
    CGFloat height = SCREEN_SIZE.height - 140 - 70 - 20 * 2 - kStatusBarHeight;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(width/3, height/3);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 0, 10);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[TMSideLeftCell class] forCellWithReuseIdentifier:collectionViewCellID];
    [self.view addSubview:self.collectionView];
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headerView.bottom);
        make.left.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-70);
        make.width.equalTo(weakSelf.view);
    }];
}

- (void)setupLineView {
    
    WEAKSELF
    CGFloat viewWidth = SCREEN_SIZE.height - 50;
    UIView *lineView = [UIView new];
    lineView.backgroundColor = LineColor;
    [self.view addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(viewWidth);
        make.height.equalTo(0.5);
        make.top.equalTo(weakSelf.collectionView.bottom).offset(-2);
    }];
}

- (void)setupBottomBtns {
    
    WEAKSELF
    [self.view addSubview:self.exploreBtn];
    [self.exploreBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.size.equalTo(CGSizeMake(60, 60));
        make.bottom.equalTo(weakSelf.view);
    }];
    
    [self.view addSubview:self.cancelBtn];
    [self.cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(60, 60));
        make.left.equalTo(weakSelf.view).offset(20);
        make.bottom.equalTo(weakSelf.view).offset(60);
    }];
    
    [self.view addSubview:self.deleteBtn];
    [self.deleteBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(weakSelf.cancelBtn);
        make.centerX.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.cancelBtn);
    }];
    
    [self.view addSubview:self.editBtn];
    [self.editBtn makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(weakSelf.cancelBtn);
        make.right.equalTo(weakSelf.collectionView).offset(-20);
        make.bottom.equalTo(weakSelf.cancelBtn);
    }];
}

- (void)setupContainerView {
    
    self.window = [UIApplication sharedApplication].keyWindow;
    self.containerView = [UIView new];
    self.containerView.backgroundColor = [UIColor colorWithWhite:0.597 alpha:0.300];
    [self.window addSubview:self.containerView];
    [self.window sendSubviewToBack:self.containerView];
    [self.containerView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.containerView.alpha = 0.0;
}

- (void)addBookViewCancleAction {
    
    [self.containerView setAlpha:0.0];
    [self.window sendSubviewToBack:self.containerView];
    [self.addBookView resignFirstResponder];
    [self clickCancelBtn:nil];
}

- (void)setupAddBookView {
    
    WEAKSELF
    self.addBookView = [TMAddBookView new];
    [self.containerView addSubview:self.addBookView];
    [self.addBookView makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(SCREEN_SIZE.width - 80);
        make.height.equalTo(weakSelf.containerView).multipliedBy(0.25);
        make.centerX.equalTo(weakSelf.containerView);
        make.top.equalTo(weakSelf.containerView).offset(150);
    }];
    
    self.addBookView.clickCancelBtn = ^{
        [weakSelf addBookViewCancleAction];
    };
    
    self.addBookView.clickSureBtn = ^(NSString *bookName,NSString *bookImageFileName,NSInteger imageIndex) {
        if (bookName.length > 6) {
            [weakSelf showSVProgressHUD:@"最多只能输入6个汉字"];
            return;
        }
        NSString *name = nil;
        if ([bookName isEqualToString:@""]) {
            name = @"新建账本";
        } else {
            name = bookName;
        }
        if (!weakSelf.isUpdating) {
            TMBooks *book = [TMBooks new];
            book.bookImageFileName = bookImageFileName;
            book.bookName = name;
            book.imageIndex = @(imageIndex);
            [[TMDataBaseManager defaultManager] insertBooks:book];
        } else {
            [weakSelf setUpdating:NO];
            [weakSelf.updatingBook updateBookName:bookName];
            [weakSelf.updatingBook updateImageIndex:@(imageIndex)];
            [weakSelf.updatingBook updateBookImageFileName:bookImageFileName];
        }
        [weakSelf addBookViewCancleAction];
        [weakSelf.addBookView reloadData];
        [weakSelf.collectionView reloadData];
    };
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setupHeaderView];
    
    [self setupCollectionView];
    
    [self setupLineView];
    
    [self setupBottomBtns];
    
    [self setupContainerView];
    
    [self setupAddBookView];

    self.results = [[TMDataBaseManager defaultManager] queryAllBooks];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    self.editSelectedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
    
    [self.headerView reloadData];
    NSString *bookID = [NSString readUserDefaultOfSelectedBookID];
    self.previousSelectedBook = [[TMDataBaseManager defaultManager] bookIndexWithBookID:bookID];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [[TMDataBaseManager defaultManager] numberOfAllBooksCount] + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TMSideLeftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellID forIndexPath:indexPath];
    cell.sideCellDelegate = self;
    cell.indexPath = indexPath;
    
    if (indexPath.row==self.previousSelectedBook) {
        cell.selectedItemImageView.hidden = NO;
    } else {
        cell.selectedItemImageView.hidden = YES;
    }
    
    TMBooks *book = nil;
    if (indexPath.row == [[TMDataBaseManager defaultManager] numberOfAllBooksCount]) {
        book = [TMBooks new];
        book.bookImageFileName = @"menu_cell_add";
    } else {
        book = self.results[indexPath.row];
    }
    cell.book = book;
    
    if (self.isEditing) {
        if ([indexPath isEqual:self.editSelectedIndexPath]) {
            cell.editSelectedItemImageView.hidden = NO;
        } else {
            cell.editSelectedItemImageView.hidden = YES;
        }
        [self shakeCell:cell];
    } else {
        cell.editSelectedItemImageView.hidden = YES;
        cell.transform = CGAffineTransformIdentity;
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isEditing) {
        return;
    }
    if (indexPath.row==[[TMDataBaseManager defaultManager] numberOfAllBooksCount]) {
        self.containerView.alpha = 1.0;
        [self.window bringSubviewToFront:self.containerView];
        [self.addBookView becomeFirstResponder];
    } else {
        TMBooks *book = self.results[indexPath.row];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:book.booksID forKey:@"selectBookID"];
        [defaults synchronize];
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:TMHomePageNeedReloadNotifiation object:nil];
    }
}

#pragma mark - TMSideLeftCellDelegate

- (void)sideLeftCellWithIndexPath:(NSIndexPath *)indexPath withLongPress:(UILongPressGestureRecognizer *)longPress {
    
    if (indexPath.row == [[TMDataBaseManager defaultManager] numberOfAllBooksCount] || self.isEditing) {
        return;
    }
    if (longPress.state == UIGestureRecognizerStateBegan) {
        self.editSelectedIndexPath = indexPath;
        self.editing = YES;
        [self.collectionView reloadData];
        [self animationWithAppear];
    }
}

#pragma mark - Actions

- (void)clickExploreBtn:(TMSideLeftButton *)sender {
    
    NSLog(@"clickExploreBtn");
}

- (void)clickCancelBtn:(TMSideLeftButton *)sender {
    
    self.editing = NO;
    TMSideLeftCell *cell = (TMSideLeftCell *)[self.collectionView cellForItemAtIndexPath:self.editSelectedIndexPath];
    cell.editSelectedItemImageView.hidden = YES;
    [self animationWithDisAppear];
    [self.collectionView reloadData];
}

- (void)clickDeleteBtn:(TMSideLeftButton *)sender {
    
    if (self.results.count == 1) {
        [self showSVProgressHUD:@"请最后留下一个账本"];
        return;
    }
    TMBooks *book = self.results[self.editSelectedIndexPath.row];
    WEAKSELF
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"删除“%@”", book.bookName]
                                                                             message:@"若删除,其所有数据也将被删除"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [weakSelf clickCancelBtn:nil];
                                                         }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           [[TMDataBaseManager defaultManager] deleteBookWithBookID:book.booksID];
                                                           if (self.previousSelectedBook == self.editSelectedIndexPath.row) {
                                                               TMBooks *book = self.results.firstObject;
                                                               NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                                               [defaults setObject:book.booksID forKey:@"selectBookID"];
                                                               [defaults synchronize];
                                                           }
                                                           [self clickCancelBtn:nil];
                                                           [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
                                                           [[NSNotificationCenter defaultCenter] postNotificationName:TMHomePageNeedReloadNotifiation
                                                                                                               object:nil];
                                                       }];
    [alertController addAction:cancelAction];
    [alertController addAction:sureAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)clickEditBtn:(TMSideLeftButton *)sender {
    
    self.updating = YES;
    self.updatingBook = self.results[self.editSelectedIndexPath.row];
    self.addBookView.text = self.updatingBook.bookName;
    self.addBookView.index = self.updatingBook.imageIndex.intValue;
    self.containerView.alpha = 1.0;
    [self.addBookView becomeFirstResponder];
    [self.window bringSubviewToFront:self.containerView];
    
}

#pragma mark - Assist Methods

- (void)shakeCell:(TMSideLeftCell *)cell {
    
    [UIView animateWithDuration:0.1 delay:0 options:0 animations:^{
        cell.transform=CGAffineTransformMakeRotation(-0.02);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1
                              delay:0
                            options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             cell.transform = CGAffineTransformMakeRotation(0.02);
                         } completion:nil];
    }];
}

- (void)animationWithAppear {
    
    WEAKSELF
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.cancelBtn updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view);
        }];
    } completion:^(BOOL finished) {
        [self.exploreBtn updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view).offset(60);
        }];
    }];
}

- (void)animationWithDisAppear {
    
    WEAKSELF
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.cancelBtn updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view).offset(60);
        }];
    } completion:^(BOOL finished) {
        [self.exploreBtn updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.view);
        }];
    }];    
}

@end
