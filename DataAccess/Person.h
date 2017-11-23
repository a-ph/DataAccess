//
//  Person.h
//  DataAccess
//
//  Created by Eaph Sing on 2017/11/23.
//  Copyright © 2017年 Ray Wenderlich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (instancetype)initName:(NSString *)name age:(NSInteger)age;
+ (instancetype)personName:(NSString *)name age:(NSInteger)age;

@end
