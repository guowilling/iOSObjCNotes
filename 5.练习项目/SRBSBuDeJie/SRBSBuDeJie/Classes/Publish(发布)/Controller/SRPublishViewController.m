//
//  SRPublishViewController.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRPublishViewController.h"
#import <POP.h>

static CGFloat const SRSpringFactor = 0.1;

@interface SRPublishViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *sloganView;
@property (nonatomic, weak) IBOutlet UIView *buttonsContainer;

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation SRPublishViewController

#pragma mark - Lazy load

- (UIDynamicAnimator *)animator {
    
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view]; // ReferenceView 参照视图也就是仿真范围
    }
    return _animator;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self showButton];
}

- (void)showButton {
    
    for (int i = 0; i < self.buttonsContainer.subviews.count; i++) {
        UIButton *button = self.buttonsContainer.subviews[i];
        button.tag = i;
        [self setupButtonLayerAnimation:button.layer
                  propertyAnimationName:kPOPLayerOpacity
                              fromValue:@(0)
                                toValue:@(1.0)
                       springBounciness:0.1
                            springSpeed:1
                             begingTime:CACurrentMediaTime() + SRSpringFactor * i];
        
        [self setupButtonLayerAnimation:button.layer
                  propertyAnimationName:kPOPLayerScaleXY
                              fromValue:[NSValue valueWithCGSize:CGSizeMake(0.5f, 0.5f)]
                                toValue:[NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)]
                       springBounciness:18
                            springSpeed:1
                             begingTime:CACurrentMediaTime() + SRSpringFactor * i];
        
        [self setupButtonLayerAnimation:button.layer
                  propertyAnimationName:kPOPLayerPositionY
                              fromValue:@(0)
                                toValue:@(button.layer.position.y)
                       springBounciness:12
                            springSpeed:1
                             begingTime:CACurrentMediaTime() + SRSpringFactor * i];
        
        [button addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setupButtonLayerAnimation:(CALayer *)layer
            propertyAnimationName:(NSString *)name
                        fromValue:(id) fromValue
                          toValue:(id) toValue
                 springBounciness:(CGFloat)springBounciness
                      springSpeed:(CGFloat)springSpeed
                       begingTime:(CFTimeInterval)beginTime
{
    POPSpringAnimation *layerPositionAnimation = [POPSpringAnimation animationWithPropertyNamed:name];
    layerPositionAnimation.fromValue = fromValue;
    layerPositionAnimation.toValue = toValue;
    layerPositionAnimation.springBounciness = springBounciness;
    layerPositionAnimation.springSpeed = springSpeed;
    layerPositionAnimation.beginTime = beginTime;
    [layer pop_addAnimation:layerPositionAnimation forKey:nil];
}

#pragma mark - Monitor method

- (void)buttonOnClick:(UIButton *)btn {
    
    SRLog(@"%@", btn.titleLabel.text);
}

- (IBAction)cancelBtnOnClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
