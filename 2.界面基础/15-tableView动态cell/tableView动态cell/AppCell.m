//
//  AppCell.m
//  tableView动态cell
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "AppCell.h"

@interface AppCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;

@end

@implementation AppCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)download:(UIButton *)sender {
    self.downloadBtn.enabled = NO;
    [self.downloadBtn setTitle:@"已下载" forState:UIControlStateDisabled];
    self.appModel.downloaded = YES;
    
    if ([self.delegate respondsToSelector:@selector(appCellDidClickDownloadBtn:)]) {
        [self.delegate appCellDidClickDownloadBtn:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    // 选中状态时的背景
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor blueColor];
//    self.selectedBackgroundView = view;
}

- (void)setAppModel:(AppModel *)appModel {
    _appModel = appModel;
    
    self.iconView.image = [UIImage imageNamed:appModel.icon];
    self.nameLabel.text = appModel.name;
    self.infoLabel.text = [NSString stringWithFormat:@"大小%@ | 下载次数%@", appModel.download, appModel.size];
    self.downloadBtn.enabled = !appModel.isDownloaded;
}

@end
