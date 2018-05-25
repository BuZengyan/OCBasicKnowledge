//
//  CustomRunLoopVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/21.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import "CustomRunLoopVC.h"
#import <WebKit/WebKit.h>

@interface CustomRunLoopVC ()<UIWebViewDelegate>
@property (nonatomic, strong)   UIWebView *webView;
@end

@implementation CustomRunLoopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RunLoop";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.webView];
    
    NSURL *url = [NSURL URLWithString:@"https://www.jianshu.com/p/296f182c8faa"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = CGRectMake(0, kNavibarHeight, kScreenWidth, kScreenHeight - kNavibarHeight);
        _webView.scalesPageToFit = YES;
        _webView.delegate = self;
    }
    return _webView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
