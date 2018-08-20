//
//  SRSearchGift.h
//  SRGiftPick
//
//  Created by 郭伟林 on 15/10/5.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRSearchGift : NSObject

/**单品模型id */
@property (nonatomic, copy) NSString *ID;
/**图片 */
@property (nonatomic, copy) NSString *cover_image_url;
/**创建时间 */
@property (nonatomic, copy) NSString *created_at;
/**单品描述 */
@property (nonatomic, copy) NSString *giftDescription;
/**是否喜欢 */
@property (nonatomic, assign) BOOL is_favorite;
/**单品名称 */
@property (nonatomic, copy) NSString *name;
/**价格 */
@property (nonatomic, copy) NSString *price;
/**购买id */
@property (nonatomic, copy) NSString *purchase_id;
/**购买状态 */
@property (nonatomic, assign) BOOL purchase_status;
/**购买地址 */
@property (nonatomic, copy) NSString *purchase_url;
/**子类id */
@property (nonatomic, copy) NSString *subcategory_id;
/**更新时间 */
@property (nonatomic, copy) NSString *updated_at;
/**喜欢数 */
@property (nonatomic, strong) NSString *favorites_count;
/**单品详情页顶部图片数组 */
@property (nonatomic, strong) NSArray *image_urls;
/**图片详情  */
@property (nonatomic, copy) NSString *detail_html;
/**评论总数 */
@property (nonatomic, assign) NSInteger comments_count;
/**分享地址  */
@property (nonatomic, copy) NSString *url;

@end
