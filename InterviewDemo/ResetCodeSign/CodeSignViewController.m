//
//  CodeSignViewController.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/6/1.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  逆向签名

#define kPointX 30


#import "CodeSignViewController.h"
#import "CommonWebVC.h"

@interface CodeSignViewController ()
@property (nonatomic, strong)   UILabel *label;
@end

@implementation CodeSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"逆向签名";
    self.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.label];
    
    UIButton *rightBtn = [UtilTools rightBarButtonItem];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)rightBtnClick{
    CommonWebVC *webVC = [[CommonWebVC alloc] init];
    webVC.urlStr = @"https://www.jianshu.com/p/15edfe11f8ac";
    webVC.titleStr = @"ipa重新签名";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (UILabel *)label{
    if (!_label) {
        _label = [UtilTools commonLabel];
        NSString *str = @"ipa逆向签名\n用途：用企业账号重新签名公司账号的IPA包，可以避免添加设备就可以在自己的平台上发给测试。\n\n步骤：\n1.解压IPA包。\n\n2.删除原包签名：\nrm -rf Payload/appName.app/_CodeSignature\n\n3.更换描述文件：\ncp newEmbedded.mobileprovision Payload/appName.app/embedded.mobileprovision\n\n4.重新签名：\ncodesgin -f -s + \"iPhone Distribution：证书名称\" + appName.app路径。\n\n5.重新打包，生成新的IPA：\nzip -r New_appName.ipa Payload。";
        _label.frame = CGRectMake(kPointX, kPointX + kNavibarHeight, kScreenWidth - kPointX * 2, kScreenHeight - (kPointX + kNavibarHeight) * 2);
        _label.text = str;
    }
    return _label;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
