
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import <Masonry.h>
#import "TMRemarkViewController.h"
#import "UITextView+Placeholder.h"
#import "TMActionSheetView.h"
#import "TMBill.h"

@interface TMRemarkViewController () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UITextView *contentTextView;

@property (nonatomic, strong) UIView     *accessoryView;
@property (nonatomic, strong) UIButton   *cameraBtn;
@property (nonatomic, strong) UILabel    *limitLabel;

@property (nonatomic, strong) TMActionSheetView *actionSheetView;

/** 显示提示表 default NO */
@property (nonatomic, assign, getter=isDisplayActionSheetView) BOOL displayActionSheetView;

@property (nonatomic, strong) UIImagePickerController *imagePicker;

@property (nonatomic, strong) NSString *reMarks;
@property (nonatomic, strong) NSData *photoData;

@end

@implementation TMRemarkViewController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIImagePickerController *)imagePicker {
    
    if (!_imagePicker) {
        _imagePicker = [UIImagePickerController new];
        _imagePicker.delegate = self;
    }
    return _imagePicker;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationBar];
    
    [self setupSubviews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    self.displayActionSheetView = NO;
    
    self.contentTextView.text = self.bill.reMarks;
    
    self.reMarks = self.bill.reMarks;
    self.photoData = self.bill.remarkPhoto;
    
    if (self.bill.remarkPhoto) {
        [self.cameraBtn setImage:[UIImage imageWithData:self.bill.remarkPhoto] forState:UIControlStateNormal];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.contentTextView becomeFirstResponder];
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
    self.title = @"备注";
    
    UIButton *completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    completeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [completeBtn setTitleColor:LineColor forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(clickCompleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:completeBtn];
}

- (void)setupSubviews {
    
    WEAKSELF
    
    self.timeLabel = ({
        UILabel *timeLabel = [UILabel new];
        [self.view addSubview:timeLabel];
        [timeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, 30));
            make.left.equalTo(weakSelf.view).mas_offset(10);
            make.top.mas_equalTo(kMaxNBY);
        }];
        timeLabel.font = [UIFont systemFontOfSize:14.0f];
        timeLabel.textColor = [UIColor colorWithWhite:0.800 alpha:1.000];
        NSMutableString *dateStr = self.bill.dateStr.mutableCopy;
        [dateStr replaceCharactersInRange:NSMakeRange(4, 1) withString:@"年"];
        [dateStr replaceCharactersInRange:NSMakeRange(7, 1) withString:@"月"];
        [dateStr insertString:@"日" atIndex:10];
        timeLabel.text = dateStr;
        timeLabel;
    });

    self.contentTextView = ({
        UITextView *contentTextView = [UITextView new];
        [self.view addSubview:contentTextView];
        [contentTextView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, 300));
            make.top.equalTo(weakSelf.timeLabel.bottom);
            make.left.equalTo(weakSelf.timeLabel.left);
        }];
        contentTextView.delegate = self;
        contentTextView.font = [UIFont systemFontOfSize:20.0f];
        contentTextView.placeholder = @"记录花销更记录生活...";
        contentTextView.placeholderColor = LineColor;
        contentTextView;
    });
    
    self.accessoryView = ({
        UIView *accessoryView = [UIView new];
        [self.view addSubview:accessoryView];
        [accessoryView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, 50));
            make.left.bottom.equalTo(weakSelf.view);
        }];
        accessoryView;
    });
    
    self.cameraBtn = ({
        UIButton *cameraBtn = [UIButton new];
        [self.accessoryView addSubview:cameraBtn];
        [cameraBtn makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(40, 40));
            make.left.equalTo(weakSelf.timeLabel);
            make.bottom.equalTo(weakSelf.accessoryView).offset(-10);
        }];
        [cameraBtn setBackgroundImage:[UIImage imageNamed:@"btn_camera"] forState:UIControlStateNormal];
        [cameraBtn addTarget:self action:@selector(clickCameraBtn:) forControlEvents:UIControlEventTouchUpInside];
         cameraBtn;
    });

    self.limitLabel = ({
        UILabel *limitLabel = [UILabel new];
        [self.accessoryView addSubview:limitLabel];
        [limitLabel makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(60, 30));
            make.bottom.equalTo(weakSelf.accessoryView).offset(-10);
            make.right.equalTo(weakSelf.accessoryView).offset(-20);
        }];
        limitLabel.textColor = LineColor;
        limitLabel.text = @"0/40";
        limitLabel;
    });
    
    self.actionSheetView = ({
        TMActionSheetView *actionSheetView = [TMActionSheetView new];
        [self.view addSubview:actionSheetView];
        [actionSheetView makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, 0));
            make.left.bottom.right.equalTo(weakSelf.view);
        }];
        actionSheetView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1.00];
        actionSheetView.cancelBtnBlock = ^ {
            [weakSelf.actionSheetView updateConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, 0));
            }];
            [weakSelf.view setNeedsLayout];
            [weakSelf.view layoutIfNeeded];
            [weakSelf.contentTextView becomeFirstResponder];
            weakSelf.view.backgroundColor = [UIColor whiteColor];
            weakSelf.contentTextView.backgroundColor = [UIColor whiteColor];
            weakSelf.displayActionSheetView = NO;
        };
        actionSheetView.albumBtnBlock = ^ {
            [weakSelf readPhoto];
        };
        actionSheetView.cameraBtnBlock = ^ {
            [weakSelf openCamera];
        };
        actionSheetView;
    });
}

#pragma mark - Actions

- (void)readPhoto {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }
}

- (void)openCamera {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        self.imagePicker.showsCameraControls = YES;
        self.imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        self.imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
        // 如果相机是英文, 添加 info.plist 键值对 Localized resources can be mixed = YES.
    } else {
        [self showSVProgressHUD:@"当前设备不支持相机调用"];
    }
}

- (void)clickCameraBtn:(UIButton *)sender {
    
    WEAKSELF
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.5f animations:^{
        [weakSelf.actionSheetView updateConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(SCREEN_SIZE.width, 180));
        }];
        [weakSelf.view setNeedsLayout];
        [weakSelf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        weakSelf.view.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
        weakSelf.contentTextView.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
        weakSelf.displayActionSheetView = YES;
    }];
}

- (void)cancelBtn:(UIButton *)sender {
    
    if (self.contentTextView.text.length > 40) {
        [self showSVProgressHUD:@"备注不能超过最大字数哦."];
        return;
    }
    WEAKSELF
    [self dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.passbackBlock) {
            weakSelf.passbackBlock(weakSelf.reMarks,weakSelf.photoData);
        }
    }];
}

- (void)clickCompleteBtn:(UIButton *)sender {
    
    [self cancelBtn:sender];
}

#pragma mark - Notifications

- (void)keyboardDidShow:(NSNotification *)notification {
    
    CGFloat keyboardY = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat camerBtnY = CGRectGetMaxY(self.accessoryView.frame);
    CGFloat delta = camerBtnY - keyboardY;
    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        [self.accessoryView updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(-delta);
        }];
        [self.view setNeedsLayout];
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    
    [self.accessoryView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
    self.reMarks = textView.text;
    self.limitLabel.text = [NSString stringWithFormat:@"%lu/40",(unsigned long)textView.text.length];
    if (textView.text.length > 40) {
        self.limitLabel.textColor = [UIColor redColor];
    } else {
        self.limitLabel.textColor = LineColor;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if (self.isDisplayActionSheetView) {
        return NO;
    }
    return YES;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [self.cameraBtn setBackgroundImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    NSData *imageData = UIImageJPEGRepresentation(info[UIImagePickerControllerOriginalImage], 0.8);
    self.photoData = imageData;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
