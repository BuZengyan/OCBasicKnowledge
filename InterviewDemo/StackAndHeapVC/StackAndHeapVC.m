//
//  StackAndHeapVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/22.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  栈和堆


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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *img = [UIImage xh_imageNamed:@"001.png"];
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(0, kNavibarHeight, kScreenWidth, ((kScreenHeight - kNavibarHeight)/4)*3 );
    imgView.image = img;

    imgView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:imgView];

    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blueColor];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.numberOfLines = 0;
    label.text = @"参考文献（https://blog.csdn.net/shi520fu/article/details/70237459）";
    label.frame = CGRectMake(0, imgView.frame.origin.y + imgView.frame.size.height, kScreenWidth,kScreenHeight - kNavibarHeight - imgView.frame.size.height);
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, imgView.frame.origin.y + imgView.frame.size.height, kScreenWidth,kScreenHeight - kNavibarHeight - imgView.frame.size.height);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
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
