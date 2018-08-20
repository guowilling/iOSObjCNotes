
#import "HotCityCell.h"
#import "HotCityModel.h"
#import "RecommendHttpTool.h"
#import "CityHelper.h"

@interface HotCityCell () {
    
    NSMutableArray *_hotCities;
}

@end

@implementation HotCityCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *cellIndertifer = @"hotCityCell";
    HotCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[HotCityCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = KBackgroundColor;
      
        [CityHelper getHotCitiesInfo:^(NSMutableArray *resultArray) {
            _hotCities = resultArray;
        }];
        
        [self setupContent];
    }
    return self;
}

- (void)setupContent {
    
    CGFloat padding = 10;
    CGFloat margin = (SCREEN_WIDTH - 3 * HotCityButtonWith - 30) / 2;
    for (int i = 0; i< _hotCities.count; i++) {
        HotCityModel *cityModel = _hotCities[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.tag = i ;
        btn.layer.borderWidth = 0.5;
        btn.layer.cornerRadius = 5;
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:cityModel.name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i <= 2) {
            btn.frame = CGRectMake(HMStatusCellMargin + i * (HotCityButtonWith + margin), padding, HotCityButtonWith, HotCityButtonHeight);
        } else {
            int j = i % 3;
            int k = i / 3;
            btn.frame = CGRectMake(HMStatusCellMargin + j * (HotCityButtonWith + margin), padding + k * (HotCityButtonHeight + padding), HotCityButtonWith, HotCityButtonHeight);
        }
        [self.contentView addSubview:btn];
    }
}

- (void)btnAction:(UIButton *)sender {
    
    HotCityModel *cityModel = _hotCities[sender.tag];
    if ([_delegate respondsToSelector:@selector(hotCityCellDidSelectCity:)]) {
        [_delegate hotCityCellDidSelectCity:cityModel.name];
    }
}

+ (CGFloat)getCellHeight {
    
    return HotCityButtonMargin * 5 + HotCityButtonHeight * 4;
}

@end
