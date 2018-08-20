//
//  ViewController.m
//  手势识别器(缩放旋转拖拽)
//
//  Created by 郭伟林 on 15/9/21.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    NSLog(@"%@ / %@", gestureRecognizer.class, otherGestureRecognizer.class);
    return YES;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.imageView.userInteractionEnabled = YES;
    
    // 拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:pan];
    
    // 旋转手势识别器
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] init];
    [rotation addTarget:self action:@selector(rotation:)];
    rotation.delegate = self;
    [self.imageView addGestureRecognizer:rotation];
    
    // 缩放手势识别器
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] init];
    [pinch addTarget:self action:@selector(pinch:)];
    rotation.delegate = self;
    [self.imageView addGestureRecognizer:pinch];
}

- (void)pan:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    CGPoint point = [panGestureRecognizer translationInView:panGestureRecognizer.view];
    NSLog(@"本次拖拽距离: %@", NSStringFromCGPoint(point));
    CGPoint temp = self.imageView.center;
    temp.x += point.x;
    temp.y += point.y;
    self.imageView.center = temp;
    // 清空panGestureRecognizer的translation
    [panGestureRecognizer setTranslation:CGPointZero inView:panGestureRecognizer.view];
}

- (void)rotation:(UIRotationGestureRecognizer *)rotationGestureRecognizer {
    
    NSLog(@"本次旋转弧度: %.2f", rotationGestureRecognizer.rotation);
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotationGestureRecognizer.rotation);
    // 清空rotationGestureRecognizer的rotation
    rotationGestureRecognizer.rotation = 0;
}

- (void)pinch:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
    
    NSLog(@"本次缩放比例: %.2f", pinchGestureRecognizer.scale);
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    // 清空pinchGestureRecognizer的scale
    pinchGestureRecognizer.scale = 1.0;
}

@end
