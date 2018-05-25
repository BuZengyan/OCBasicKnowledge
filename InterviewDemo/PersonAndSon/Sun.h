//
//  Sun.h
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/16.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import "Person.h"

typedef NS_ENUM(NSInteger, Sunage){
    SunageDefault = 1,
    SunageSet = 2
};

typedef NS_ENUM(NSInteger, SunName) {
    SunNameDefault = 1,
    SunNameSet = 2
};

typedef NS_ENUM(NSInteger, SunSexName) {
    SunSexDefault = 1,
    SunSexSet = 2
};


@interface Sun : Person

@end
