//
//  ContactsViewController.m
//  简易通讯录
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactCell.h"
#import "AddViewController.h"
#import "EditViewController.h"
#import "MBProgressHUD+MJ.h"

#define kDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.data"]

@interface ContactsViewController () <AddViewControllerDelegate, EditViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *contacts;

@end

@implementation ContactsViewController

- (NSMutableArray *)contacts {
    if (!_contacts) {
        _contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:kDataPath];
        if (!_contacts) {
            _contacts = [NSMutableArray array];
        }
    }
    return _contacts;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //self.tableView.editing = YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContactCell *cell = [ContactCell cellWithTableView:tableView];
    cell.contact = self.contacts[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        [self.contacts removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:kDataPath];
        
    } else if (UITableViewCellEditingStyleInsert == editingStyle) {
        Contact *contact = [[Contact alloc] init];
        contact.name = @"无名";
        contact.number = @"55555";
        [self.contacts insertObject:contact atIndex:indexPath.row + 1];
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationBottom];
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:kDataPath];
    }
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2 == 0) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (IBAction)logoutBtnClick:(UIBarButtonItem *)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注销"
                                                                   message:@"确定吗?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

// 无论是手动执行 segue 还是自动执行 segue, 跳转之前都会执行该方法, 通过 segue 可以得到源控制器和目标控制器, 所以可用传递数据.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    UIViewController *destVC = segue.destinationViewController;
    if ([destVC isKindOfClass:[AddViewController class]]) {
        AddViewController *addVC = (AddViewController *)destVC;
        addVC.delegate = self;
    }
    
    if ([destVC isKindOfClass:[EditViewController class]]) {
        EditViewController *editVC = (EditViewController *)destVC;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        editVC.contact = self.contacts[indexPath.row];
        editVC.delegate = self;
    }
}

#pragma mark - AddViewControllerDelegate

- (void)addViewControllerDidClickAddBtn:(AddViewController *)addViewController contact:(Contact *)contact {
    
    [self.contacts addObject:contact];
    
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:kDataPath];
    
    [self.tableView reloadData];
}

#pragma mark - EditViewControllerDelegate

- (void)editViewControllerDidClickSaveBtn:(EditViewController *)editViewController contact:(Contact *)contact {
    
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:kDataPath];
    
    [self.tableView reloadData];
}

@end
