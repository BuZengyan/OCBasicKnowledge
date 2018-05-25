//
//  CustomRunLoopVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/21.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import "CustomRunLoopVC.h"
#import <WebKit/WebKit.h>
#import "CommonWebVC.h"

@interface CustomRunLoopVC ()

@end

@implementation CustomRunLoopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RunLoop";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, kNavibarHeight, kScreenWidth, 200);
    [btn setTitle:@"参考文献：https://www.jianshu.com/p/296f182c8faa" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

- (void)btnClick{
    CommonWebVC *vc = [[CommonWebVC alloc] init];
    vc.titleStr = @"RunLoop";
    vc.urlStr = @"https://www.jianshu.com/p/296f182c8faa";
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
