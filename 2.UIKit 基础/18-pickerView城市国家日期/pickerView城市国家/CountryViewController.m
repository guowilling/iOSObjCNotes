//
//  CountryViewController.m
//  pickerView城市国家
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "CountryViewController.h"
#import "CountryModel.h"
#import "CountryView.h"

@interface CountryViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *countrys;

@property (nonatomic, weak) UIPickerView *pickerView;

@end

@implementation CountryViewController

- (NSArray *)countrys {
    
    if (!_countrys) {
        _countrys = [CountryModel countrys];
    }
    return _countrys;
}

- (UIPickerView *)pickerView {
    
    if (!_pickerView) {
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        pickerView.frame = CGRectMake(0, 200, screenW, 216);
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [self.view addSubview:pickerView];
        _pickerView = pickerView;
    }
    return _pickerView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self pickerView];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.countrys.count;
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    CountryView *countryView = (CountryView *)view;
    if (!countryView) {
        countryView = [CountryView countryView];
    }
    countryView.country = self.countrys[row];
    return countryView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return [CountryView rowHeight];
}

@end
