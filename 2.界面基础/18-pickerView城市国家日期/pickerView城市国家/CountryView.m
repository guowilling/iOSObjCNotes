//
//  CountryView.m
//  pickerView城市国家
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "CountryView.h"
#import "CountryModel.h"

@interface CountryView ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CountryView

+ (instancetype)countryView {
    
    return [[[NSBundle mainBundle] loadNibNamed:@"CountryView" owner:nil options:nil] lastObject];
}

-(void)setCountry:(CountryModel *)country {
    
    _country = country;
    
    self.label.text = country.name;
    self.imageView.image = [UIImage imageNamed:country.icon];
}

+ (CGFloat)rowHeight {
    
    return 44;
}

@end
