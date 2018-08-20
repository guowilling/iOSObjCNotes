
#import "YLYSearchBar.h"

@implementation YLYSearchBar

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentLeft;
        self.placeholder = @"输入城市名查询";
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        imageView.frame = CGRectMake(0, 0, 30, 30);
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        
        self.font = [UIFont systemFontOfSize:15.0f];
    }
    return self;
}

@end
