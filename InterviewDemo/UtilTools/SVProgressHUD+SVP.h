//
//  SVProgressHUD+SVP.h
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/25.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  提示

#import "SVProgressHUD.h"

@interface SVProgressHUD (SVP)
/**
 *  加载中
 */
+ (void)showLoading;

/**
 *  加载成功：消失
 */
+ (void)hiddenLoading;
@end
