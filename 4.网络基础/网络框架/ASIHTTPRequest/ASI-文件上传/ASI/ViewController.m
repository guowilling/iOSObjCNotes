//
//  ViewController.m
//  ASI
//
//  Created by 郭伟林 on 15/9/25.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "ASIFormDataRequest.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSURL *URL = [NSURL URLWithString:@"http://localhost:8080/MJServer/upload"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:URL]; // POST 请求
    
    [request setPostValue:@"zhangsan" forKey:@"username"]; // 普通参数
    [request setPostValue:@"123"      forKey:@"pwd"];
    [request setPostValue:@"28"       forKey:@"age"];
    [request setPostValue:@"1.89"     forKey:@"height"];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"mayday" ofType:@"jpg"]; // 文件参数
    [request setFile:filePath forKey:@"file"]; // ASI 自动识别文件的 MIMEType
    //[request setData:(id) withFileName:(NSString *) andContentType:(NSString *) forKey:(NSString *)];
    
    request.uploadProgressDelegate = self.progressView;
    
    __weak typeof(request) weakRequest = request;
    [request setCompletionBlock:^{
        NSLog(@"%@", [weakRequest responseString]);
    }];
    
    [request startAsynchronous];
}

@end
