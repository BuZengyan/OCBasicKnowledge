//
//  UIImageView+UIImageViewSelf.h
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/14.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (UIImageViewSelf)
/*
 *  方法拦截
 */
+ (UIImageView *)test_init:(UIImage *)image;
@end
