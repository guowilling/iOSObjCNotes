//
//  GPHotWordsCollectionViewHeaderw.m
//  礼物说
//
//  Created by tripleCC on 15/8/27.
//  Copyright (c) 2015年 tripleCC. All rights reserved.
//

#import "SRHotWordsHeader.h"

@interface SRHotWordsHeader()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation SRHotWordsHeader

- (void)setTitle:(NSString *)title {
    
    _title = [title copy];
    
    self.nameLabel.text = title;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
//    self.backgroundColor = SRRandomColor;
//    self.nameLabel.backgroundColor = SRRandomColor;
}

@end
