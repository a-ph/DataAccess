//
//  ViewController.m
//  DataAccess
//
//  Created by Eaph Sing on 2017/11/23.
//  Copyright © 2017年 Ray Wenderlich. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <FMDB.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //plist   xml文件形式  ************
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"data"];
    NSLog(@"%@",filePath);
    
    NSArray *array = @[@"123",@"234"];
    [array writeToFile:filePath atomically:YES];
    
    //1.获得NSUserDefaults文件   *************
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //2.向文件中写入内容
    [userDefaults setObject:@"AAA" forKey:@"a"];
    [userDefaults setBool:YES forKey:@"sex"];
    [userDefaults setInteger:21 forKey:@"age"];
    //2.1立即同步
    [userDefaults synchronize];
    
    //nskeyedArchiver   ****************
    NSString *name = [userDefaults objectForKey:@"a"];
    BOOL sex = [userDefaults boolForKey:@"sex"];
    NSInteger age = [userDefaults integerForKey:@"age"];
    
    NSLog(@"%@, %d, %ld", name, sex, age);
    
    NSString *fileName = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"data.xxx"];
    Person *person = [[Person alloc] init];
    person.name = @"Qang";
    person.age = 1;
    Person *person2 = [Person personName:@"li" age:4];
    NSLog(@"%@",person2);
    //归档
    [NSKeyedArchiver archiveRootObject:person toFile:fileName];
    
    //解档
    Person *getPerson = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    NSLog(@"getPerson.name = %@, getPerson.age = %ld", getPerson.name, (long)getPerson.age);
    
    //FMDB  *************
    NSString *FMDBfileName = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"FMDBdata.db"];
    FMDatabase *database = [FMDatabase databaseWithPath:FMDBfileName];
    if (![database open]) {
        NSLog(@"数据库打开失败!");
    }else {
//        [database executeUpdate:@"DROP TABLE IF EXISTS t_person"];
//        [database close];
        [database executeUpdate:@"CREATE TABLE IF NOT EXISTS t_person(id integer primary key autoincrement, name text, age integer)"];
//
        for (NSInteger i = 0; i < 10000; i++) {
            NSString *name = [NSString stringWithFormat:@"fmdb name %d", arc4random_uniform(10000)];
            NSInteger age = arc4random_uniform(80) + 20;
            [database executeUpdate:@"insert into t_person(name,age) values (?,?)", name, @(age)];
        }

        //1.执行查询
        FMResultSet *result = [database executeQuery:@"SELECT * FROM t_person"];

        //2.遍历结果集
        NSMutableArray *array = [NSMutableArray new];
        while ([result next]) {
            NSString *name = [result stringForColumn:@"name"];
            int age = [result intForColumn:@"age"];
            [array addObject:@{@"name":name,
                               @"age":@(age)
                               }];
        }
        NSLog(@"%ld", array.count);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
