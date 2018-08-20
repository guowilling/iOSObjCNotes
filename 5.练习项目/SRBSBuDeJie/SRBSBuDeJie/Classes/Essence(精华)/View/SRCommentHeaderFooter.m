//
//  SRComentHeaderFooter.m
//  SRBSBudejie
//
//  Created by 郭伟林 on 15/10/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRCommentHeaderFooter.h"

@interface SRCommentHeaderFooter ()

@property (nonatomic, weak) UILabel *label;

@end

@implementation SRCommentHeaderFooter

+ (instancetype)HeaderFooterViewWithTableView:(UITableView *)tableview {
    
    SRCommentHeaderFooter *headerFooterView = [tableview dequeueReusableHeaderFooterViewWithIdentifier:commentHeaderFooter];
    if (headerFooterView == nil) {
        headerFooterView = [[self alloc] initWithReuseIdentifier:commentHeaderFooter];
    }
    return headerFooterView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = SRRGBColor(223, 223, 223);
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = SRRGBColor(67, 67, 67);
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        }];
        self.label = label;
//        self.label.backgroundColor = SRRandomColor;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    self.label.text = title;
}

@end
