//
//  SRComposeViewController.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/28.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRComposeViewController.h"
#import "SRComposeViewModel.h"
#import "SREmotionKeyboard.h"
#import "SRKeyboardToolBar.h"
#import "SRComposeTextView.h"
#import "SRPlaceholderTextView.h"
#import "SRPicturesView.h"
#import "SREmotion.h"
#import "MBProgressHUD+MJ.h"

@interface SRComposeViewController () <UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SRKeyboardToolBarDelegate>

@property (nonatomic, strong) SRComposeViewModel *composeVM;

@property (nonatomic, weak) SRComposeTextView *textView;
@property (nonatomic, weak) SRPicturesView    *picturesView;
@property (nonatomic, weak) SRKeyboardToolBar *keyboardToolBar;

@property (nonatomic, strong) SREmotionKeyboard *emotionKeyboard;
@property (nonatomic, assign, getter=isSwitchingKeyboard) BOOL switchingKeyboard;

@end

@implementation SRComposeViewController

#pragma mark - Lazy Load

- (SREmotionKeyboard *)emotionKeyboard {
    if (!_emotionKeyboard) {
        SREmotionKeyboard *emotionKeyboard = [[SREmotionKeyboard alloc] init];
        emotionKeyboard.width = self.view.width;
        emotionKeyboard.height = 253;
        _emotionKeyboard = emotionKeyboard;
    }
    return _emotionKeyboard;
}

#pragma mark - Lifecycle

- (void)dealloc {
    SRLog(@"dealloc");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.composeVM = [[SRComposeViewModel alloc] init];
    
    [self setupNavBar];
    
    [self setupTextView];
    
    [self setupPicturesView];
    
    [self setupKeyboardToolBar];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)setupNavBar {
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];

    NSString *prefix = @"发微博";
    NSString *name = self.composeVM.currentUserNickname;
    NSString *str = [NSString stringWithFormat:@"%@\n%@", prefix, name];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.width = 100;
    titleLabel.height = 40;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[str rangeOfString:prefix]];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
    titleLabel.attributedText = attrStr;
    self.navigationItem.titleView = titleLabel;
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)setupTextView {
    SRComposeTextView *textView = [[SRComposeTextView alloc] init];
    textView.placeholder = @"分享新鲜事";
    textView.placeholderColor = [UIColor lightGrayColor];
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.delegate = self;
    textView.alwaysBounceVertical = YES;
    [self.view addSubview:textView];
    self.textView = textView;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect:) name:SREmotionBtnDidSelectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidDelete) name:SRTextDidDeleteNotification object:nil];
}

- (void)setupKeyboardToolBar {
    SRKeyboardToolBar *keyboardToolBar = [SRKeyboardToolBar keyboardToolBar];
    keyboardToolBar.width = self.view.width;
    keyboardToolBar.height = 44;
    keyboardToolBar.y = self.view.height - keyboardToolBar.height;
    keyboardToolBar.delegate = self;
    [self.view addSubview:keyboardToolBar];
    self.keyboardToolBar = keyboardToolBar;
//    self.keyboardToolBar.backgroundColor = SRRandomColor;
    
    //self.textView.inputAccessoryView = keyboardToolBar; // 键盘顶部内容
    //self.textView.inputView = keyboardToolBar; // 键盘
}

- (void)setupPicturesView {
    SRPicturesView *picturesView = [SRPicturesView picturesView];
    picturesView.x = 15;
    picturesView.y = 100;
    picturesView.width = self.view.width - 30;
    picturesView.height = 300;
    [self.textView addSubview:picturesView];
    self.picturesView = picturesView;
}

#pragma mark - Monitor method

- (void)cancle {
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

- (void)send {
    if (self.picturesView.pictures.count) {
        [self sendWithPic];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    } else {
        [self sendWithoutPic];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)sendWithPic {
    __weak typeof(self) weakSelf = self;
    [self.composeVM sendStatusWithText:[self.textView fullText] image:[self.picturesView.pictures firstObject] success:^{
        [MBProgressHUD showSuccess:@"发布图片微博成功"];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发布图片微博失败"];
        weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}

- (void)sendWithoutPic {
    [self.composeVM sendStatusWithText:[self.textView fullText] success:^{
        [MBProgressHUD showSuccess:@"发布文字微博成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发布文字微博失败"];
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}

- (void)textDidChange {
    self.navigationItem.rightBarButtonItem.enabled = [self.textView hasText];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    if (self.isSwitchingKeyboard) { // 正在切换键盘工具条位置不变
        return;
    }
    //UIKeyboardFrameEndUserInfoKey: NSRect: {{0, 352}, {320, 216}}, // 键盘弹出\隐藏后的frame
    //UIKeyboardAnimationDurationUserInfoKey: 0.25, // 键盘弹出\隐藏所耗费的时间
    //UIKeyboardAnimationCurveUserInfoKey: 7 // 键盘弹出\隐藏动画的执行节奏
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 = 键盘的Y值 - 工具条的高度
        self.keyboardToolBar.y = keyboardFrame.origin.y - self.keyboardToolBar.height;
    }];
}

- (void)emotionDidSelect:(NSNotification *)notification {
    SREmotion *emotion = notification.userInfo[@"emotion"];
    [self.textView insertEmotion:emotion];
}

- (void)textDidDelete {
    [self.textView deleteBackward];
}

#pragma mark - UITextViewDelegate

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
    
    //self.picturesView.hidden = !self.picturesView.pictures.count;
}

#pragma mark - SRKeyboardToolBarDelegate

- (void)keyboardToolBar:(SRKeyboardToolBar *)toolBar didClickBtn:(SRKeyboardToolBarButtonType)type {
    switch (type) {
        case SRKeyboardToolBarButtonTypeCamera:
            [self openCamera];
            break;
            
        case SRKeyboardToolBarButtonTypeAlbum:
            [self openAlbum];
            break;
            
        case SRKeyboardToolBarButtonTypeMention:
            NSLog(@"@");
            break;
            
        case SRKeyboardToolBarButtonTypeTrend:
            NSLog(@"#");
            break;
            
        case SRKeyboardToolBarButtonTypeEmotion:
            [self switchKeyboard];
            break;
    }
}

- (void)switchKeyboard {
    if (self.textView.inputView == nil) {
        self.textView.inputView = self.emotionKeyboard;
        [self.keyboardToolBar showKeyboardBtn:YES];
    } else {
        self.textView.inputView = nil;
        [self.keyboardToolBar showKeyboardBtn:NO];
    }
    
    self.switchingKeyboard = YES;
    [self.textView endEditing:YES];
    self.switchingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
}

- (void)openCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (void)openAlbum {
    // UIImagePickerControllerSourceTypePhotoLibrary > UIImagePickerControllerSourceTypeSavedPhotosAlbum
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
        picker.allowsEditing = YES;
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.picturesView addPicture:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
