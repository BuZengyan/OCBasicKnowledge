//
//  ActivityVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/30.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  UIActivityViewController

#define kPointX 30
#define kTopLabelHeight 60

#import "ActivityVC.h"
#import "CommonWebVC.h"

@interface ActivityVC ()
@property (nonatomic, strong)   UILabel *topLabel;
@property (nonatomic, strong)   UIButton *pushButton;
@end

@implementation ActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"ActivityViewController";
    
    UIButton *rightBtn = [UtilTools rightBarButtonItem];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    [self.view addSubview:self.topLabel];
    [self.view addSubview:self.pushButton];
    
}

- (void)rightBtnClick{
    CommonWebVC *webVC = [[CommonWebVC alloc] init];
    webVC.titleStr = @"iOS自带SDK进程通信";
    webVC.urlStr = @"https://blog.csdn.net/goods_boy/article/details/71189821";
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark - 初始化控件

- (UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.frame = CGRectMake(kPointX, kPointX + kNavibarHeight, kScreenWidth - kPointX * 2 ,kTopLabelHeight);
        _topLabel.font = [UIFont boldSystemFontOfSize:12];
        _topLabel.numberOfLines = 0;
        _topLabel.textColor = [UIColor whiteColor];
        _topLabel.text = @"UIActivityViewController是iOS SDK封装好的类在APP之间进行数据传递、分享、操作";
    }
    return _topLabel;
}

- (UIButton *)pushButton{
    if (!_pushButton) {
        _pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _pushButton.frame = CGRectMake(kPointX, kPointX + kNavibarHeight + kTopLabelHeight + kPointX, kScreenWidth - kPointX * 2, 36);
        [_pushButton setBackgroundColor:[UIColor orangeColor]];
        _pushButton.layer.masksToBounds = YES;
        _pushButton.layer.cornerRadius = 36/2;
        [_pushButton setTitle:@"ActivityVCForShare" forState:UIControlStateNormal];
        [_pushButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_pushButton addTarget:self action:@selector(pushButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pushButton;
}


#pragma mark - 点击事件
- (void)pushButtonClick{
    [self showShareView];
}


- (void)showShareView{
    // 分享的标题
    NSString *shareTitle = @"暴走大事件";
    // 分享的图片
    UIImage *shareImage = [UIImage imageNamed:@"0003.jpg"];
    // 分享的URL
    NSURL *shareUrl = [NSURL URLWithString:@"https://www.baidu.com"];
    // 构造分享数组
    NSArray *shareArray = @[shareTitle,shareImage,shareUrl];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:shareArray applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint,UIActivityTypeAirDrop,UIActivityTypeCopyToPasteboard,UIActivityTypeSaveToCameraRoll,UIActivityTypeAssignToContact];
    [self.navigationController presentViewController:activityVC animated:YES completion:nil];
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            // 完成分享
        }else{
            // 取消
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
