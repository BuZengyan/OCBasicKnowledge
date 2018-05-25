//
//  CommonWebVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/21.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import "CommonWebVC.h"
#import <WebKit/WebKit.h>
@interface CommonWebVC ()

@property (nonatomic, strong)   WKWebView *webView;

@end

@implementation CommonWebVC

- (void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    self.view.backgroundColor = [UIColor whiteColor];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, kNavibarHeight, kScreenWidth, kScreenHeight - kNavibarHeight)];
    }
    return _webView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
