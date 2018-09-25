//
//  ViewController.h
//  pickerView城市国家
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GWCityPicker;

@protocol GWCityPickerDelegate <NSObject>

- (void)cityPickerChanged:(GWCityPicker *)cityPicker province:(NSString *)province city:(NSString *)city;

@end

@interface GWCityPicker : UIView

+ (instancetype)cityPicker;

@property (nonatomic, weak) id<GWCityPickerDelegate> delegate;

@end

