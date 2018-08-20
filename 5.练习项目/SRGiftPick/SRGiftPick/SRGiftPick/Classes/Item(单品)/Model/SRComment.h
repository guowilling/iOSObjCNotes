//
//  SRComment.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/5.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRComment : NSObject

/**用户头像  */
@property (nonatomic, copy) NSString *avatar_url;
/**用户昵称  */
@property (nonatomic, copy) NSString *nickname;
/**评论内容 */
@property (nonatomic, copy) NSString *content;
/**评论时间  */
@property (nonatomic, copy) NSString *created_at;

@end
