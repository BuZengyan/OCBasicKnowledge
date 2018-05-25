//
//  NSObject+KVO.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/17.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  分类

#import "NSObject+KVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (KVO)

// 自定义观察者
- (void)ZY_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    // 动态创建一个类
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *newClassName = [@"ZYKVO_" stringByAppendingString:oldClassName];
    const char *newName = [newClassName UTF8String];
    Class zy_Class = objc_allocateClassPair([self class], newName, 0); // 创建新类
    
    // 添加setter方法，相当于重写setter方法，v:返回值类型 @参数类型
    // OC(消息发送机制)，方法由两部分组成，方法编号@selector 和实现方法（imp方法指针），先找方法编号，在得到方法的指针，在执行方法的代码块。
    class_addMethod(zy_Class, @selector(setAge:), (IMP)setAge, "v@:i");
    // 注册新添加的这个类
    objc_registerClassPair(zy_Class);
    // 修改修改isa指针：isa指针由指向Animal类改为指向zy_class类
    object_setClass(self, zy_Class);
    
    //将观察者的属性保存到当前类里面去
    objc_setAssociatedObject(self, (__bridge const void *)@"objc", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//相当于重写父类的方法

void setAge(id self, SEL _cmd, int age) {
   // 保存当前类
//    Class myClass = [self class];
//    // 将self的指针指向父类
//    object_setClass(self, class_getSuperclass([self class]));
//    // 调用父类
//    objc_msgSend(self, @selector(setAge:),age);
//    // 拿出观察者
//    objc_getAssociatedObject(self, (__bridge const void *)@"objc");
//    // 通知观察者
////    objc_msgSend(objc, @selector(observeValueForKeyPath:ofObject:change:context:),self,age,nil,nil);
////    //通知观察者
////
////    objc_msgSend(objc,@selector(observeValueForKeyPath:ofObject:change:context:),self,age,nil,nil);
    
    //保存当前类
    Class myclass = [self class];
    //将self的isa指针指向父类
    object_setClass(self, class_getSuperclass([self class]));
    //调用父类
    objc_msgSend(self, @selector(setAge:),age);
    //拿出观察者
    objc_getAssociatedObject(self, (__bridge const void *)@"objc");
    //通知观察者
    objc_msgSend(self,@selector(observeValueForKeyPath:ofObject:change:context:),self,age,nil,nil);
    //改为子类
    object_setClass(self, myclass);
    
}
@end
