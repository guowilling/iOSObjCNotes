//
//  hotWordsCollectionViewFooter.m
//  礼物说
//
//  Created by tripleCC on 15/8/27.
//  Copyright (c) 2015年 tripleCC. All rights reserved.
//

#import "SRHotWordsFooter.h"

@interface SRHotWordsFooter()

@property (weak, nonatomic) IBOutlet UIButton *clearSearchHistoryBtn;

@end

@implementation SRHotWordsFooter

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    
    [self.clearSearchHistoryBtn addTarget:target action:action forControlEvents:controlEvents];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
//    self.backgroundColor = SRRandomColor;
//    self.clearSearchHistoryBtn.backgroundColor = SRRandomColor;
}

@end
