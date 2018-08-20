//
//  SREmotionAttachment.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SREmotionAttachment.h"
#import "SREmotion.h"

@implementation SREmotionAttachment

- (void)setEmotion:(SREmotion *)emotion {
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}

@end
