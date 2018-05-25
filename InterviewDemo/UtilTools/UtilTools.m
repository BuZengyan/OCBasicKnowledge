//
//  UtilTools.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/25.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  公共方法类

#import "UtilTools.h"

@implementation UtilTools

+ (void)showLoading{
    [SVProgressHUD showLoading];
}

+ (void)hiddenSvp{
    [SVProgressHUD hiddenLoading];
}

@end
