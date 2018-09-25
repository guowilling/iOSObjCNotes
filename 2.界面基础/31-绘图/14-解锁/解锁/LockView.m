//
//  LockView.m
//  解锁
//
//  Created by 郭伟林 on 15/9/21.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "LockView.h"

@interface LockView ()

@property (nonatomic, strong) NSMutableArray *buttons;

@property (nonatomic, assign) CGPoint currentPoint;

@end

@implementation LockView

- (NSArray *)buttons {
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return  self;
}

- (void)setup {
    
    for (int i = 0 ; i < 9; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        button.tag = i;
        // 需要禁止按钮交互不然 touches 事件会被拦截
        button.userInteractionEnabled = NO;
        [self addSubview:button];
    }
}

#pragma mark - 触摸事件

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint startPoint = [self getCurrentTouchPoint:touches];
    UIButton *button = [self getBtnWithPoint:startPoint];
    if (button) {
        button.selected = YES;
        [self.buttons addObject:button];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint movePoint = [self getCurrentTouchPoint:touches];
    self.currentPoint = movePoint;
    UIButton *button = [self getBtnWithPoint:movePoint];
    if (button && button.selected == NO) {
        button.selected = YES;
        [self.buttons addObject:button];
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSMutableString *stringM = [NSMutableString string];
    for (UIButton *btn in self.buttons) {
        [stringM appendFormat:@"%zd", btn.tag];
    }
    if ([self.delegate respondsToSelector:@selector(lockViewDidClick:pwd:)]) {
        [self.delegate lockViewDidClick:self pwd:stringM];
    }
    
    [self.buttons makeObjectsPerformSelector:@selector(setSelected:) withObject:0];
    [self.buttons removeAllObjects];
    
    [self setNeedsDisplay];
}

#pragma mark - 系统方法

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    for (int i = 0; i < 9; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat w = 75;
        CGFloat h = 75;
        CGFloat margin = (self.frame.size.width - (3 * w)) / 4;
        int col = i % 3;
        int row = i / 3;
        CGFloat x = margin + (w + margin) * col;
        CGFloat y = margin + (h + margin) * row;
        btn.frame = CGRectMake(x, y, w, h);
    }
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctr, rect);
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *btn = self.buttons[i];
        if (i == 0) { // 起点
            CGContextMoveToPoint(ctr, btn.center.x, btn.center.y);
        } else { // 终点
            CGContextAddLineToPoint(ctr, btn.center.x, btn.center.y);
        }
    }
    if (self.buttons.count != 0) {
        CGContextAddLineToPoint(ctr, self.currentPoint.x, self.currentPoint.y);
    }
    [[UIColor colorWithRed:18/255.0 green:102/255.0 blue:72/255.0 alpha:0.5] set];
    CGContextSetLineCap(ctr, kCGLineCapRound);
    CGContextSetLineJoin(ctr, kCGLineJoinRound);
    CGContextSetLineWidth(ctr, 10);
    CGContextStrokePath(ctr);
}

#pragma mark - 私有方法
/**
 *  当前触摸点
 *
 *  @param touches 触摸对象
 *
 *  @return CGPoint
 */
- (CGPoint)getCurrentTouchPoint:(NSSet *)touches {
    
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

/**
 *  触摸点所在按钮
 *
 *  @param point 触摸点
 *
 *  @return 所在按钮
 */
- (UIButton *)getBtnWithPoint:(CGPoint)point {
    
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
            break;
        }
    }
    return nil;
}

@end
