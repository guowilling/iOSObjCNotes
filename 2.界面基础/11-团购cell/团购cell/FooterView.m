//
//  FooterView.m
//  团购cell
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "FooterView.h"

@interface FooterView ()

@property (weak, nonatomic) IBOutlet UIButton *loadMoreButton;
@property (weak, nonatomic) IBOutlet UIView *tipsView;

@end

@implementation FooterView

- (instancetype)initWithDelegate:(id)delegate {
    if ((self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject])) {
        self.delegate = delegate;
    }
    return self;
}

+ (instancetype)footerView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (IBAction)loadMore {
    self.loadMoreButton.hidden = YES;
    self.tipsView.hidden = NO;
    if ([self.delegate respondsToSelector:@selector(tgFooterViewDidDownloadButtonClick:)]) {
        [self.delegate tgFooterViewDidDownloadButtonClick:self];
    }
}

- (void)endRefresh {
    self.loadMoreButton.hidden = NO;
    self.tipsView.hidden = YES;
}

@end
