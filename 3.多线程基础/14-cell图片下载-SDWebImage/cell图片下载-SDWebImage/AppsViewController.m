//
//  AppsViewController.m
//  cell图片下载-SDWebImage
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "AppsViewController.h"
#import "App.h"
#import "UIImageView+WebCache.h"

@interface AppsViewController ()

@property (nonatomic, strong) NSArray *apps;

@end

@implementation AppsViewController

- (NSArray *)apps {
    
    if (!_apps) {
        _apps = [App apps];
    }
    return _apps;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"appCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    App *app = self.apps[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
    
    NSURL *imageURL = [NSURL URLWithString:app.icon];
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    [cell.imageView sd_setImageWithPreviousCachedImageWithURL:imageURL
                                          andPlaceholderImage:[UIImage imageNamed:@"placeholder"]
                                                      options:options
                                                     progress:^(NSInteger receivedSize, NSInteger expectedSize) { // 子线程
                                                         NSLog(@"thread: %@;\n正在下载 ***** progress: %.2f", [NSThread currentThread], (double)receivedSize / expectedSize);
                                                     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) { // 主线程
                                                         NSLog(@"thread: %@;\n下载完成 ***** image: %@", [NSThread currentThread], image);
                                                     }];
    return cell;
}

@end
