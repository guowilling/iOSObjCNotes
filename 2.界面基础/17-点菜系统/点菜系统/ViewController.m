//
//  ViewController.m
//  点菜系统
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *foods;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UILabel *fruitLable;
@property (weak, nonatomic) IBOutlet UILabel *stapleLabel;
@property (weak, nonatomic) IBOutlet UILabel *drinkLabel;

@end

@implementation ViewController

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (NSArray *)foods {
    
    if (!_foods) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"foods.plist" ofType:nil];
        _foods = [NSArray arrayWithContentsOfFile:path];
        NSLog(@"%@", _foods);
    }
    return _foods;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    for (NSInteger component = 0; component < self.foods.count; component++) {
        [self pickerView:self.pickerView didSelectRow:0 inComponent:component];
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return self.foods.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.foods[component] count];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.foods[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSString *title = self.foods[component][row];
    if (component == 0) {
        self.fruitLable.text = title;
    } else if (component == 1) {
        self.stapleLabel.text = title;
    } else if (component == 2) {
        self.drinkLabel.text = title;
    }
}

- (IBAction)random {
    
//     [self.pickerView selectRow: arc4random() % [self.foods[0] count] inComponent:0 animated:YES];
//     [self.pickerView selectRow: arc4random() % [self.foods[1] count] inComponent:1 animated:YES];
//     [self.pickerView selectRow: arc4random() % [self.foods[2] count] inComponent:2 animated:YES];
    for (int component = 0; component < self.foods.count; component++) {
        NSInteger oldRow = [self.pickerView selectedRowInComponent:component];
        NSInteger newRow = arc4random() % [self.foods[component] count];
        while (newRow == oldRow) {
            newRow = arc4random() % [self.foods[component] count];
        }
        [self.pickerView selectRow:newRow inComponent:component animated:YES];
        [self pickerView:self.pickerView didSelectRow:newRow inComponent:component];
    }
}

@end
