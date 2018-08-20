
#import "TMBaseViewController.h"
#import <SVProgressHUD.h>

@interface TMBaseViewController ()

@end

@implementation TMBaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)showNetworkIndicator {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)hideNetworkIndicator {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)alert:(NSString*)msg {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (BOOL)alertError:(NSError*)error {
    
    if (error) {
        [self alert:[NSString stringWithFormat:@"%@",error]];
        return YES;
    }
    return NO;
}

- (BOOL)filterError:(NSError*)error {
    
    return [self alertError:error]==NO;
}

- (void)runInMainQueue:(void (^)())queue {
    
    dispatch_async(dispatch_get_main_queue(), queue);
}

- (void)runInGlobalQueue:(void (^)())queue {
    
    dispatch_async(dispatch_get_global_queue(0, 0), queue);
}

- (void)runAfterSecs:(float)secs block:(void (^)())block {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, secs * NSEC_PER_SEC), dispatch_get_main_queue(), block);
}

#pragma mark - SVProgressHUD 

- (void)showSVProgressHUD:(NSString *)text {
    
    [SVProgressHUD setMinimumDismissTimeInterval:0.5];
    [SVProgressHUD showImage:nil status:text];
    [SVProgressHUD setMinimumSize:CGSizeMake(100, 60)];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:18]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

@end
