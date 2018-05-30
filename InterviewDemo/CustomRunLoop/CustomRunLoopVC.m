//
//  CustomRunLoopVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/21.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#define kPointX 30
#import "CustomRunLoopVC.h"
#import "CommonWebVC.h"

@interface CustomRunLoopVC ()
@property (nonatomic, strong)   UILabel *contentLabel;
@end

@implementation CustomRunLoopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RunLoop";
    self.view.backgroundColor = kBlueColor;
   
    [self customRightButtonItem];
    [self.view addSubview:self.contentLabel];
}

#pragma mark - 导航栏右侧按钮
- (void)customRightButtonItem{
     UIButton *rightBtn = [UtilTools rightBarButtonItem];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)rightBtnClick{
    CommonWebVC *vc = [[CommonWebVC alloc] init];
    vc.titleStr = @"RunLoop";
    vc.urlStr = @"https://www.jianshu.com/p/296f182c8faa";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 初始化控件
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UtilTools commonLabel];
        _contentLabel.frame = CGRectMake(kPointX, kPointX + kNavibarHeight, kScreenWidth - kPointX * 2, kScreenHeight - kNavibarHeight - kPointX * 2);
        _contentLabel.text = @"经典案例：tableView图片延迟加载，[performSelector: afterDelay: inModes:@[NSDefaultRunLoopMode]]";
    }
    return _contentLabel;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
