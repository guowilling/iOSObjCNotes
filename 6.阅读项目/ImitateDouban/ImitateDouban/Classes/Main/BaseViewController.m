
#import "BaseViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface BaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    [self setupNavBar];
}

- (void)setupNavBar {
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithImage:@"nav_arrow"
                                               higlightedImage:@"nav_arrow"
                                                        target:self
                                                        action:@selector(backAction)];
    UIBarButtonItem *placeholderItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    placeholderItem.width = -15;
    self.navigationItem.leftBarButtonItems = @[placeholderItem, backItem];
}

- (void)backAction {
    
    if ([self.navigationController respondsToSelector:@selector(popViewControllerAnimated:)]){
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    if ([self respondsToSelector:@selector(dismissModalViewControllerAnimated:)]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
