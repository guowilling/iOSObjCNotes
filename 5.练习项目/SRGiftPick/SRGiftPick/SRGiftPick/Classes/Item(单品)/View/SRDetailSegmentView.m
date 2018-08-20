//
//  SRDetailSegmentView.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/5.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRDetailSegmentView.h"
#import "SRSearchGift.h"

@interface SRDetailSegmentView ()

@property (weak, nonatomic) IBOutlet UIButton *descBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redViewLeftConstraint;

@end

@implementation SRDetailSegmentView

+ (instancetype)detailSegmentView {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.descBtn.layer.borderColor = SRRGBColor(220, 220, 220).CGColor;
    self.descBtn.layer.borderWidth = 0.5;
    self.commentBtn.layer.borderColor = SRRGBColor(220, 220, 220).CGColor;
    self.commentBtn.layer.borderWidth = 0.5;
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (IBAction)ltSegementAction {
    
    self.redViewLeftConstraint.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.redView layoutIfNeeded];
    }];
}

- (IBAction)rtSegementAction {
    
    self.redViewLeftConstraint.constant = SRScreenW * 0.5;
    [UIView animateWithDuration:0.25 animations:^{
        [self.redView layoutIfNeeded];
    }];
}

- (void)setGift:(SRSearchGift *)gift {
    
    _gift = gift;
    
    [self.commentBtn setTitle:[NSString stringWithFormat:@"评论(%zd)", gift.comments_count] forState:UIControlStateNormal];
}

- (void)ltSegementAddTarget:(id)target selector:(SEL)action forcontrolEvents:(UIControlEvents)controlEvents {
    
    [self.descBtn addTarget:target action:action forControlEvents:controlEvents];
}

- (void)rtSegementAddTarget:(id)target selector:(SEL)action forcontrolEvents:(UIControlEvents)controlEvents {
    
    [self.commentBtn addTarget:target action:action forControlEvents:controlEvents];
}

@end
