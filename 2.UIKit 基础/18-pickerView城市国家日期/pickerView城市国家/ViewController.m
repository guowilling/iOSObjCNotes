//
//  ViewController.m
//  pickerView城市国家
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "Province.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *provinces;

@property (nonatomic, weak) UIPickerView *cityPickerView;

@end

@implementation ViewController

- (NSArray *)provinces {
    
    if (_provinces == nil) {
        _provinces = [Province provinces];
    }
    return _provinces;
}

- (UIPickerView *)cityPickerView {
    
    if (_cityPickerView == nil) {
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        pickerView.frame = CGRectMake(0, 200, screenW, 216);
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [self.view addSubview:pickerView];
        _cityPickerView = pickerView;
    }
    return _cityPickerView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self cityPickerView];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (0 == component) {
        return self.provinces.count;
    } else {
        NSInteger selectedRow = [self.cityPickerView selectedRowInComponent:0];
        Province *province = self.provinces[selectedRow];
        return province.cities.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (0 == component) {
        Province *province = self.provinces[row];
        return province.name;
    } else {
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
        Province *province = self.provinces[selectedRow];
        return province.cities[row];
    }
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    
//    UILabel *label = nil;
//    if (view != nil) {
//        label = (UILabel *)view;
//    } else {
//        label = [[UILabel alloc] init];
//    }
//    if (component == 0) {
//        Province *province = self.provinces[row];
//        label.text = province.name;
//        label.backgroundColor = [UIColor grayColor];
//    } else {
//        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
//        Province *province = self.provinces[selectedRow];
//        label.text = province.cities[row];
//        label.backgroundColor = [UIColor purpleColor];
//    }
//    return label;
//}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (0 == component) {
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    
//    if (component == 0) {
//        return 150;
//    } else {
//        return 100;
//    }
//}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 44;
}

@end
