//
//  SRGuideDetailToolBar.m
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/6.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRGuideDetailToolBar.h"
#import "SRGuideDetail.h"

@interface SRGuideDetailToolBar ()

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@end

@implementation SRGuideDetailToolBar

+ (instancetype)guideDetailToolBar {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.layer.cornerRadius = 1;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;

    self.sr_width = SRScreenW;

//    self.likeBtn.backgroundColor    = SRRandomColor;
//    self.shareBtn.backgroundColor   = SRRandomColor;
//    self.commentBtn.backgroundColor = SRRandomColor;
}

- (IBAction)likeBtnClick:(UIButton *)sender {
    
    SRLog(@"喜欢");
}

- (IBAction)shareBtnClick:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(guideDetailToolBar:didClickShareBtn:)]) {
        [self.delegate guideDetailToolBar:self didClickShareBtn:sender];
    }
}

- (IBAction)commentBtnClick:(UIButton *)sender {
    
    SRLog(@"评论");
}

- (void)setGuideDetail:(SRGuideDetail *)guideDetail {
    
    _guideDetail = guideDetail;
    
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%zd", guideDetail.likes_count] forState:UIControlStateNormal];
    [self.shareBtn  setTitle:[NSString stringWithFormat:@"%zd", guideDetail.shares_count] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%zd", guideDetail.comments_count] forState:UIControlStateNormal];
}

@end
