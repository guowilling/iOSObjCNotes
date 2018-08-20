
#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  自定义UIBarButtonItem
 *
 *  @param target    点击item后调用哪个对象
 *  @param action    点击item后调用哪个方法
 *  @param image     默认状态图片
 *  @param highImage 高亮状态图片
 *
 *  @return UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action norImage:(NSString *)image highImage:(NSString *)highImage;

@end
