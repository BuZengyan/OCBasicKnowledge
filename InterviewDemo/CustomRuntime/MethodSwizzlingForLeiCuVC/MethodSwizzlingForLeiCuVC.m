//
//  MethodSwizzlingForLeiCuVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/18.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  runtime黑魔法：Method swizzling 类簇

#import "MethodSwizzlingForLeiCuVC.h"
#import <objc/runtime.h>

@interface MethodSwizzlingForLeiCuVC ()

@end

@implementation MethodSwizzlingForLeiCuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"类簇";
    self.view.backgroundColor = [UIColor whiteColor];
    

    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
