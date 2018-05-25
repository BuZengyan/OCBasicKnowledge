//
//  Person.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/14.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import "Person.h"
@interface Person()<NSCopying>

@end
@implementation Person

- (id)copyWithZone:(NSZone *)zone{
    Person *p = [[[self class] alloc] init];
    return p;
}

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
+ (void)run{
    // 跑
    NSLog(@"跑");
}

+ (void)study{
    NSLog(@"学习");
}
@end
