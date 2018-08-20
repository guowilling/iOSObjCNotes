
#import "CityCell.h"

@interface CityCell () {
    
    UILabel *_cityLabel;
    UIView  *_line;
}

@end

@implementation CityCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *cellIndertifer = @"cityCell";
    CityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[CityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        _cityLabel = [[UILabel alloc] init];
        _cityLabel.backgroundColor = [UIColor clearColor];
        _cityLabel.textColor = [UIColor blackColor];
        _cityLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:_cityLabel];
        
        _line = [[UIView alloc] init];
        _line.backgroundColor = [AppTools colorWithHexString:@"#F0F0F0"];
        [self.contentView addSubview:_line];
        
        [_cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(HMStatusCellMargin);
            make.top.equalTo(self.contentView).offset(HMStatusCellMargin);
            make.width.mas_equalTo(@(SCREEN_WIDTH - 30));
            make.height.mas_equalTo(@20);
        }];
        
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - 15, 0.8));
            make.left.mas_equalTo(@15);
            make.top.equalTo(self.contentView.mas_bottom).offset(-0.8);
        }];
    }
    return self;
}

- (void)setCityName:(NSString *)cityName {
    
    _cityName = cityName;
    
    _cityLabel.text = cityName;
}

+ (CGFloat)getCellHeight {
    
    return 50;
}

@end
