//
//  AppsViewController.m
//  cell图片下载
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "AppsViewController.h"
#import "App.h"
#import "DownloadOperation.h"

#define kCachesPath(URLString) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[URLString lastPathComponent]]

@interface AppsViewController () <DownloadOperationDelegate>

@property (nonatomic, strong) NSOperationQueue    *downloadQueue;

@property (nonatomic, strong) NSArray             *apps;

@property (nonatomic, strong) NSMutableDictionary *operationsCache;

@property (nonatomic, strong) NSMutableDictionary *imagesCache;

@end

@implementation AppsViewController

- (NSArray *)apps {
    
    if (!_apps) {
        _apps = [App apps];
    }
    return _apps;
}

- (NSOperationQueue *)downloadQueue {
    
    if (!_downloadQueue) {
        self.downloadQueue = [[NSOperationQueue alloc] init];
    }
    return _downloadQueue;
}

- (NSMutableDictionary *)operationsCache {
    
    if (!_operationsCache) {
        self.operationsCache = [[NSMutableDictionary alloc] init];
    }
    return _operationsCache;
}

- (NSMutableDictionary *)imagesCache {
    
    if (!_imagesCache) {
        self.imagesCache = [[NSMutableDictionary alloc] init];
    }
    return _imagesCache;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"appCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    App *app = self.apps[indexPath.row];
    cell.textLabel.text = app.name;
    cell.detailTextLabel.text = app.download;
    
    UIImage *image = self.imagesCache[app.icon];
    if (image) {
        cell.imageView.image = image;
    } else {
        NSString *imagePath = kCachesPath(app.icon);
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        if (imageData) {
            cell.imageView.image = [UIImage imageWithData:imageData];
        } else {
            cell.imageView.image = [UIImage imageNamed:@"placeholder"];
            [self download:app.icon indexPath:indexPath];
        }
    }
    return cell;
}

- (void)download:(NSString *)URLString indexPath:(NSIndexPath *)indexPath {
    
    DownloadOperation *operation = self.operationsCache[URLString];
    if (operation) {
        return;
    }
    operation = [[DownloadOperation alloc] init];
    operation.URLString = URLString;
    operation.indexPath = indexPath;
    operation.delegate  = self;
    [self.downloadQueue addOperation:operation]; // 添加到队列中, 会自动调用自定义 Operation 的 main 方法
    [self.operationsCache setObject:operation forKey:URLString];
}

#pragma mark - DownloadOperationDelegate

- (void)downloadOperation:(DownloadOperation *)downloadOperation didFinishedDownload:(UIImage *)image {
    
    if (image) {
        self.imagesCache[downloadOperation.URLString] = image;
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToFile:kCachesPath(downloadOperation.URLString) atomically:YES];
    }
    [self.operationsCache removeObjectForKey:downloadOperation.URLString];
    [self.tableView reloadRowsAtIndexPaths:@[downloadOperation.indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.downloadQueue setSuspended:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self.downloadQueue setSuspended:NO];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    [self.downloadQueue cancelAllOperations];
    [self.operationsCache removeAllObjects];
    [self.imagesCache removeAllObjects];
}

@end
