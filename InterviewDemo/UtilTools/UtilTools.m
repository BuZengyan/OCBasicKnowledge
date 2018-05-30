//
//  UtilTools.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/25.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  公共方法类


#import "UtilTools.h"
#import "KeyChainTools.h"

@implementation UtilTools

+ (void)showLoading{
    [SVProgressHUD showLoading];
}

+ (void)hiddenSvp{
    [SVProgressHUD hiddenLoading];
}


+ (UIButton *)rightBarButtonItem{
    UIButton *rightItemView = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItemView.frame = CGRectMake(0, 0, 80, 44);
    [rightItemView setTitle:@"参考文献" forState:UIControlStateNormal];
    [rightItemView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    rightItemView.titleLabel.font = [UIFont systemFontOfSize:16];
    return rightItemView;
}

+ (UILabel *)commonLabel{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.numberOfLines = 0;
    label.textColor = kWhiteColor;
    return label;
}

+ (UIButton *)commonButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = kCommonButtonHeight / 2;
    [button setBackgroundColor:[UIColor orangeColor]];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
    return button;
}

@end
