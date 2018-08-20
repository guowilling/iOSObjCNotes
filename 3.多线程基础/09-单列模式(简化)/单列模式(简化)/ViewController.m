//
//  ViewController.m
//  单列模式(简化)
//
//  Created by 郭伟林 on 15/9/24.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "MoveTool.h"
#import "DataTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    MoveTool *moveTool0 = [MoveTool sharedMoveTool];
    MoveTool *moveTool1 = [[MoveTool alloc] init];
    MoveTool *moveTool2 = [[MoveTool alloc] init];
    MoveTool *moveTool3 = [MoveTool sharedMoveTool];
    NSLog(@"\n%@\n%@\n%@\n%@", moveTool0, moveTool1, moveTool2, moveTool3);
    
    DataTool *dataTool0 = [DataTool sharedDataTool];
    DataTool *dataTool1 = [[DataTool alloc] init];
    DataTool *dataTool2 = [[DataTool alloc] init];
    DataTool *dataTool3 = [DataTool sharedDataTool];
    NSLog(@"\n%@\n%@\n%@\n%@", dataTool0, dataTool1, dataTool2, dataTool3);
}

@end
