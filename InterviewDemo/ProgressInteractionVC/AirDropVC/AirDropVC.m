//
//  AirDropVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/30.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import "AirDropVC.h"

@interface AirDropVC ()

@end

@implementation AirDropVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"AirDrop数据分享";
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(30, 30 + kNavibarHeight, kScreenWidth - 60, kScreenHeight - 60 - kNavibarHeight);
    label.numberOfLines = 0;
    label.text = @"通过AirDrop实现不同设备的APP之间的文档数据分享";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
