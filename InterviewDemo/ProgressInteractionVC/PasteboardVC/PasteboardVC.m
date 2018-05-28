//
//  PasteboardVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/28.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  进程通信：3.粘贴板

#define kPointX (30.0f)
#define kButtonHeight (44.0f)

#import "PasteboardVC.h"
#import "CommonWebVC.h"
#import "CopyView.h"

@interface PasteboardVC ()
@property (nonatomic, strong)   UIButton    *btn;
@property (nonatomic, strong)   CopyView    *testCopyView;
@end

@implementation PasteboardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"粘贴板";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UtilTools rightBarButtonItem];
    [btn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    
    [self.view addSubview:self.btn];
    [self.view addSubview:self.testCopyView];
    
    // 创建系统剪切板
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    // 从剪切板中写入淘宝口令
    [pasteboard setString:@"复制这条信息，打开✋手机淘宝✋即可看到【天猫.天天搞机】￥AAJ0jvII￥"];
}

#pragma mark - 初始化控件
- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(kPointX, kPointX + kNavibarHeight, kScreenWidth - kPointX * 2, kButtonHeight);
        _btn.backgroundColor = [UIColor orangeColor];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn setTitle:@"打开粘贴板" forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:14];
        _btn.layer.masksToBounds = YES;
        _btn.layer.cornerRadius = kButtonHeight / 2;
        [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (CopyView *)testCopyView{
    if (!_testCopyView) {
        _testCopyView = [[CopyView alloc] initWithFrame:CGRectMake(0, kNavibarHeight + kPointX + kButtonHeight + kPointX, kScreenWidth, 200)];
    }
    return _testCopyView;
}

#pragma mark - 点击事件
- (void)btnClick:(UIButton *)btn{
    // 创建系统剪切板
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:@"复制这条信息，打开✋手机淘宝✋即可看到【天猫.天天搞机】￥AAJ0jvII￥"];
    // 淘宝APP从后台切换到前台时，从系统剪切板中读取淘宝口令进行显示
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"淘口令" message:pasteboard.string delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"立即查看", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"取消"]) {
        //
    }else if ([btnTitle isEqualToString:@"立即查看"]){
        NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/wei-xin/id414478124?mt=8"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

- (void)rightClick{
    CommonWebVC *webVC = [[CommonWebVC alloc] init];
    webVC.titleStr = @"剪切板";
    webVC.urlStr = @"https://www.jianshu.com/p/1213f9f00fdd";
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
