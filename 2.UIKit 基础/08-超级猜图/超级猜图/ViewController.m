//
//  ViewController.m
//  超级猜图
//
//  Created by 郭伟林 on 15/9/16.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "Question.h"

#define kButtonWidth    35
#define kButtonHeight   35
#define kButtonMargin   10
#define kColCount       7

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *scoreButton;
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *optionsView;

@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, strong) UIButton *cover;
@property (nonatomic, assign) NSInteger index;

@end

@implementation ViewController

#pragma mark - 懒加载
- (NSArray *)questions {
    if (_questions == nil) {
        _questions = [Question questions];
        NSLog(@"questions: %@", _questions);
    }
    return _questions;
}

- (UIButton *)cover {
    if (_cover == nil) {
        _cover = [[UIButton alloc] initWithFrame:self.view.bounds];
        _cover.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        [self.view addSubview:_cover];
        _cover.alpha = 0.0;
        [_cover addTarget:self action:@selector(bigOrSmall) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cover;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.index = -1;
    [self nextBtnClick];
}

- (IBAction)tipBtnClick {
    if ([[self.answerView.subviews[0] currentTitle] isEqualToString:[[self.questions[self.index] answer] substringToIndex:1]]) { // 已经点击过直接返回
        return;
    }
    for (UIButton *btn in self.answerView.subviews) { // 清空答案区按钮
        [self answerBtnClick:btn];
    }
    Question *question = self.questions[self.index];
    NSString *first = [question.answer substringToIndex:1];
    UIButton *btn = [self optionBtnWithTitle:first isHidden:NO];
    [self optionBtnClick:btn];
    [self changeScore:-1000];
}

- (IBAction)bigOrSmall {
    if (self.cover.alpha == 0.0) { // 放大
        [self.view bringSubviewToFront:self.iconButton];
        CGFloat w = self.view.bounds.size.width;
        CGFloat h = w;
        CGFloat y = (self.view.bounds.size.height - h) * 0.5;
        [UIView animateWithDuration:1.0f animations:^{ // autolayout环境下下面代码无效果!
            self.iconButton.frame = CGRectMake(0, y, w, h);
            self.cover.alpha = 1.0;
        }];
    } else { // 恢复
        [UIView animateWithDuration:1.0 animations:^{
            self.iconButton.frame = CGRectMake(85, 131, 205, 200);
            self.cover.alpha = 0.0;
        }];
    }
}

- (IBAction)nextBtnClick {
    self.index++;
    if (self.index == self.questions.count) {
        NSLog(@"通关了");
        return;
    }
    
    Question *question = self.questions[self.index];
    [self setupBasicInfo:question];
    [self createAnswerButtons:question];
    [self createOptionButtons:question];
}

- (void)setupBasicInfo:(Question *)question {
    self.numLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.index + 1, self.questions.count];
    //self.iconButton.imageView.image = question.image;
    [self.iconButton setImage:question.image forState:UIControlStateNormal];
    if (self.index == 9) {
        self.nextBtn.enabled = NO;
    }
}

- (void)createAnswerButtons:(Question *)question {
    // 清除答案区上一题留下的按钮
//    for (UIView *view in self.answerView.subviews) {
//        [view removeFromSuperview];
//    }
    [self.answerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 创建答案区的按钮
    CGFloat answerViewW = self.answerView.bounds.size.width;
    NSInteger length = question.answer.length;
    CGFloat answerX = (answerViewW - kButtonWidth * length - kButtonMargin * (length - 1)) * 0.5;
    for (int i = 0; i < length; i++) {
        CGFloat x = answerX + i * (kButtonWidth + kButtonMargin);
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, kButtonWidth, kButtonHeight)];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        // 按钮标题默认为白色
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(answerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.answerView addSubview:btn];
    }
}

- (void)createOptionButtons:(Question *)question {
    // 问题: 每次调用下一题方法时都会重新创建21个按钮
    // 解决: 如果按钮已经存在并且是21个只需要更改按钮标题即可
    if (self.optionsView.subviews.count != question.options.count) {
        for (UIView *view in self.optionsView.subviews) {
            [view removeFromSuperview];
        }
        NSLog(@"创建候选区按钮");
        CGFloat optionViewW = self.optionsView.bounds.size.width;
        CGFloat optionX = (optionViewW - kColCount * kButtonWidth - (kColCount - 1) * kButtonMargin) * 0.5;
        for (int i = 0; i < question.options.count; i++) {
            int row = i / kColCount;
            int col = i % kColCount;
            CGFloat x = optionX + col * (kButtonMargin + kButtonWidth);
            CGFloat y = 12.5 + row * (kButtonMargin + kButtonHeight);
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, kButtonWidth, kButtonHeight)];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_option_highlighted"] forState:UIControlStateHighlighted];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(optionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.optionsView addSubview:btn];
        }
    }
    
    // 设置每个按钮标题
    int i = 0;
    for (UIButton *btn in self.optionsView.subviews) {
        [btn setTitle:question.options[i++] forState:UIControlStateNormal];
        btn.hidden = NO;
    }
}

- (void)optionBtnClick:(UIButton *)btn {
    UIButton *answerBtn = [self firstAnswerbtn];
    if (answerBtn == nil) { // 答题区所有按钮都有标题
        [self judge];
    } else {
        [answerBtn setTitle:btn.currentTitle forState:UIControlStateNormal];
        btn.hidden = YES;
    }
    [self judge];
}

/**
 *  返回答题区第一个标题为空的按钮
 */
- (UIButton *)firstAnswerbtn {
    for (UIButton *btn in self.answerView.subviews) {
        if (btn.currentTitle.length == 0) {
            return btn;
        }
    }
    return nil;
}

- (void)judge {
    // 遍历答题区的所有按钮拼接答案字符串
    BOOL isFull = YES;
    NSMutableString *stringM = [NSMutableString string];
    for (UIButton *btn in self.answerView.subviews) {
        if (btn.currentTitle.length == 0) {
            isFull = NO;
            break;
        } else {
            [stringM appendString:btn.currentTitle];
        }
    }
    
    if (isFull) {
        Question *question = self.questions[self.index];
        if ([stringM isEqualToString:question.answer]) {
            NSLog(@"答对了");
            [self setAnswerBtnsColor:[UIColor blueColor]];
            [self changeScore:1000];
            [self performSelector:@selector(nextBtnClick) withObject:nil afterDelay:0.5];
        } else {
            NSLog(@"答错了");
            [self setAnswerBtnsColor:[UIColor redColor]];
        }
    }
}

- (void)setAnswerBtnsColor:(UIColor *)color {
    for (UIButton *btn in self.answerView.subviews) {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
}

- (void)answerBtnClick:(UIButton *)button {
    // 如果按钮标题为空直接返回
    if (button.currentTitle.length == 0) {
        return;
    }
    
    [button setTitle:@"" forState:UIControlStateNormal];
    // 根据答案区按钮的标题找到候选区对应的按钮(可能有两个相同标题按钮, 但是隐藏状态的只可能有一个)
    UIButton *optionBtn = [self optionBtnWithTitle:button.currentTitle isHidden:YES];
    optionBtn.hidden = NO;
    
    [self setAnswerBtnsColor:[UIColor blackColor]];
}

- (UIButton *)optionBtnWithTitle:(NSString *)title isHidden:(BOOL)isHidden {
    for (UIButton *btn in self.optionsView.subviews) {
        if ([btn.currentTitle isEqualToString:title] && btn.isHidden == isHidden) {
            return btn;
        }
    }
    return nil;
}

- (void)changeScore:(NSInteger)score {
    int currentScore = self.scoreButton.currentTitle.intValue;
    currentScore += score;
    [self.scoreButton setTitle:[NSString stringWithFormat:@"%zd", currentScore] forState:UIControlStateNormal];
}

@end
