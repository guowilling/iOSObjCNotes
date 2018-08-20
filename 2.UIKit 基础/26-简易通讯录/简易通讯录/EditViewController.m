//
//  EditViewController.m
//  简易通讯录
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "EditViewController.h"
#import "Contact.h"

@interface EditViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UIButton    *saveBtn;

@end

@implementation EditViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.nameField.text   = self.contact.name;
    self.numberField.text = self.contact.number;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.numberField];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textChange {
    
    self.saveBtn.enabled = (self.nameField.text.length > 0 && self.numberField.text.length > 0);
}

- (IBAction)saveBtnClick {
    
    self.contact.name   = self.nameField.text;
    self.contact.number = self.numberField.text;
    if ([self.delegate respondsToSelector:@selector(editViewControllerDidClickSaveBtn: contact:)]) {
        [self.delegate editViewControllerDidClickSaveBtn:self contact:self.contact];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)editBtnClick:(UIBarButtonItem *)sender {
    
    if (!self.numberField.enabled) {
        self.nameField.enabled   = YES;
        self.numberField.enabled = YES;
        self.saveBtn.hidden      = NO;
        sender.title             = @"取消";
        [self.numberField becomeFirstResponder];
    } else {
        self.nameField.enabled   = NO;
        self.numberField.enabled = NO;
        self.saveBtn.hidden      = YES;
        self.nameField.text      = self.contact.name;
        self.numberField.text    = self.contact.number;
        sender.title             = @"编辑";
        [self.view endEditing:YES];
    }
}

@end
