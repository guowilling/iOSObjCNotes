
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import <Masonry.h>
#import "TMPieView.h"
#import "ConstDefine.h"

const NSTimeInterval animationTime = 1.0f;

@interface TMPieView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *containerLayer;
@property (nonatomic, assign, getter=isCompleteAnimation) BOOL completeAnimation;

@end

@implementation TMPieView

- (void)dealloc {
    
    [self.shapeLayer removeAllAnimations];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _spacing = 5;
        _lineWidth = 5;
        _animationStrokeColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self drawPieWithAnimation];
}

- (void)drawPieWithAnimation {
    
    self.containerLayer = nil;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.height/2];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor whiteColor].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:layer];
    self.containerLayer = layer;
    
    NSUInteger count = self.sections.count;
    float total = 0.0,starAngle = M_PI/2,endAngle;
    for (NSInteger i=0; i<count; i++) {
        total += [self.sections[i] floatValue];
    }
    CGPoint center = CGPointMake(self.bounds.origin.x + self.bounds.size.width/2, self.bounds.origin.y + self.bounds.size.height/2);
    for (NSInteger j=0; j<count; j++) {
        CGFloat scale = [self.sections[j] floatValue]/total;
        UIColor *color = self.sectionColors[j];
        endAngle = starAngle + scale * 2 * M_PI;
        UIBezierPath *fanshapedPath = [UIBezierPath bezierPathWithArcCenter:center radius:(self.bounds.size.height - self.spacing)/2 startAngle:starAngle endAngle:endAngle clockwise:YES];
        starAngle = endAngle;

        CAShapeLayer *fanshapedLayer = [CAShapeLayer layer];
        fanshapedLayer.lineWidth = self.lineWidth;
        fanshapedLayer.path = fanshapedPath.CGPath;
        fanshapedLayer.fillColor = [UIColor clearColor].CGColor;
        fanshapedLayer.strokeColor = color.CGColor;
        [layer addSublayer:fanshapedLayer];
    }
    UIBezierPath *coverPath = [UIBezierPath bezierPathWithArcCenter:center radius:(self.bounds.size.height - self.spacing)/2 startAngle:M_PI_2 endAngle: -2*M_PI+M_PI_2 clockwise:NO];
    CAShapeLayer *coverLayer = [CAShapeLayer layer];
    coverLayer.path = coverPath.CGPath;
    coverLayer.lineWidth = self.lineWidth;
    coverLayer.fillColor = [UIColor clearColor].CGColor;
    coverLayer.strokeColor = self.animationStrokeColor.CGColor;
    [layer addSublayer:coverLayer];
    
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    baseAnimation.fromValue = @1.0;
    baseAnimation.toValue = @0.0;
    baseAnimation.duration = animationTime;
    baseAnimation.removedOnCompletion = NO;
    baseAnimation.fillMode = kCAFillModeForwards;
    [coverLayer addAnimation:baseAnimation forKey:@"coverLayer"];
    
    self.shapeLayer = coverLayer;
}

#pragma mark - Public Methods

- (NSInteger)getLayerIndexWithPoint:(CGPoint)point {
    
    for (NSInteger i=0; i<[self.containerLayer sublayers].count; i++) {
        CAShapeLayer *layer = (CAShapeLayer *)[self.containerLayer sublayers][i];
        CGPathRef path = [layer path];
        if (CGPathContainsPoint(path, NULL, point, 0)) {
            return i;
        }
    }
    return -1;
}

- (void)reloadDataCompletion:(void (^)())completion {
    
    [self drawPieWithAnimation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        completion();
    });
}

- (void)dismissAnimationByTimeInterval:(NSTimeInterval)time {
    
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    baseAnimation.duration = time;
    if (self.isCompleteAnimation) {
        self.completeAnimation = NO;
        baseAnimation.fromValue = @1.0;
        baseAnimation.toValue = @0.0;
    } else {
        self.completeAnimation = YES;
        baseAnimation.fromValue = @0.0;
        baseAnimation.toValue = @1.0;
    }
    baseAnimation.removedOnCompletion = NO;
    baseAnimation.fillMode = kCAFillModeForwards;
    [self.shapeLayer addAnimation:baseAnimation forKey:nil];
}

@end
