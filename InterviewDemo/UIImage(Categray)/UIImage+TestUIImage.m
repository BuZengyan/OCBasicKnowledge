//
//  UIImage+TestUIImage.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/14.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import "UIImage+TestUIImage.h"
#import <objc/runtime.h>

@implementation UIImage (TestUIImage)

//

+ (UIImage *)xh_imageNamed:(NSString *)name{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (version < 7.0) {
        name = [name stringByAppendingString:@"_os7"];
    }
    return [UIImage xh_imageNamed:name];
}
 

/**
 *  方法lan
 */
// 重写UIImage load方法交方法
+ (void)load{
    // 获取两个类方法
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(xh_imageNamed:));
    // 交互方法实现
    method_exchangeImplementations(m1, m2);
}
@end
