//
//  NSObject+KVO.h
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/17.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  分类

#import <Foundation/Foundation.h>

@interface NSObject (KVO)

/**
 *  自定义监听方法
 */
- (void)ZY_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(void *)context;

@end
