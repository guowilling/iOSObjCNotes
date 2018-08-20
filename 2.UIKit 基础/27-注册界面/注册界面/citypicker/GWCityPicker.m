//
//  ViewController.m
//  pickerView城市国家
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "GWCityPicker.h"
#import "Province.h"

@interface GWCityPicker () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *provinces;

@end

@implementation GWCityPicker

+ (instancetype)cityPicker {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
}

- (NSArray *)provinces {
    
    if (!_provinces) {
        _provinces = [Province provinces];
    }
    return _provinces;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (0 == component) {
        return self.provinces.count;
    } else {
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
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

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (0 == component) {
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        Province *province = self.provinces[row];
        NSString *provinceName = province.name;
        NSString *cityName = province.cities[0];
        if ([_delegate respondsToSelector:@selector(cityPickerChanged:province:city:)]) {
            [_delegate cityPickerChanged:self province:provinceName city:cityName];
        }
    } else {
        NSInteger selectedRow = [pickerView selectedRowInComponent:0];
        Province *province = self.provinces[selectedRow];
        NSString *provinceName = province.name;
        NSString *cityName = province.cities[row];
        if ([_delegate respondsToSelector:@selector(cityPickerChanged:province:city:)]) {
            [_delegate cityPickerChanged:self province:provinceName city:cityName];
        }
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (component == 0) {
        return 150;
    }
    return 100;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 44;
}

@end
