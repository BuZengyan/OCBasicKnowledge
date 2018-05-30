//
//  AppTurnToOtherAppVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/23.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  APP间的跳转及传值

#define kButtonWidth (200)
#define kButtonHeight (36)
#define kPointY (30.0f)

#import "AppTurnToOtherAppVC.h"
#import "CommonWebVC.h"

@interface AppTurnToOtherAppVC ()

@property (nonatomic, strong)   UIButton    *turnToOtherAppBtn;
@property (nonatomic, strong)   UIButton    *turnToPointPageTwoBtn;
@property (nonatomic, strong)   UIButton    *turnToPointPageOneBtn;

@end

@implementation AppTurnToOtherAppVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"APP间的跳转";
    self.view.backgroundColor = kBlueColor;
    [self.view addSubview:self.turnToOtherAppBtn];
    [self.view addSubview:self.turnToPointPageOneBtn];
    [self.view addSubview:self.turnToPointPageTwoBtn];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 44)];
    // 参考文献
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 22 * i, 120, 22);
        NSString *urlStr = nil;
        if (i == 0) {
            urlStr = @"https://blog.csdn.net/wangqinglei0307/article/details/78685058";
        }else{
            urlStr = @"https://www.jianshu.com/p/b5e8ef8c76a3";
        }
        NSString *btnTitle = [NSString stringWithFormat:@"参考文献%ld",i + 1];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.tag = i + 1000;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [rightView addSubview:btn];
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
}

#pragma mark - 初始化控件
- (UIButton *)turnToOtherAppBtn{
    if (!_turnToOtherAppBtn) {
        _turnToOtherAppBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _turnToOtherAppBtn.frame = CGRectMake((kScreenWidth - kButtonWidth) / 2,kNavibarHeight + kPointY, kButtonWidth, kButtonHeight);
        _turnToOtherAppBtn.layer.masksToBounds = YES;
        _turnToOtherAppBtn.layer.cornerRadius = kButtonHeight / 2;
        _turnToOtherAppBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _turnToOtherAppBtn.layer.borderWidth = 1;
        _turnToOtherAppBtn.backgroundColor = [UIColor orangeColor];
        _turnToOtherAppBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_turnToOtherAppBtn setTitle:@"跳转到OtherApp" forState:UIControlStateNormal];
        [_turnToOtherAppBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_turnToOtherAppBtn addTarget:self action:@selector(turnToOtherAppClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _turnToOtherAppBtn;
}

- (UIButton *)turnToPointPageOneBtn{
    if (!_turnToPointPageOneBtn) {
        _turnToPointPageOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _turnToPointPageOneBtn.frame = CGRectMake((kScreenWidth - kButtonWidth) / 2,kNavibarHeight + kPointY + kPointY + kButtonHeight, kButtonWidth, kButtonHeight);
        _turnToPointPageOneBtn.layer.masksToBounds = YES;
        _turnToPointPageOneBtn.layer.cornerRadius = kButtonHeight / 2;
        _turnToPointPageOneBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _turnToPointPageOneBtn.layer.borderWidth = 1;
        _turnToPointPageOneBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _turnToPointPageOneBtn.tag = 111;
        _turnToPointPageOneBtn.backgroundColor = [UIColor orangeColor];
        [_turnToPointPageOneBtn setTitle:@"跳转到指定页面PageOne" forState:UIControlStateNormal];
        [_turnToPointPageOneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_turnToPointPageOneBtn addTarget:self action:@selector(turnToPointPageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _turnToPointPageOneBtn;
}

- (UIButton *)turnToPointPageTwoBtn{
    if (!_turnToPointPageTwoBtn) {
        _turnToPointPageTwoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _turnToPointPageTwoBtn.frame = CGRectMake((kScreenWidth - kButtonWidth) / 2,kNavibarHeight + kPointY + kPointY * 2 + kButtonHeight * 2, kButtonWidth, kButtonHeight);
        _turnToPointPageTwoBtn.layer.masksToBounds = YES;
        _turnToPointPageTwoBtn.layer.cornerRadius = kButtonHeight / 2;
        _turnToPointPageTwoBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        _turnToPointPageTwoBtn.layer.borderWidth = 1;
        _turnToPointPageTwoBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _turnToPointPageTwoBtn.tag = 222;
        _turnToPointPageTwoBtn.backgroundColor = [UIColor orangeColor];
        [_turnToPointPageTwoBtn setTitle:@"跳转到指定页面PageTwo" forState:UIControlStateNormal];
        [_turnToPointPageTwoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_turnToPointPageTwoBtn addTarget:self action:@selector(turnToPointPageClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _turnToPointPageTwoBtn;
}

- (void)turnToOtherAppClick{
    NSLog(@"跳转到otherAPP");
    /**
     *  如果需要从跳转到的APP再跳转回来，则需要将跳转APP的schemes传给跳转到的APP
     *  约定格式：协议名://应用B的URL Schemes?应用A的URL Schemes
     *  即 @"OpenOtherAppDemo://ZengYan.bu.OpenOtherAppDemo ？InterviewDemo";
     */
    NSString *urlStr = @"MapNewApp://com.born.mapNew";
    urlStr = @"BaozunReportNew://ZengYan.bu.OpenOtherAppDemo?InterviewDemo";
    [self pushToOtherAppWith:urlStr];

}

#pragma mark - 跳转到指定页面
- (void)turnToPointPageClick:(UIButton *)btn{
    NSString *urlStr = @"MapNewApp://";
    urlStr = @"BaozunReportNew://PageTwo?InterviewDemo";
    if (btn.tag == 111) {
        urlStr = @"MapNewApp://";
         urlStr = @"BaozunReportNew://PageOne?InterviewDemo";
    }
    [self pushToOtherAppWith:urlStr];
}

#pragma mark - 跳转urlStr
- (void)pushToOtherAppWith:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    if (@available(iOS 10.0, *)) {
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                // 完成回调
                NSLog(@"完成回调");
                if (success == NO) {
                    NSLog(@"没有安装APP，到App Store下载");
                }else{
                    NSLog(@"打开了APP");
                }
            }];
        }
    }else {
        // 注意：canOpenURL在iOS9.0之后使用的话，需要将跳转到的APP的URL Schemes加入到白名单中，否则此方法无效。
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }else{
            NSLog(@"没有按装APP");
        }
    }
}

#pragma mark - 参考文献
- (void)btnClick:(UIButton *)btn{
    NSString *url = nil;
    NSString *titleStr = nil;
    if (btn.tag - 1000 == 0) {
        // 参考文献1：
        url = @"https://blog.csdn.net/wangqinglei0307/article/details/78685058";
        titleStr = @"参考文献1";
    }else{
        // 参考文献2：
         url = @"https://www.jianshu.com/p/b5e8ef8c76a3";
        titleStr = @"参考文献2";
    }
    CommonWebVC *web = [[CommonWebVC alloc] init];
    web.urlStr = url;
    web.titleStr = titleStr;
    [self.navigationController pushViewController:web animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
