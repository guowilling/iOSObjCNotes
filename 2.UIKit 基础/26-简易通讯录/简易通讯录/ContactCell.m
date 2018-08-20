//
//  contactCell.m
//  简易通讯录
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ContactCell.h"

@interface ContactCell ()

@property (nonatomic, weak) UIView *divider;

@end

@implementation ContactCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *reuseID = @"contactCell";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    return cell;
}

- (void)setContact:(Contact *)contact{
    
    _contact = contact;
    
    self.textLabel.text = contact.name;
    self.detailTextLabel.text = contact.number;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"initWithStyle");
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    
    NSLog(@"awakeFromNib");
    [self setup];
}

- (void)setup {
    
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor blackColor];
    divider.alpha = 0.2;
    [self.contentView addSubview:divider];
    self.divider = divider;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.divider.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
}

@end
