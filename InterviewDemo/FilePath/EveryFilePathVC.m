//
//  EveryFilePathVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/28.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  获取文件路径

/**
 *  iphone 的沙箱模型一般有四个文件夹：Documents、tmp、app、Library.
    手动保存的文件，存在Document里，NSUserdefaults保存的文件在Library/perference里
 *   1.Documents 目录：应将所有的应用程序数据文件写到这个目录下。这个目录用于存储用户数据及其他应该定期备份的信息。
 *  2.AppName.app目录：这是应用程序的程序包目录，包含应用程序的本身。由于应用程序必须经过签名，所以在运行时不能对其内容进行修改，否则可能会出现应用程序无法启动。
 *  3.Library目录：Caches 和 Preference两个
      1).Library/Preference目录：包含应用程序的偏好设置文件。不应该直接创建应用程序偏好设置文件，而是使用NSUserDefaults类来取得和设置应用程序的偏好。
      2).Library/Caches目录：用于存放应用程序专用的支持文件，保存应用程序再次启动过程需要的信息。
 */
#import "EveryFilePathVC.h"

@interface EveryFilePathVC ()

@end

@implementation EveryFilePathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文件路径及文件操作";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
