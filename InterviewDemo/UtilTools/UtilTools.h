//
//  UtilTools.h
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/25.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  公共方法类

#import <Foundation/Foundation.h>

@interface UtilTools : NSObject

/**
 *  显示加载
 */
+ (void)showLoading;

/**
 *  加载完成
 */
+ (void)hiddenSvp;

/**
 *  右侧导航栏
 */
+ (UIButton *)rightBarButtonItem;

/**
 *  commonLabel
 */
+ (UILabel *)commonLabel;

/**
 *  commonButton
 */
+ (UIButton *)commonButton;
@end
