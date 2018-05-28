//
//  UtilTools.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/25.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  公共方法类

#import "UtilTools.h"
#import "KeyChainTools.h"

@implementation UtilTools

+ (void)showLoading{
    [SVProgressHUD showLoading];
}

+ (void)hiddenSvp{
    [SVProgressHUD hiddenLoading];
}


+ (UIButton *)rightBarButtonItem{
    UIButton *rightItemView = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItemView.frame = CGRectMake(0, 0, 80, 44);
    [rightItemView setTitle:@"参考文献" forState:UIControlStateNormal];
    [rightItemView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    rightItemView.titleLabel.font = [UIFont systemFontOfSize:16];
//    [rightItemView addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightItemView];
    return rightItemView;
}



@end
