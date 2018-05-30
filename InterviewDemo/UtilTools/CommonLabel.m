//
//  CommonLabel.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/22.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import "CommonLabel.h"

@implementation CommonLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont boldSystemFontOfSize:14];
        self.textColor = [UIColor whiteColor];
        self.numberOfLines = 0;
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btn];
    }
    return self;
}

- (void)btnClick{
    if (self.pushToWebBlock) {
        self.pushToWebBlock();
    }
}

@end
