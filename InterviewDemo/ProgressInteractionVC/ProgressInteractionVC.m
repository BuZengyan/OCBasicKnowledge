//
//  ProgressInteractionVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/23.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  进程间的通信

#define kCellHeight (44.0f)
#import "ProgressInteractionVC.h"
#import "CustomShowContentVC.h"
#import "KeyChainVC.h"

@interface ProgressInteractionVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)   NSMutableArray  *urlArray;
@property (nonatomic, strong)   NSMutableArray  *dataArray;
@property (nonatomic, strong)   NSMutableArray  *contentArray;
@property (nonatomic, strong)   NSMutableArray  *viewControllersArray;
@property (nonatomic, strong)   UITableView     *mainTableView;
@end

@implementation ProgressInteractionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"进程间的通信";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mainTableView];
}

#pragma mark - 初始化数据源
- (NSMutableArray *)urlArray{
    if (!_urlArray) {
        _urlArray = [[NSMutableArray alloc] init];
        [_urlArray addObject:@"https://blog.csdn.net/kuangdacaikuang/article/details/78891379"];
        [_urlArray addObject:@"https://blog.csdn.net/kuangdacaikuang/article/details/78891379"];
    }
    return _urlArray;
}

- (NSMutableArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [[NSMutableArray alloc] init];
        [_contentArray addObject:@"iOS 开发中，最常用的进程间的通信方式。从一个APP唤醒另外一个APP（openURL)，如需要参数可以在URL中拼上参数。常使用场景：微信、QQ、QQ空间等分享，支付宝、微信支付。\n具体流程:配置被唤醒者APP的URL TYPES，包括identifier,url schemes,唤醒者APP通过openURL打开被唤醒者\n\n具体可参考首页APP间的相互跳转😊🤓🤓🤓🤓🤓🤓"];
        [_contentArray addObject:@"Keychain是iOS系统的一个安全容器，存储在它里面的内容都是经过加密的，主要用于存储一些登录信息和身份验证信息。它独立于其他APP的沙盒之外，所以只要登录过，即使删除了APP，该APP的登录信息仍然存在。苹果自己也用Keychain用于存储VPN和WiFi信息。典型的应用场景：统一账户登录平台，使用统一账户登录多个APP。只要一个账户，其他APP就不需要再次输入用户名和密码，可以实现自动登录。例如，一般开发平台会提供登录SDK，会在SDK内部将登录信息写入到Keychain中去，所以只要一个APP登录，其他APP可以共享登录。"];
    }
    return _contentArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        [_dataArray addObject:@"1.URL Scheme"];
        [_dataArray addObject:@"2.KeyChain"];
    }
    return _dataArray;
}

- (NSMutableArray *)viewControllersArray{
    if (!_viewControllersArray) {
        _viewControllersArray = [[NSMutableArray alloc] init];
        [_viewControllersArray addObject:@"CustomShowContentVC"];
        [_viewControllersArray addObject:@"KeyChainVC"];
    }
    return _viewControllersArray;
}

#pragma  mark - 初始化控件
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavibarHeight, kScreenWidth, kScreenHeight - kNavibarHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
    }
    return _mainTableView;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"cellStr";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *vcStr = [self.viewControllersArray objectAtIndex:indexPath.row];
    Class class = NSClassFromString(vcStr);
    if (class) {
        UIViewController *vc = class.new;
        if ([vc isKindOfClass:[KeyChainVC class]]) {
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            CustomShowContentVC *webVC = (CustomShowContentVC *)vc;
            NSString *titleStr = [self.dataArray objectAtIndex:indexPath.row];
            NSString *urlStr = [self.urlArray objectAtIndex:indexPath.row];
            NSString *contentStr = [self.contentArray objectAtIndex:indexPath.row];
//            CustomShowContentVC *vc = [[CustomShowContentVC alloc] init];
            webVC.titleStr = titleStr;
            webVC.urlStr = urlStr;
            webVC.contentStr = contentStr;
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
