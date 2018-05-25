//
//  UIImage+TestUIImage.h
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/14.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TestUIImage)
/**
 *  方法拦截
 */
+ (UIImage *)xh_imageNamed:(NSString *)name;
@end
