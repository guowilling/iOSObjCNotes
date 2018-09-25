//
//  ViewController.m
//  数据存储-归档解档
//
//  Created by 郭伟林 on 15/9/18.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)saveObject {
    
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    Person *person = [[Person alloc] init];
    person.name = @"GWL";
    person.age = 25;
    NSString *personPath = [documents stringByAppendingPathComponent:@"person.data"];
    [NSKeyedArchiver archiveRootObject:person toFile:personPath];
    
    Student *student = [[Student alloc] init];
    student.name = @"GWL";
    student.age = 25;
    student.number = 20115338;
    NSString *studentPath = [documents stringByAppendingPathComponent:@"student.data"];
    [NSKeyedArchiver archiveRootObject:student toFile:studentPath];
}

- (IBAction)readObject {
    
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *personPath = [documents stringByAppendingPathComponent:@"person.data"];
    Person *person = [NSKeyedUnarchiver unarchiveObjectWithFile:personPath];
    NSLog(@"person: %@", person);
    
    NSString *studentPath = [documents stringByAppendingPathComponent:@"student.data"];
    Student *student = [NSKeyedUnarchiver unarchiveObjectWithFile:studentPath];
    NSLog(@"student: %@", student);
}

@end
