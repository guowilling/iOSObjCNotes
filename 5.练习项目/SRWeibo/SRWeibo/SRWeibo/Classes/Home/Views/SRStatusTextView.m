//
//  SRStatusTextView.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRStatusTextView.h"
#import "SRSpecialText.h"

@interface SRStatusTextView ()

@property (nonatomic, strong) NSArray *specialTexts;

@end

@implementation SRStatusTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.editable = NO;
        self.scrollEnabled = NO; // 禁止滚动让内容完全显示
        self.backgroundColor = [UIColor clearColor];
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
    }
    return self;
}

// 初始化所有特殊字符串对应的矩形框
- (void)setupSpecialRects {
    if (self.specialTexts.count > 0) {
        return;
    }
    NSArray *specialTexts = [self.attributedText attribute:@"sts" atIndex:0 effectiveRange:NULL];
    self.specialTexts = specialTexts;
 
    for (SRSpecialText *specialText in specialTexts) {
        self.selectedRange = specialText.range;
        NSArray *selectionRects = [self selectionRectsForRange:self.selectedTextRange];
        self.selectedRange = NSMakeRange(0, 0);
      
        // 此特殊字符串对应的矩形框
        NSMutableArray *rects = [NSMutableArray array];
        for (UITextSelectionRect *selectionRect in selectionRects) {
            CGRect rect = selectionRect.rect;
            if (rect.size.width == 0 || rect.size.height == 0) {
                continue; // 跳过无用的矩形框
            }
            [rects addObject:[NSValue valueWithCGRect:rect]];
        }
        specialText.rects = rects;
    }
}

// 判断点击位置是否在某个特殊字符串上
- (SRSpecialText *)specialTextWithPoint:(CGPoint)point {
    for (SRSpecialText *specialText in self.specialTexts) {
        for (NSValue *rectValue in specialText.rects) {
            if (CGRectContainsPoint(rectValue.CGRectValue, point)) {
                return specialText;
            }
        }
    }
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    SRSpecialText *specialText = [self specialTextWithPoint:point];
    if (specialText) {
        for (NSValue *rectValue in specialText.rects) {
            UIView *cover = [[UIView alloc] init];
            cover.frame = rectValue.CGRectValue;
            cover.backgroundColor = [UIColor redColor];
            cover.tag = 5;
            cover.layer.cornerRadius = 5;
            [self insertSubview:cover atIndex:0];
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UIView *child in self.subviews) {
        if (child.tag == 5) {
            [child removeFromSuperview];
        }
    }
}

// 告诉系统触摸点是否在这个控件上, 在这个控件上才会去调用 touchesBegan 等方法
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    [self setupSpecialRects];
    
    SRSpecialText *specialText = [self specialTextWithPoint:point];
    if (specialText) {
        SRLog(@"%@", specialText);
        return YES;
    }
    return NO;
}

// 告诉系统谁来处理触摸事件, 递归的调用 pointInside:withEvent: 方法
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [super hitTest:point withEvent:event];
    
//    [self setupSpecialRects];
//    
//    SRSpecialText *specialText = [self specialTextWithPoint:point];
//    if (specialText) {
//        SRLog(@"%@", specialText);
//        return self;
//    }
//    return self.superview;
}

@end
