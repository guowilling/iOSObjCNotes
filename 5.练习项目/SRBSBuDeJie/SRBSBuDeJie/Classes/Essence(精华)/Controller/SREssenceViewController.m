//
//  SREssenceViewController.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SREssenceViewController.h"
#import "SRTopicViewController.h"
#import "SRTagRecommendController.h"

@interface SREssenceViewController ()

@property (nonatomic, weak) IBOutlet UIView *titleView;
@property (nonatomic, weak) IBOutlet UIView *redView;

@property (nonatomic, strong) UIViewController *currentVC;

@end

@implementation SREssenceViewController

- (UIViewController *)currentVC {
    
    if (!_currentVC) {
        _currentVC = self.childViewControllers[0];
    }
    return _currentVC;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupNavBar];
    
    [self setupChildViewControllers];

    //[self.view insertSubview:self.currentVC.view atIndex:0]; // Notice: here is too early.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.view insertSubview:self.currentVC.view atIndex:0];
}

- (void)setupNavBar {
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MainTagSubIcon"]
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(tagRecommend)];
}

- (void)setupChildViewControllers {
    
    [self addChildViewController:[[SRTopicViewController alloc] init] type:SRTopicTypePicture];
    [self addChildViewController:[[SRTopicViewController alloc] init] type:SRTopicTypeVideo];
    [self addChildViewController:[[SRTopicViewController alloc] init] type:SRTopicTypeVoice];
    [self addChildViewController:[[SRTopicViewController alloc] init] type:SRTopicTypeAll];
    [self addChildViewController:[[SRTopicViewController alloc] init] type:SRTopicTypeText];
}

- (void)addChildViewController:(SRTopicViewController *)childController type:(SRTopicType)type {
    
    childController.type = type;
    [self addChildViewController:childController];
}

#pragma mark - Monitor method

- (void)tagRecommend {
    
    SRTagRecommendController *tagRecommendController = [[SRTagRecommendController alloc] init];
    [self.navigationController pushViewController:tagRecommendController animated:YES];
}

- (IBAction)titleBtnClick:(UIButton *)btn {
    
    UIViewController *nextVC = self.childViewControllers[btn.tag];
    if (self.currentVC == nextVC) {
        return;
    }
    
    [self transitionFromViewController:self.currentVC
                      toViewController:nextVC
                              duration:0.25
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                self.redView.transform = CGAffineTransformMakeTranslation(btn.tag * self.redView.sr_width, 0);
                            }
                            completion:^(BOOL finished) {
                                self.currentVC = nextVC;
                            }];
    [self.view bringSubviewToFront:self.titleView];
}

@end
