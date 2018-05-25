//
//  MessageSendAndForwardingVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/18.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  消息发送及转发

#import "MessageSendAndForwardingVC.h"
#import "Message.h"
@interface MessageSendAndForwardingVC ()
@property (nonatomic, strong)   Message *message;
@end

@implementation MessageSendAndForwardingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息发送及转发";
    self.view.backgroundColor = [UIColor whiteColor];
    self.message = [[Message alloc] init];
    [self.message sendMessage:@"bzy"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
