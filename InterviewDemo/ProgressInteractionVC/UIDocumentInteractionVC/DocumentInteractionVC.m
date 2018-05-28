//
//  DocumentInteractionVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/28.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  多个APP间的共享文档、文档预览、打印、发邮件、复制等功能

#define kPointX 30
#define kButtonHeight (44.0f)

#import "DocumentInteractionVC.h"
#import "CommonCustomButton.h"
#import "CommonWebVC.h"
#import <QuickLook/QuickLook.h>

@interface DocumentInteractionVC ()<UIDocumentInteractionControllerDelegate,QLPreviewControllerDelegate,QLPreviewControllerDataSource>
@property (nonatomic, strong)   UIButton    *documentBtn;
@property (nonatomic, strong)   UIButton    *quitLookBtn;
@property (nonatomic, strong)   UIButton    *quitLookForTxtBtn;
@property (nonatomic, strong)   UIDocumentInteractionController *documentInteractionController;
@property (nonatomic, strong)   QLPreviewController *previewForTxt;
@property (nonatomic, strong)   QLPreviewController *qlPreviewController;
@property (nonatomic, copy)     NSString    *filePath;
@end

@implementation DocumentInteractionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Document&&QuickLook";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UtilTools rightBarButtonItem];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self.view addSubview:self.documentBtn];
    [self.view addSubview:self.quitLookBtn];
    [self.view addSubview:self.quitLookForTxtBtn];
}
#pragma mark - 初始化控件
- (UIButton *)documentBtn{
    if (!_documentBtn) {
        _documentBtn = [CommonCustomButton customButton];
        _documentBtn.frame = CGRectMake(kPointX, kNavibarHeight + kPointX, kScreenWidth - kPointX * 2, kButtonHeight);
        [_documentBtn setTitle:@"DocumentInteraction" forState:UIControlStateNormal];
        [_documentBtn addTarget:self action:@selector(documentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _documentBtn;
}

- (UIButton *)quitLookBtn{
    if (!_quitLookBtn) {
        _quitLookBtn = [CommonCustomButton customButton];
        _quitLookBtn.frame = CGRectMake(kPointX, kNavibarHeight + kPointX + kPointX + kButtonHeight, kScreenWidth - kPointX * 2, kButtonHeight);
        [_quitLookBtn setTitle:@"QuickLookForPdf" forState:UIControlStateNormal];
        [_quitLookBtn addTarget:self action:@selector(quitLooktBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quitLookBtn;
}

- (UIButton *)quitLookForTxtBtn{
    if (!_quitLookForTxtBtn) {
        _quitLookForTxtBtn = [CommonCustomButton customButton];
        _quitLookForTxtBtn.frame = CGRectMake(kPointX, kNavibarHeight + kPointX + kPointX * 2 + kButtonHeight * 2, kScreenWidth - kPointX * 2, kButtonHeight);
        [_quitLookForTxtBtn setTitle:@"QuickLookForTxt" forState:UIControlStateNormal];
        [_quitLookForTxtBtn addTarget:self action:@selector(quitLookForTxtBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quitLookForTxtBtn;
}

#pragma mark - 点击事件
- (void)btnClick{
    NSLog(@"参考文献");
    CommonWebVC *webVC = [[CommonWebVC alloc] init];
    webVC.titleStr = @"Quit Look && DocumentInteraction";
    webVC.urlStr = @"https://blog.csdn.net/lovechris00/article/details/71083047";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)documentBtnClick{
    NSLog(@"33333");
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"testDocument" withExtension:@"pdf"];
    if (url) {
        // 初始化UIDocumentInteractionVC
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:url];
        
        // 设置delegate
        [self.documentInteractionController setDelegate:self];
        // 显示窗口预览PDF
        [self.documentInteractionController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
    }
}

- (void)quitLooktBtnClick{
    NSLog(@"QuickLook");
    
    
    
    self.filePath = [[NSBundle mainBundle] pathForResource:@"testDocument" ofType:@"pdf"];
    self.qlPreviewController = [[QLPreviewController alloc] init];
    self.qlPreviewController.dataSource = self;
    self.qlPreviewController.delegate = self;
    self.qlPreviewController.view.frame = CGRectMake(0, kNavibarHeight, kScreenWidth, kScreenHeight - kNavibarHeight);
    [self.view addSubview:self.qlPreviewController.view];
    
}

- (void)quitLookForTxtBtnClick{
    NSLog(@"QuickLook");
    self.filePath = [[NSBundle mainBundle] pathForResource:@"PrintTest" ofType:@"txt"];
    self.previewForTxt = [[QLPreviewController alloc] init];
    self.previewForTxt.dataSource = self;
    self.previewForTxt.delegate = self;
    self.previewForTxt.view.frame = CGRectMake(0, kNavibarHeight, kScreenWidth, kScreenHeight - kNavibarHeight);
    [self.view addSubview:self.previewForTxt.view];
}




#pragma mark - QLPreviewControllerDelegate && QLQLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}


- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    if ([self.filePath hasSuffix:@"txt"] || [self.filePath hasSuffix:@"TXT"]) {
        // window下单txt在这里会显示乱码，所以应该处理一下
        NSData *fileData = [NSData dataWithContentsOfFile:self.filePath];
        // 判断是UNICODE编码,还是ANSI编码（-2147483623，-2147482591，-2147482062，-2147481296）encoding 任选一个就可以了
        NSString *isUNICODE = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
        NSString *isANSI = [[NSString alloc] initWithData:fileData encoding:-2147483623];
        if (isUNICODE) {
        } else {
            NSData *data = [isANSI dataUsingEncoding:NSUTF8StringEncoding];
            [data writeToFile:self.filePath atomically:YES];
        }
        return [NSURL fileURLWithPath:self.filePath];
    }
    return [NSURL fileURLWithPath:self.filePath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
