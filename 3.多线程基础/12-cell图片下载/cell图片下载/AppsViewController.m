//
//  AppsViewController.m
//  cell图片下载
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "AppsViewController.h"
#import "App.h"

#define kCachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

@interface AppsViewController ()

@property (nonatomic, strong) NSArray *apps;

@property (nonatomic, strong) NSOperationQueue *downloadQueue;

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
        _downloadQueue = [[NSOperationQueue alloc] init];
    }
    return _downloadQueue;
}

- (NSMutableDictionary *)operationsCache {
    
    if (!_operationsCache) {
        _operationsCache = [[NSMutableDictionary alloc] init];
    }
    return _operationsCache;
}

- (NSMutableDictionary *)imagesCache {
    
    if (!_imagesCache) {
        _imagesCache = [[NSMutableDictionary alloc] init];
    }
    return _imagesCache;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //NSLog(@"%@", kCachesPath);
}

#pragma mark UITableViewDataSource

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
    
    UIImage *image = self.imagesCache[app.icon];
    if (image) { // 内存缓存
        cell.imageView.image = image;
        return cell;
    }
    
    NSString *filePath = [kCachesPath stringByAppendingPathComponent:[app.icon lastPathComponent]];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data) { // 沙盒缓存
        cell.imageView.image = [UIImage imageWithData:data];
        return cell;
    }
    
    cell.imageView.image = [UIImage imageNamed:@"placeholder"];
    [self download:app.icon indexPath:indexPath];
    return cell;
}

- (void)download:(NSString *)URLString indexPath:(NSIndexPath *)indexPath {
    
    NSBlockOperation *operation = self.operationsCache[URLString];
    if (operation) { // 图片对应的下载操作已存在, 直接返回, 防止重复发送下载请求
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    operation = [NSBlockOperation blockOperationWithBlock:^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URLString]];
        UIImage *image = [UIImage imageWithData:data];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (image) {
                weakSelf.imagesCache[URLString] = image; // 缓存图片到内存
                NSData *data = UIImagePNGRepresentation(image);
                NSString *imageCachePath = [kCachesPath stringByAppendingPathComponent:URLString.lastPathComponent];
                [data writeToFile:imageCachePath atomically:YES]; // 缓存图片到沙盒
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
            [self.operationsCache removeObjectForKey:URLString]; // 移除下载操作, 防止 operations 越来越大, 以及保证下载失败后能够重新下载
        }];
    }];
    [self.downloadQueue addOperation:operation]; // 添加操作到队列中, 会自动调用操作 block
    [self.operationsCache setObject:operation forKey:URLString]; // 保存该图片下载操作, 防止重复下载
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
