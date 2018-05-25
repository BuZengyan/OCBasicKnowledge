//
//  UIViewController+MethodSwizzlingVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/18.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  runtime的黑魔法：method swizzling

#import "UIViewController+MethodSwizzlingVC.h"
#import <objc/runtime.h>

@implementation UIViewController (MethodSwizzlingVC)

+ (void)load{
    // 通过class_getInstanceMethod()函数从当前对象中的Method List获取Method结构体，如果是类方法使用class_getClassMethod()函数获取
    // 被替换的方法
    Method fromMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method toMethod = class_getInstanceMethod([self class], @selector(swizzling_viewDidLoad));
    
    /**
     *  先验证在交换方法
     *  使用class_addMethod()函数对Method Swizzling 做了一层验证，如果self没有实现被交换的方法，但父类有这个方法，这样就会调用父类的方法，结果就不是我们想要的了。所以我们这里通过class_addMethod（）的验证，如果self实现了这个方法，class_addMethod()函数将会返回NO,我们就可以对其进行交换了，
     */
    if (!class_addMethod([self class], @selector(swizzling_viewDidLoad), method_getImplementation(toMethod), method_getTypeEncoding(toMethod))) {
        method_exchangeImplementations(fromMethod, toMethod);
    }
}

// 自己实现的方法：也就是和self 的viewDidLoad方法进行交换的方法
- (void)swizzling_viewDidLoad{
    NSString *str = [NSString stringWithFormat:@"%@",self.class];
    // 将系统的UIViewController的对象剔除掉
    if (![str containsString:@"UI"]) {
        NSLog(@"统计大点:%@",self.class);
    }
    
    // 由于方法已经交换，所以再此处调用的是系统的viewDidLoad
    [self swizzling_viewDidLoad];
}
@end
