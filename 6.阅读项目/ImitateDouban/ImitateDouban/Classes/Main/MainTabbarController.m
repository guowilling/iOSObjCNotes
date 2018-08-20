
#import "MainTabbarController.h"
#import "MainNavgationController.h"
#import "MeViewController.h"
#import "RecommendViewController.h"
#import "MovieViewController.h"

@implementation MainTabbarController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addAllChildViewControllers];
}

- (void)addAllChildViewControllers{

    NSArray *buttonImages = @[@"tabbar_discover",
                              @"tabbar_mainframe",
                              @"tabbar_contacts",
                              @"tabbar_me"];
    
    NSArray *buttonImagesSelected = @[@"tabbar_discoverHL",
                                      @"tabbar_mainframeHL",
                                      @"tabbar_contactsHL",
                                      @"tabbar_meHL"];
    
    [self addChildViewController:[[RecommendViewController alloc] init]
                           title:@"同城"
                        tabImage:buttonImages[0]
                tabSelectedImage:buttonImagesSelected[0]];
    
    [self addChildViewController:[[MovieViewController alloc] init]
                           title:@"电影"
                        tabImage:buttonImages[1]
                tabSelectedImage:buttonImagesSelected[1]];
    
    [self addChildViewController:[[MeViewController alloc] init]
                           title:@"我"
                        tabImage:buttonImages[3]
                tabSelectedImage:buttonImagesSelected[3]];
}

- (void)addChildViewController:(UIViewController *)childController
                         title:(NSString *)title
                      tabImage:(NSString *)tabImage
              tabSelectedImage:(NSString *)tabSelectedImage
{
    childController.title = title;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}
                                             forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],
                                                       NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateSelected];
    
    childController.tabBarItem.image = [[UIImage imageNamed:tabImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:tabSelectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MainNavgationController *mainNavC = [[MainNavgationController alloc] initWithRootViewController:childController];
    [self addChildViewController:mainNavC];
}

@end
