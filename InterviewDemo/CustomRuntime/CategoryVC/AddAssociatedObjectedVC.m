//
//  AddAssociatedObjectedVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/18.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  给分类动态添加属性

#import "AddAssociatedObjectedVC.h"
#import "NSObject+AssociatedObject.h"
#import "Message.h"

@interface AddAssociatedObjectedVC ()
@property (nonatomic, strong)   Message *message;
@end

@implementation AddAssociatedObjectedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类动态添加属性";
    self.view.backgroundColor = [UIColor whiteColor];
    self.message = [[Message alloc] init];
    [self.message sendMessage:@"bzy"];
    self.message.associatedObject = @"003";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
