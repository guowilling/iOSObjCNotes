//
//  ViewController.m
//  注册界面
//
//  Created by 郭伟林 on 15/9/19.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "GWKeyboardTool.h"
#import "GWSexBox.h"
#import "GWCityPicker.h"

@interface ViewController () <GWKeyboardToolDelegate, GWCityPickerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView      *container;
@property (weak, nonatomic) IBOutlet UITextField *birthdayField;
@property (weak, nonatomic) IBOutlet UITextField *cityField;

@property (strong, nonatomic) UITextField    *currentField;

@property (strong, nonatomic) GWKeyboardTool *keyboardTool;

@property (strong, nonatomic) NSArray        *fields;

@end

@implementation ViewController

- (NSArray *)fields {
    
    if (!_fields) {
        _fields = [[NSArray alloc] init];
    }
    return _fields;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupKeyboardTool];
    
    [self setupSexBox];
    
    [self setupCustomKeyboard];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardFrameChange:)
                                                name:UIKeyboardWillChangeFrameNotification
                                              object:nil];
    
    [self.fields[0] becomeFirstResponder];
}

- (void)setupCustomKeyboard {
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self
                   action:@selector(datePickerChanged:)
         forControlEvents:UIControlEventValueChanged];
    self.birthdayField.inputView = datePicker;
    
    GWCityPicker *cityPicker = [GWCityPicker cityPicker];
    cityPicker.delegate = self;
    self.cityField.inputView = cityPicker;
}

- (void)setupSexBox {
    
    GWSexBox *sexBox = [GWSexBox sexBox];
    sexBox.center = CGPointMake(170, 75);
    [self.container addSubview:sexBox];
}

- (void)setupKeyboardTool {
    
    GWKeyboardTool *keyboardTool = [GWKeyboardTool keyboardTool];
    keyboardTool.delgate = self;
    self.keyboardTool = keyboardTool;
    
    NSMutableArray *arryM = [NSMutableArray array];
    for (UIView *view in self.container.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *field = (UITextField *)view;
            field.inputAccessoryView = keyboardTool;
            field.delegate = self;
            [arryM addObject:field];
        }
    }
    self.fields = arryM;
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardFrameChange:(NSNotification *)notification {
    
    CGRect kbRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat kbY = kbRect.origin.y;
    NSInteger currentResponderIndex = [self getCurrentResponderIndex];
    CGFloat maxY = CGRectGetMaxY([self.fields[currentResponderIndex] frame]) + self.container.frame.origin.y;
    if (kbY < maxY) {
        [UIView animateWithDuration:0.2 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, kbY - maxY - 20);
        }];
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark - GWKeyboardToolDelegate

- (void)keyboardTool:(GWKeyboardTool *)keyboardTool didClickItemType:(KeyboardItemType)itemType {
    
    NSInteger currentResponderIndex = [self getCurrentResponderIndex];
    if (itemType == KeyboardItemTypePrevious) {
        [self.fields[--currentResponderIndex] becomeFirstResponder];
    } else if (itemType == KeyboardItemTypeNext) {
        [self.fields[++currentResponderIndex] becomeFirstResponder];
    } else {
        [self.view endEditing:YES];
    }
}

- (NSInteger)getCurrentResponderIndex {
    
    for (UITextField *field in self.fields) {
        if (field.isFirstResponder) {
            return [self.fields indexOfObject:field];
        }
    }
    return -1;
    //return [self.fields indexOfObject:self.currentField];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:1.0 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

- (void)datePickerChanged:(UIDatePicker *)picker {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *date = [formatter stringFromDate:picker.date];
    self.birthdayField.text = date;
}

- (void)cityPickerChanged:(GWCityPicker *)cityPicker province:(NSString *)province city:(NSString *)city {
    
    self.cityField.text = [NSString stringWithFormat:@"%@-%@", province, city];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return (textField != self.birthdayField) && (textField != self.cityField);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.currentField = textField;
    
    NSInteger index = [self.fields indexOfObject:textField];
    self.keyboardTool.previousItem.enabled = (index != 0);
    self.keyboardTool.nextItem.enabled = (index != self.fields.count - 1);
}

@end
