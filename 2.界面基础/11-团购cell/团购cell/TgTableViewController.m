//
//  ViewController.m
//  团购cell
//
//  Created by 郭伟林 on 15/9/17.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "TgTableViewController.h"
#import "TgModel.h"
#import "TgCell.h"
#import "FooterView.h"
#import "HeaderView.h"

@interface TgTableViewController () <FooterViewDelegate>

@property (nonatomic, strong) NSMutableArray *tgs;

@end

@implementation TgTableViewController

- (NSArray *)tgs {
    if (_tgs == nil) {
        _tgs = [TgModel tgs];
    }
    return _tgs;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.rowHeight = 100;
    
    self.tableView.tableFooterView = [[FooterView alloc] initWithDelegate:self];
    
    self.tableView.tableHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil] lastObject];

    //[self.tableView registerNib:[UINib nibWithNibName:@"TgCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TgCell * cell = [TgCell tgCellWithTableView:tableView];
    cell.tgModel = self.tgs[indexPath.row];
    return cell;
}

#pragma mark - FooterViewDelegate
- (void)tgFooterViewDidDownloadButtonClick:(FooterView *)footerView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *dict = @{@"title": @"新的东西", @"icon": @"ad_00", @"price": @"100", @"buyCount": @"250"};
        TgModel *tg = [TgModel tgWithDict:dict];
        [self.tgs addObject:tg];
        
        // 全局刷新
        //[self.tableView reloadData];
        // 局部刷新
        NSIndexPath *path = [NSIndexPath indexPathForRow:(self.tgs.count - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
        
        [footerView endRefresh];
    });
}

@end
