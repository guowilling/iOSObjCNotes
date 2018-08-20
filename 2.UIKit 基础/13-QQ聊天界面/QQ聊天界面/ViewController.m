//
//  ViewController.m
//  QQ聊天界面
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "MessageFrameModel.h"
#import "MessageCell.h"
#import "MessageModel.h"

@interface ViewController () <UITableViewDataSource, UITextFieldDelegate, UIScrollViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property (nonatomic, strong) NSArray *messageFrames;
@property (nonatomic, strong) NSDictionary *autoReplayInfos;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (NSArray *)messageFrames {
    if (_messageFrames == nil) {
        _messageFrames = [MessageFrameModel messageFrames];
    }
    return _messageFrames;
}

- (NSDictionary *)autoReplayInfos {
    if (_autoReplayInfos == nil) {
        _autoReplayInfos = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoReplay" ofType:@"plist"]];
    }
    return _autoReplayInfos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    self.tableView.allowsSelection = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillChanges:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    // 设置输入框左边空白视图
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
//    self.inputTextField.leftView = view;
//    self.inputTextField.leftViewMode = UITextFieldViewModeAlways;
    self.inputTextField.delegate = self;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self addMessage:textField.text type:kMessageModelTypeMe];
    
    NSString *replayString = [self autoReplayWithContent:textField.text];
    [self addMessage:replayString type:kMessageModelTypeOther];
    
    [self.tableView reloadData];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    self.inputTextField.text = nil;
    
    return YES;
}

- (NSString *)autoReplayWithContent:(NSString *)content {
    NSString *result = nil;
    for (int i = 0; i < content.length; i++) {
        NSString *str = [content substringWithRange:NSMakeRange(i, 1)];
        // @"猪八戒";
        //   0 1 2
        result = self.autoReplayInfos[str];
        if (result != nil) {
            break;
        }
    }
    if (result == nil) {
        result = [NSString stringWithFormat:@"%@你个呵呵", content];
    }
    return result;
}

- (void)addMessage:(NSString *)content type:(kMessageModelType)type {
    MessageModel *previousMessage = (MessageModel *)[[self.messageFrames lastObject] message];
    
    MessageModel *message = [[MessageModel alloc] init];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // @"yyyy-MM-dd HH:mm:ss"
    formatter.dateFormat = @"HH:mm";
    NSString *time = [formatter stringFromDate:date];
    NSLog(@"date: %@", date);
    NSLog(@"time: %@", time);
    
    message.time = time;
    message.text = content;
    message.type = type;
    message.hiddenTime = [message.time isEqualToString:previousMessage.time];
    
    MessageFrameModel *mfm = [[MessageFrameModel alloc] init];
    mfm.message = message;
    [(NSMutableArray *)self.messageFrames addObject:mfm];
}

- (void)keyBoardWillChanges:(NSNotification *)notification {
    /**
     userInfo = {
     // 节奏
     UIKeyboardAnimationCurveUserInfoKey = 7;
     // 时间
     UIKeyboardAnimationDurationUserInfoKey = "0.25";
     // 键盘弹出时候的frame
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 264}, {320, 216}}";
     // 键盘隐藏时候的frame
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 480}, {320, 216}}";
     }}
     */
    // 键盘位置
    NSDictionary *dict  = notification.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    // 执行时间
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 移动距离
    CGFloat translationY = keyboardY - self.view.frame.size.height;
    [UIView animateWithDuration:duration delay:0.0 options:7 << 16 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, translationY);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [MessageCell cellWithTabelView:tableView];
    cell.messageFrame = self.messageFrames[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageFrameModel *mfm = self.messageFrames[indexPath.row];
    return mfm.cellHeight;
}

@end
