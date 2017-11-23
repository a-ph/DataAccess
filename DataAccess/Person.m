//
//  Person.m
//  DataAccess
//
//  Created by Eaph Sing on 2017/11/23.
//  Copyright © 2017年 Ray Wenderlich. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}

- (instancetype)initName:(NSString *)name age:(NSInteger)age {
    if ((self = [super init])) {
        _name = name;
        _age = age;
    }
    return self;
}
+ (instancetype)personName:(NSString *)name age:(NSInteger)age {
    return  [[self alloc] initName:name age:age];
}

@end
