//
//  AppGroupsVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/30.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  APP groups：通Team的APP共享

#define kPointX 30
#import "AppGroupsVC.h"
#import "CommonWebVC.h"

@interface AppGroupsVC ()
@property (nonatomic, strong)   UILabel *label;
@end

@implementation AppGroupsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"APP Groups";
    self.view.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.label];
    
    UIButton *button = [UtilTools rightBarButtonItem];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}


- (void)btnClick{
    CommonWebVC *vc = [[CommonWebVC alloc] init];
    vc.urlStr = @"https://blog.csdn.net/shengpeng3344/article/details/52190997";
    vc.titleStr = @"APP Groups";
    [self.navigationController pushViewController:vc animated:YES];

}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(kPointX, kPointX + kNavibarHeight , kScreenWidth - kPointX * 2, kScreenHeight - kNavibarHeight - kPointX)];
        _label.text = @"APP Groups 主要用于同Team开发的多个APP共享数据源，例如多平台账号登录、将登录信息保存到KeyChain中，只要一个APP登录过，通Team的APP就可以访问KeyChain中的数据，实现自动登录。\n详细介绍及使用已放到KeyChain章本中。";
        _label.font = [UIFont boldSystemFontOfSize:14];
        _label.numberOfLines = 0;
        _label.textColor = [UIColor whiteColor];
    }
    return _label;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
