//
//  NSObject+AssociatedObject.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/18.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  分类一般是不能添加属性的，但可以利用runtime动态的添加属性

#import "NSObject+AssociatedObject.h"
#import <objc/runtime.h>

@implementation NSObject (AssociatedObject)

// 不重写set 和 get方法，属性无效。
- (void)setAssociatedObject:(id)associatedObject{
    objc_setAssociatedObject(self,@selector(associatedObject),associatedObject,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedObject{
    NSString *tempStr = objc_getAssociatedObject(self, _cmd);
//    return objc_getAssociatedObject(self, _cmd);
    return tempStr;
}

@end
