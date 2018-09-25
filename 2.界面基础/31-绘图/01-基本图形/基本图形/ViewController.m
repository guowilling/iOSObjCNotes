//
//  ViewController.m
//  基本图形
//
//  Created by 郭伟林 on 15/9/19.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "TempViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataSource = @[@"LineView", @"RectView", @"CircleView", @"ImageView"];
    
    [self.view addSubview:({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView;
    })];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            TempViewController *tempVC = [[TempViewController alloc] init];
            tempVC.drawView = [[LineView alloc] init];
            [self.navigationController pushViewController:tempVC animated:YES];
        }
            break;
        case 1:
        {
            TempViewController *tempVC = [[TempViewController alloc] init];
            tempVC.drawView = [[RectView alloc] init];
            [self.navigationController pushViewController:tempVC animated:YES];
        }
            break;
        case 2:
        {
            TempViewController *tempVC = [[TempViewController alloc] init];
            tempVC.drawView = [[CircleView alloc] init];
            [self.navigationController pushViewController:tempVC animated:YES];
        }
            break;
        case 3:
        {
            TempViewController *tempVC = [[TempViewController alloc] init];
            tempVC.drawView = [[ImageView alloc] init];
            [self.navigationController pushViewController:tempVC animated:YES];
        }
            break;
        default:
            break;
    }
}


@end
