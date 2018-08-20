//
//  ViewController.m
//  数据存储-plist
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveData {
    NSString *home = NSHomeDirectory();
    NSLog(@"%@", home);
    
    //NSString *documentsPath = [home stringByAppendingPathComponent:@"Documents"];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@", documentsPath);
    
    // plist 只能存储具有 writeToFile 方法的对象, 比如: 字符串 / 数组 / 字典 / NSNumber / NSData...
    NSArray *tempArray = @[@"GWL", @"25"];
    [tempArray writeToFile:[documentsPath stringByAppendingPathComponent:@"tempArray.plist"] atomically:YES];
    
    NSDictionary *tempDict = @{@"Name": @"GWL", @"age": @"25"};
    [tempDict writeToFile:[documentsPath stringByAppendingPathComponent:@"tempDict.plist"] atomically:YES];
    
    NSArray *tempDictArray = @[@{@"Name": @"GWL", @"Age": @"25"}, @{@"Name": @"ZXL", @"Age": @"25"}];
    [tempDictArray writeToFile:[documentsPath stringByAppendingPathComponent:@"tempDictArray.plist"] atomically:YES];
}

- (IBAction)readData {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[documentsPath stringByAppendingPathComponent:@"tempArray.plist"]];
    NSLog(@"array: %@", array);
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[documentsPath stringByAppendingPathComponent:@"tempDict.plist"]];
    NSLog(@"dict: %@", dict);
    
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:[documentsPath stringByAppendingPathComponent:@"tempDictArray.plist"]];
    NSLog(@"dictArray: %@", dictArray);
}

@end
