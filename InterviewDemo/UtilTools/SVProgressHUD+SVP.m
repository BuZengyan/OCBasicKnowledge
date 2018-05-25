//
//  SVProgressHUD+SVP.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/25.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  提示

#import "SVProgressHUD+SVP.h"

@implementation SVProgressHUD (SVP)
+ (void)showLoading{
    [SVProgressHUD showWithStatus:@"加载中..."];
}

+ (void)hiddenLoading{
    [SVProgressHUD dismiss];
}
@end
