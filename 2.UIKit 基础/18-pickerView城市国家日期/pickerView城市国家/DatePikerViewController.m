//
//  DatePikerViewController.m
//  pickerView城市国家
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "DatePikerViewController.h"

@interface DatePikerViewController ()

@property (nonatomic, weak) UIDatePicker *datePicker;
@property (nonatomic, weak) UITextField  *brithdayFiled;

@end

@implementation DatePikerViewController

- (UITextField *)brithdayFiled {
    
    if (!_brithdayFiled) {
        UITextField *textFiled = [[UITextField alloc] init];
        textFiled.center = self.view.center;
        textFiled.bounds = CGRectMake(0, 0, 200, 44);
        textFiled.borderStyle = UITextBorderStyleRoundedRect;
        textFiled.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.4];
        [self.view addSubview:textFiled];
        _brithdayFiled = textFiled;
    }
    return _brithdayFiled;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    datePicker.datePickerMode = UIDatePickerModeDate;
    self.brithdayFiled.inputView = datePicker;
    _datePicker = datePicker;
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.bounds = CGRectMake(0, 0, 0, 44);
    toolbar.backgroundColor = [UIColor grayColor];
    UIBarButtonItem *previousBtn = [[UIBarButtonItem alloc] initWithTitle:@"上一步"
                                                                    style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *nextBtn = [[UIBarButtonItem alloc] initWithTitle:@"下一步"
                                                                style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem *springBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                style:UIBarButtonItemStylePlain target:self action:@selector(dateSelectDone)];
    toolbar.items = @[previousBtn, nextBtn, springBtn, doneBtn];
    self.brithdayFiled.inputAccessoryView = toolbar;
}

- (void)dateSelectDone {
    
    NSDate *selectedDate = self.datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:selectedDate];
    self.brithdayFiled.text = dateStr;
    [self.view endEditing:YES];
}

@end
