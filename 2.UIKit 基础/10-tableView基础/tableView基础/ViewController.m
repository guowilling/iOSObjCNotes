//
//  ViewController.m
//  tableView基础
//
//  Created by 郭伟林 on 15/9/16.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "CarGroup.h"
#import "Car.h"
#import "HeaderScrollView.h"

/**
 * KVC: 间接获取或者修改对象属性的方式
 * 如果取值的对象没有keyPath对应的属性自动进入下一层查找
 * 如果取值的对象是数组, 返回的也是数组
 */

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *carGroups;

@end

@implementation ViewController

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)carGroups {
    if (_carGroups == nil) {
        _carGroups = [CarGroup carGroups];
    }
    return _carGroups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    HeaderScrollView *tableHeaderView = [[HeaderScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 200)];
    self.tableView.tableHeaderView = tableHeaderView;
    //self.tableView.editing = YES;
//    NSArray *array = [self.carGroups valueForKeyPath:@"cars.name"];
//    NSLog(@"cars.name: %@", array);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.carGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.carGroups[section] cars].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CarGroup *carGroup = self.carGroups[indexPath.section];
    Car *car = carGroup.cars[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:car.icon];
    cell.textLabel.text = car.name;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.carGroups[section] title];
}

// 右侧索引列表(索引下标对应分组的标题)
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    NSMutableArray *arrayM = [NSMutableArray array];
//    for (CarGroup *group in self.carGroups) {
//        [arrayM addObject:group.title];
//    }
//    return arrayM;
    return [self.carGroups valueForKeyPath:@"title"];
}

// 实现此方法即支持手势左拖删除(注意: 数据需要自己删除)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"删除数据");
        [(NSMutableArray *)[self.carGroups[indexPath.section] cars] removeObjectAtIndex:indexPath.row];
        // 局部删除刷新
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        NSLog(@"删除数据后: %@", [self.carGroups[indexPath.section] cars]);
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        NSLog(@"添加数据");
    }
}

// 实现此方法即可以移动交换cell(注意: 数据需要自己交换)
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // 将源从数组中取出
    id source = [self.carGroups[sourceIndexPath.section] cars][sourceIndexPath.row];
    // 将源从数组中删除
    [(NSMutableArray *)[self.carGroups[sourceIndexPath.section] cars] removeObjectAtIndex:sourceIndexPath.row];
    // 将源插入到数组目标位置
    [(NSMutableArray *)[self.carGroups[destinationIndexPath.section] cars] insertObject:source atIndex:destinationIndexPath.row];
}

#pragma mark - UITableViewDelegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

@end
