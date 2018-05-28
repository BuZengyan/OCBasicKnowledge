//
//  CommonCustomButton.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/28.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  公共button类

#import "CommonCustomButton.h"

@implementation CommonCustomButton

+ (UIButton *)customButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 8;
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}

@end
