//
//  CustomShowContentVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/23.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  展示内容的VC

#define kPointX 0
#define kTestPustToOtherApp YES

#import "CustomShowContentVC.h"
#import "CommonWebVC.h"

@interface CustomShowContentVC ()
@property (nonatomic, strong)   UILabel *label;
@end

@implementation CustomShowContentVC

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
}

- (void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
}

- (void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    self.view.backgroundColor = kWhiteColor;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(kPointX, kNavibarHeight, kScreenWidth - kPointX * 2, kScreenHeight - kNavibarHeight - kNavibarHeight - kNavibarHeight * 2)];
    self.label.text = self.contentStr;
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont systemFontOfSize:16];
    self.label.backgroundColor = [UIColor orangeColor];
    self.label.numberOfLines = 0;
    [self.view addSubview:self.label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, kScreenHeight - kNavibarHeight * 3, kScreenWidth, kNavibarHeight * 3);
    NSString *btnTitleStr = [NSString stringWithFormat:@"参考文献：%@",self.urlStr];
    [button setTitle:btnTitleStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)btnClick{
#ifdef kTestPustToOtherApp
    // 跳转到其它APP
    NSString *urlStr = @"OpenOtherAppDemo://ZengYan.bu.OpenOtherAppDemo";
    NSURL *url = [NSURL URLWithString:urlStr];
    // 1.判断系统版本
    [self turnToOtherAppWith:url];
#else
    CommonWebVC *vc = [[CommonWebVC alloc] init];
    vc.urlStr = self.urlStr;
    vc.titleStr = self.titleStr;
    [self.navigationController pushViewController:vc animated:YES];
#endif
}

#pragma mark - 跳转到其它APP
- (void)turnToOtherAppWith:(NSURL *)url{
    if (@available(iOS 11.0, *)) {
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                // 完成回调
            }];
        }
    }else{
        double systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
        
        if (systemVersion >= 10.0) {
            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                    // 完成回调
                }];
            }
        } else {
            if ([[UIApplication sharedApplication] openURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
