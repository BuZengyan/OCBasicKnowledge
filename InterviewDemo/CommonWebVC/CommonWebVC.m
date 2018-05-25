//
//  CommonWebVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/21.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import "CommonWebVC.h"
#import <WebKit/WebKit.h>

@interface CommonWebVC ()<WKUIDelegate,WKNavigationDelegate>

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
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

#pragma mark - webViewDelegate
// 1.请求之前，决定是否跳转：用户点击网页上的连接，需要打开新页面时，将先调用这个方法。
- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
    [UtilTools showLoading];
}

// 2.开始加载页面时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
   
}

// 3.接收相应数据后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
//    [UtilTools hiddenSvp];
}

// 4.页面加载完成时调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

    [UtilTools hiddenSvp];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
