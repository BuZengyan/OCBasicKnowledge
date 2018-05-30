//
//  StackAndHeapVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/22.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  栈和堆

#define kPointX 30

#import "StackAndHeapVC.h"
#import "CommonWebVC.h"
#import "UIImage+TestUIImage.h"
@interface StackAndHeapVC ()

@end

@implementation StackAndHeapVC
int num = 1;    // 数据区/静态区
NSString *str;  // BSS区/静态区
static NSString *str2 = @"str"; //

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"栈和堆";
    self.view.backgroundColor = kBlueColor;

    UIImage *img = [UIImage xh_imageNamed:@"001.png"];
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(0, kNavibarHeight + 0, kScreenWidth, ((kScreenHeight - kNavibarHeight)/4)*3 );
    imgView.image = img;
    [self.view addSubview:imgView];

    [self customRightButtonItem];
    
}

#pragma mark - 导航栏右侧按钮
- (void)customRightButtonItem{
    UIButton *rightBtn = [UtilTools rightBarButtonItem];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)rightBtnClick{
    NSString *urlStr = @"https://blog.csdn.net/shi520fu/article/details/70237459";
    CommonWebVC *vc = [[CommonWebVC alloc] init];
    vc.urlStr = urlStr;
    vc.titleStr = @"堆和栈";
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)btnClick{
    NSString *urlStr = @"https://blog.csdn.net/shi520fu/article/details/70237459";
    CommonWebVC *vc = [[CommonWebVC alloc] init];
    vc.urlStr = urlStr;
    vc.titleStr = @"堆和栈";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
