//
//  SRCategoryViewController.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/4.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRCategoryViewController.h"
#import "SRRaidersViewController.h"
#import "SRGiftsViewController.h"
#import "SRSearchViewController.h"

@interface SRCategoryViewController ()

@property (nonatomic, weak) SRRaidersViewController *raidersVC;
@property (nonatomic, weak) SRGiftsViewController   *giftsVC;

@end

@implementation SRCategoryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupChildControllers];
    
    [self setupNavBar];
}

- (void)setupChildControllers {
    
    SRRaidersViewController *raidersVC = [[SRRaidersViewController alloc] init];
    [self addChildViewController:raidersVC];
    self.raidersVC = raidersVC;
    
    SRGiftsViewController *giftsVC = [[SRGiftsViewController alloc] init];
    [self addChildViewController:giftsVC];
    self.giftsVC = giftsVC;
}

- (void)setupNavBar {
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"攻略", @"礼物"]];
    segmentedControl.sr_width += 120;
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedControlOnClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(findAction) norImage:@"find" highImage:nil];
    
    [self segmentedControlOnClick:segmentedControl];
}

- (void)segmentedControlOnClick:(UISegmentedControl *)segmentedControl {
    
    if (segmentedControl.selectedSegmentIndex == 0) {
        self.raidersVC.view.frame = self.view.bounds;
        [self.view addSubview:self.raidersVC.view];
    } else {
        self.giftsVC.view.frame = self.view.bounds;
        [self.view addSubview:self.giftsVC.view];
    }
}

- (void)findAction {
    
    SRSearchViewController *searchVC = [[SRSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

@end
