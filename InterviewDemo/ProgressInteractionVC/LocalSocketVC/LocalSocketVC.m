//
//  LocalSocketVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/30.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  局部通信

#define kPointX 30
#import "LocalSocketVC.h"
#import "CommonWebVC.h"
@interface LocalSocketVC ()

@property (nonatomic, strong) UILabel   *contentLabel;

@end

@implementation LocalSocketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"局部通信";
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *rightBtn = [UtilTools rightBarButtonItem];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [self.view addSubview:self.contentLabel];
}

- (void)rightBtnClick{
    CommonWebVC *webVC = [[CommonWebVC alloc] init];
    webVC.titleStr = @"LocalSocket";
    webVC.urlStr = @"https://www.cnblogs.com/JJDev/p/5873233.html";
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - 初始化控件
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPointX, kPointX + kNavibarHeight, kScreenWidth - kPointX * 2, kScreenHeight - kPointX * 2 - kNavibarHeight)];
        _contentLabel.font = [UIFont boldSystemFontOfSize:14];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.numberOfLines = 0;
        _contentLabel.text = @"实现原理：App1在端口port1234进行TCP的bind和listen,另外一个App2在同一个端口发起TCP的connect连接，这样就可以创建正常的TCP连接，进行TCP通信，此时像传什么数据就可以传什么数据了。\n特点：灵活，只要保持着连接就可以传任何相关的数据，而且宽带足够大。\n缺点：iOS 系统在任意时刻只能有一个APP在前台运行，所以另外一个APP要具有后台运行的权限，例如导航、音乐类APP。\n使用场景：APP1具体特殊能力，能够与硬件进行通信，在硬件上处理相关数据。APP2没有这个能力，但能给APP1提供相关数据。这样APP2跟APP1建立本地的socket连接，传输数据到APP1，然后APP1把数据传给硬件进行处理。";
    }
    return _contentLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
