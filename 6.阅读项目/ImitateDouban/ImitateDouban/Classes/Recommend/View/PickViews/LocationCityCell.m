
#import "LocationCityCell.h"
#import "LocationHelper.h"

@interface LocationCityCell () {
    
    UIButton *_locationBtn;
}

@property (nonatomic, copy) NSString *cityName;

@end

@implementation LocationCityCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *cellIndertifer = @"locationCityCell";
    LocationCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[LocationCityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KBackgroundColor;
    
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationBtn.layer.borderColor  = [UIColor lightGrayColor].CGColor;
        _locationBtn.layer.borderWidth  = 0.4;
        _locationBtn.layer.cornerRadius = 5;
        _locationBtn.backgroundColor = [UIColor whiteColor];
        _locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
        [_locationBtn setTitle:@"正在定位" forState:UIControlStateNormal];
        [_locationBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_locationBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_locationBtn setImage:[UIImage imageNamed:@"AlbumLocationIconHL"]
                      forState:UIControlStateNormal];
        [_locationBtn addTarget:self action:@selector(locationBtnAction:)
               forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_locationBtn];
        [_locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(HotCityButtonMargin);
            make.left.mas_equalTo(HMStatusCellMargin);
            make.size.mas_equalTo(CGSizeMake(HotCityButtonWith, HotCityButtonHeight));
        }];
        
        [self beginLocation];
    }
    return self;
}

- (void)beginLocation {
    
    LocationHelper *manager = [LocationHelper sharedLocationManager];
    __weak LocationCityCell *weekSelf = self;
    [manager currentLocation:^(CLLocation *currentLocation, NSString *cityName) {
        weekSelf.cityName = cityName;
        [_locationBtn setTitle:cityName forState:UIControlStateNormal];
    }];
}

- (void)locationBtnAction:(UIButton *)sender {
    
    if (self.cityName) {
        if ([_delegate respondsToSelector:@selector(locationCityCellDidSelectCity:)]) {
            [_delegate locationCityCellDidSelectCity:self.cityName];
        }
    }
}

+ (CGFloat)getCellHeight {
    
    return 2 * HotCityButtonMargin + HotCityButtonHeight;
}

@end
