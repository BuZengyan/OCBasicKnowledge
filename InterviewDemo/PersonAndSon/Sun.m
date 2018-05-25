//
//  Sun.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/16.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import "Sun.h"

@implementation Sun
- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"%@",NSStringFromClass([self class]));
        NSLog(@"%@",NSStringFromClass([super class]));
    }
    return self;
}

@end
