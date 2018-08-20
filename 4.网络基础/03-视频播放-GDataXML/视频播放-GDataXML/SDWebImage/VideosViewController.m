//
//  VideosViewController.m
//  视频播放-JSON
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "VideosViewController.h"
#import "Video.h"
#import "UIImageView+WebCache.h"
#import "GDataXMLNode.h"
#import <MediaPlayer/MediaPlayer.h>

#define kURL(path) [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/MJServer/%@", path]]

@interface VideosViewController () <NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *videos;

@end

@implementation VideosViewController

- (NSArray *)videos {
    
    if (!_videos) {
        _videos = [NSMutableArray array];
    }
    return _videos;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.tableView.rowHeight = 75;
    
    [self loadDatas];
}

- (void)loadDatas {
    
    NSURL *URL = kURL(@"video?type=XML");
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError || !data) {
                                   NSLog(@"网络错误");
                                   return;
                               }
                               // DOM 方式解析 XML 数据
                               GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil]; // 加载整个 XML 文档
                               GDataXMLElement *root = doc.rootElement; // 根元素 videos
                               NSArray *elements = [root elementsForName:@"video"]; // 所有 video 元素
                               for (GDataXMLElement *videoElement in elements) { // 遍历所有 video 元素
                                   Video *video = [[Video alloc] init];
                                   video.id     = [videoElement attributeForName:@"id"].stringValue.intValue;
                                   video.length = [videoElement attributeForName:@"length"].stringValue.intValue;
                                   video.name   = [videoElement attributeForName:@"name"].stringValue;
                                   video.image  = [videoElement attributeForName:@"image"].stringValue;
                                   video.url    = [videoElement attributeForName:@"url"].stringValue;
                                   [self.videos addObject:video];
                               }
                               [self.tableView reloadData];
                           }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"videoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    Video *video = self.videos[indexPath.row];
    cell.textLabel.text = video.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长: %zd分钟", video.length];
    [cell.imageView sd_setImageWithURL:kURL(video.image) placeholderImage:[UIImage imageNamed:@"placehoder"]];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Video *video = self.videos[indexPath.row];
    MPMoviePlayerViewController *playerVc = [[MPMoviePlayerViewController alloc] initWithContentURL:kURL(video.url)];
    [self presentViewController:playerVc animated:YES completion:nil];
}

@end
