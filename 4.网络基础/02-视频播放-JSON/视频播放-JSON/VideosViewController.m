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
#import <MediaPlayer/MediaPlayer.h>

#define kURLPath(path) [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/MJServer/%@", path]]

@interface VideosViewController ()

@property (nonatomic, strong) NSMutableArray *videos;

@end

@implementation VideosViewController

- (NSArray *)videos {
    
    if (_videos ==nil) {
        _videos = [NSMutableArray array];
    }
    return _videos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 75;
    
    NSURL *URLPath = kURLPath(@"video");
    NSURLRequest *request = [NSURLRequest requestWithURL:URLPath];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError || data == nil) {
                                   NSLog(@"网络繁忙请稍后再试");
                                   return;
                               }
                               
                               // 解析JSON数据
                               NSDictionary *respData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                               NSArray *videoDicts = respData[@"videos"];
                               for (NSDictionary *videoDict in videoDicts) {
                                   Video *video = [Video videoWithDict:videoDict];
                                   [self.videos addObject:video];
                               }
                               
                               // 刷新表格
                               [self.tableView reloadData];
                           }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"videoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    Video *video = self.videos[indexPath.row];
    cell.textLabel.text = video.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长: %zd分钟", video.length];
    NSURL *URL = kURLPath(video.image);
    [cell.imageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"placehoder"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Video *video = self.videos[indexPath.row];
    NSURL *URL = kURLPath(video.url);
    MPMoviePlayerViewController *playerVc = [[MPMoviePlayerViewController alloc] initWithContentURL:URL];
    [self presentViewController:playerVc animated:YES completion:nil];
}

@end
