
#import "CategoryTableView.h"
#import "CategoryCell.h"

@interface CategoryTableView() <UITableViewDataSource, UITableViewDelegate> {
    
    NSArray *_categoryNameArray;
    NSArray *_categoryImageArray;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CategoryTableView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initTableView:frame];
        [self initDatas];
        [_tableView reloadData];
    }
    return self;
}

- (void)initDatas {
    
    _categoryNameArray = [[NSArray alloc] initWithObjects:@"热门", @"音乐", @"戏剧", @"展览", @"讲座", @"聚会", @"运动", @"旅行", @"公益", @"电影", nil];
    _categoryImageArray = [[NSArray alloc] initWithObjects:@"type-meet", @"type-polaroid-socialmatic", @"type-radio-4", @"type-sharpner", @"type-support", @"type-sunglasses", @"type-nike-dunk", @"type-snowman", @"power-plant", @"type-pan", nil];
}

- (void)initTableView:(CGRect)frame {
    
    _tableView                 = [[UITableView alloc] initWithFrame:frame];
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _categoryNameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [CategoryCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CategoryCell *cell = [CategoryCell cellWithTableView:tableView];
    cell.title = [_categoryNameArray objectAtIndex:indexPath.row];
    cell.imageName = [_categoryImageArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *categoryName = [_categoryNameArray objectAtIndex:indexPath.row];
    if ([_delegate respondsToSelector:@selector(categoryTableViewDidSelectCategory:)]) {
        [_delegate categoryTableViewDidSelectCategory:categoryName];
    }
}

@end
