//
//  AddViewController.m
//  简易通讯录
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "AddViewController.h"
#import "Contact.h"

@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UIButton    *addBtn;

@end

@implementation AddViewController

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.numberField];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self.nameField becomeFirstResponder];
}

- (void)textChange {
    
    self.addBtn.enabled = (self.numberField.text.length > 0) && (self.numberField.text.length > 0);
}

- (IBAction)addBtnClick {
    
    Contact *contact = [[Contact alloc] init];
    contact.name =self.nameField.text;
    contact.number = self.numberField.text;
    if ([self.delegate respondsToSelector:@selector(addViewControllerDidClickAddBtn:contact:)]) {
        [self.delegate addViewControllerDidClickAddBtn:self contact:contact];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
