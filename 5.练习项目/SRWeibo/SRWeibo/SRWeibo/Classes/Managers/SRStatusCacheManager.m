//
//  SRStatusCacheTool.m
//  SRWeibo
//
//  Created by 郭伟林 on 15/9/30.
//  Copyright (c) 2015年 郭伟林. All rights reserved.
//

#import "SRStatusCacheManager.h"
#import "FMDB.h"

@implementation SRStatusCacheManager

static FMDatabase *_database;

+ (void)initialize {
    // 初始化数据库
    _database = [FMDatabase databaseWithPath:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.data"]];
    // 打开数据库
    [_database open];
    // 创建表
    [_database executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status (id integer PRIMARY KEY, status blob NOT NULL, idstr text NOT NULL);"];
}

+ (NSArray *)statusesWithParams:(NSDictionary *)params {
    NSString *SQLString;
    if (params[@"since_id"]) {
        SQLString = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20;", params[@"since_id"]];
    } else if (params[@"max_id"]) {
        SQLString = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr <= %@ ORDER BY idstr DESC LIMIT 20;", params[@"max_id"]];
    } else {
        SQLString = @"SELECT * FROM t_status ORDER BY idstr DESC LIMIT 20;";
    }
    FMResultSet *resultSet = [_database executeQuery:SQLString];
    NSMutableArray *dictArrayM = [NSMutableArray array];
    while (resultSet.next) {
        NSData *data = [resultSet objectForColumnName:@"status"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [dictArrayM addObject:dict];
    }
    return dictArrayM;
}

+ (void)saveStatuses:(NSArray *)statuses {
    for (NSDictionary *dict in statuses) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        [_database executeUpdateWithFormat:@"INSERT INTO t_status(status, idstr) VALUES (%@, %@);", data, dict[@"idstr"]];
    }
}

@end
