//
//  ViewController.m
//  计算器
//
//  Created by 郭伟林 on 15/9/15.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *numberOne;
@property (weak, nonatomic) IBOutlet UITextField *numberTwo;
@property (weak, nonatomic) IBOutlet UILabel *result;

- (IBAction)calculate:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculate:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1:
        {
            int result = [self.numberOne.text intValue] + [self.numberTwo.text intValue];
            self.result.text = [NSString stringWithFormat:@"%d", result];
        }
            break;
        case 2:
        {
            int result = [self.numberOne.text intValue] - [self.numberTwo.text intValue];
            self.result.text =[NSString stringWithFormat:@"%d", result];
        }
            break;
        case 3:
        {
            int result = [self.numberOne.text intValue] * [self.numberTwo.text intValue];
            self.result.text = [NSString stringWithFormat:@"%d", result];
            break;
        }
        case 4:
        {
            if ([self.numberTwo.text intValue] == 0) {
                break;
            }
            int result = [self.numberOne.text intValue] / [self.numberTwo.text intValue];
            self.result.text =[NSString stringWithFormat:@"%d", result];
        }
            break;
        default:
            break;
    }

    //[self.num1 resignFirstResponder];
    //[self.num2 resignFirstResponder];
    [self.view endEditing:YES];
}

@end
