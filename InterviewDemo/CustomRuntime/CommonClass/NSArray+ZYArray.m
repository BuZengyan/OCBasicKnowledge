//
//  NSArray+ZYArray.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/18.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  类簇:防止数组越界崩溃，及定位崩溃位置

#import "NSArray+ZYArray.h"
#import <objc/runtime.h>

@implementation NSArray (ZYArray)
+ (void)load{
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(zy_objectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
}

- (id)zy_objectAtIndex:(NSUInteger)index{
    // 下标判断
    if (self.count - 1 < index) {
        // 异常判断
        @try{
            return [self zy_objectAtIndex:index];
        }
        @catch (NSException *execption){
            // 在崩溃后打印崩溃信息，方便我们调试。
            NSLog(@"======= %s Crash Because Method %s ======= \n",class_getName(self.class),__func__);
            NSLog(@"%@",[execption callStackSymbols]);
            return nil;
        }
        @finally{}
    }else{
        return [self zy_objectAtIndex:index];
    }
}

@end
