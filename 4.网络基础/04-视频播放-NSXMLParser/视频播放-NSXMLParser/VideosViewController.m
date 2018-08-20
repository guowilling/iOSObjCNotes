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
    
    NSURLRequest *request = [NSURLRequest requestWithURL:kURL(@"video?type=XML")];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError || !data) {
                                   NSLog(@"网络错误");
                                   return;
                               }
                               // SAX 方式解析 XML 数据
                               NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data]; // 创建 XML 解析器
                               parser.delegate = self; // 设置代理
                               [parser parse]; // 开始解析, 不耗时同步执行
                               [self.tableView reloadData];
                           }];
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
    NSLog(@"parserDidStartDocument");
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    NSLog(@"parserDidEndDocument");
}

/**
 *  解析到一个元素的开始时调用
 *  @param elementName   元素名称
 *  @param attributeDict 属性字典
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([@"videos" isEqualToString:elementName]) {
        return;
    }
    Video *video = [Video videoWithDict:attributeDict];
    [self.videos addObject:video];
}

/**
 *  解析到一个元素的结束时调用
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    NSLog(@"didEndElement elementName: %@", elementName);
}

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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长: %ld分钟", video.length];
    [cell.imageView sd_setImageWithURL:kURL(video.image) placeholderImage:[UIImage imageNamed:@"placehoder"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Video *video = self.videos[indexPath.row];
    MPMoviePlayerViewController *playerVc = [[MPMoviePlayerViewController alloc] initWithContentURL:kURL(video.image)];
    [self presentViewController:playerVc animated:YES completion:nil];
}

@end
