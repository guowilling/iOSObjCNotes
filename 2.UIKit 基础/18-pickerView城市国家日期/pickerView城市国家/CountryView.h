//
//  CountryView.h
//  pickerView城市国家
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CountryModel;

@interface CountryView : UIView

@property (nonatomic, strong) CountryModel *country;

+ (instancetype)countryView;

+ (CGFloat)rowHeight;

@end
