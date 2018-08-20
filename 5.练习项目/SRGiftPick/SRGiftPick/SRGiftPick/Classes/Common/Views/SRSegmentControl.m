//
//  SRBrandHomeSegment.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/7.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRSegmentControl.h"

@interface SRSegmentControl ()

@property (weak, nonatomic) IBOutlet UIButton *ltBtn;
@property (weak, nonatomic) IBOutlet UIButton *rtBtn;
@property (weak, nonatomic) IBOutlet UIView   *redView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redViewLeftConstraint;

@end

@implementation SRSegmentControl

+ (instancetype)segmentControl {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.ltBtn.layer.borderColor = SRRGBColor(220, 220, 220).CGColor;
    self.ltBtn.layer.borderWidth = 0.5;
    self.rtBtn.layer.borderColor = SRRGBColor(220, 220, 220).CGColor;
    self.rtBtn.layer.borderWidth = 0.5;
    self.autoresizingMask = UIViewAutoresizingNone;
    
//    self.ltBtn.backgroundColor = SRRandomColor;
//    self.rtBtn.backgroundColor = SRRandomColor;
//    self.redView.backgroundColor = SRRandomColor;
}

- (IBAction)leftBtnClick:(UIButton *)sender {
    
    self.redViewLeftConstraint.constant = 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (IBAction)rightBtnClick:(UIButton *)sender {
    
    self.redViewLeftConstraint.constant = SRScreenW * 0.5;
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)setLeftTitle:(NSString *)leftTitle {
    
    _ltTitle = leftTitle.copy;
    
    [self.ltBtn setTitle:leftTitle forState:UIControlStateNormal];
}

- (void)setRightTitle:(NSString *)rightTitle {
    
    _rtTitle = rightTitle.copy;
    
    [self.rtBtn setTitle:rightTitle forState:UIControlStateNormal];
}

- (void)ltSegementAddTarget:(id)target selector:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
    [self.ltBtn addTarget:target action:action forControlEvents:controlEvents];
}

- (void)rtSegementAddTarget:(id)target selector:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
    [self.rtBtn addTarget:target action:action forControlEvents:controlEvents];
}

@end
