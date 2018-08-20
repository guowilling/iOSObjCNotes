
#import "DetialSecondCell.h"
#import "RecommendModel.h"

#define IntroduceFont 15.f
#define TitleFont 20.f

@interface DetialSecondCell () {
    
    UIImageView *_iconImageView;
    UILabel *_titleLabel;
    UILabel *_discussCount;
    UIView  *_lineView;
}

@end

@implementation DetialSecondCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *cellIndertifer = @"detialSecondCell";
    DetialSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndertifer];
    if (!cell) {
        cell = [[DetialSecondCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndertifer];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self setupContent];
        [self setViewAutoLayout];
    }
    return self;
}

- (void)setupContent {
    
    _iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:IntroduceFont];
    [self.contentView addSubview:_titleLabel];
    
    _discussCount = [[UILabel alloc] init];
    _discussCount.textAlignment = NSTextAlignmentRight;
    _discussCount.textColor = [UIColor lightGrayColor];
    _discussCount.backgroundColor = [UIColor clearColor];
    _discussCount.font = [UIFont systemFontOfSize:13.f];
    [self.contentView addSubview:_discussCount];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [AppTools colorWithHexString:@"#F0F0F0"];
    [self.contentView addSubview:_lineView];
}

- (void)setViewAutoLayout {
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.top.mas_equalTo(@13);
        make.size.mas_equalTo(CGSizeMake(34, 34));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right);
        make.top.equalTo(@20);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [_discussCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@(SCREEN_WIDTH - 30 - 100));
        make.top.equalTo(_titleLabel.mas_top);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - HMStatusCellMargin, 1));
        make.left.mas_equalTo(@(HMStatusCellMargin));
        make.top.equalTo(self.contentView.mas_bottom).offset(-1);
    }];
}

- (void)setModel:(RecommendModel *)model {
    
    _model = model;
    
    _discussCount.text = [NSString stringWithFormat:@"%@人",model.wisher_count];
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    _titleLabel.text = title;
    
    if ([title isEqualToString:@"即时讨论"]) {
        _iconImageView.image = [UIImage imageNamed:@"FavoritesActionSheetTextIcon"];
        _discussCount.hidden = NO;
    }else{
        _iconImageView.image = [UIImage imageNamed:@"FavoritesActionSheetLocatinIcon"];
        _discussCount.hidden = YES;
    }
}

+ (CGFloat)getCellHeight {
    
    return 60;
}

@end
