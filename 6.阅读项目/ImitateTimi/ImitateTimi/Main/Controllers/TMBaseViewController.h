
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "ConstDefine.h"
#import "TMDataBaseManager.h"
#import "TMBooks.h"

@class TMBill;

@interface TMBaseViewController : UIViewController

- (void)showNetworkIndicator;
- (void)hideNetworkIndicator;

- (void)alert:(NSString*)msg;
- (BOOL)alertError:(NSError*)error;

- (BOOL)filterError:(NSError*)error;

- (void)runInMainQueue:(void (^)())queue;
- (void)runInGlobalQueue:(void (^)())queue;
- (void)runAfterSecs:(float)secs block:(void (^)())block;

- (void)showSVProgressHUD:(NSString *)text;

@end
