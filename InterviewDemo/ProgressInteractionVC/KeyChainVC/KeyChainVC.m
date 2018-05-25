//
//  KeyChainVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/24.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  keyChain用法

#define kPointX (20.0f)
#define kBtnWidth (kScreenWidth - kPointX * 5)/4
#define kBtnHeight (44)
#define kTempTag 1000

#import "KeyChainVC.h"
#import "CustomShowContentVC.h"
#import <Security/Security.h>

@interface KeyChainVC ()
@property (nonatomic, strong)   NSMutableArray  *btnTitleArray;
@end

@implementation KeyChainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"KeyChain用法";
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     *  特点：
        1.更安全，对比NSUserDefault存储数据，更加安全。
        2.KeyChain独立于其他APP的沙盒之外，即使删除APP，它存储的信息仍然存在，再次安装APP，还可以使用KeyChain里面的数据
        3.相同的Team ID 开发，可以共享数据。
     */
    NSString *serviceName = @"zhangsan";
    NSString *account = @"009";
    
    
    
    for (NSInteger i = 0; i < self.btnTitleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((kPointX + kBtnWidth)*i + kPointX,kNavibarHeight + kPointX, kBtnWidth, kBtnHeight);
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 6;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor blueColor].CGColor;
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.tag = kTempTag + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString *title = [self.btnTitleArray objectAtIndex:i];
        [btn setTitle:title forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
    
}

- (NSMutableArray *)btnTitleArray{
    if (!_btnTitleArray) {
        _btnTitleArray = [[NSMutableArray alloc] init];
        [_btnTitleArray addObject:@"增"];
        [_btnTitleArray addObject:@"删"];
        [_btnTitleArray addObject:@"查"];
        [_btnTitleArray addObject:@"改"];
    }
    return _btnTitleArray;
}

#pragma mark - 点击事件
- (void)btnClick:(UIButton *)btn{
    if (btn.tag == kTempTag + 0) {
        // 增
//        [self addItemWithService:@"com.tencent" account:@"wanger" password:@"003"];
//        [self addItemWithService:@"com.baidu" account:@"zhangsan" password:@"001"];
        [self addItemWithService:@"com.baid\\" account:@"lisi" password:@"002"];
    }else if (btn.tag == kTempTag + 1){
        // 删
    }else if (btn.tag == kTempTag + 2){
        // 查
    }else if (btn.tag == kTempTag + 3){
        // 改
    }
}

// 增、改
- (BOOL)addItemWithService:(NSString *)service
                   account:(NSString *)account
                  password:(NSString *)password{
    // 首先查询是否存在
    NSMutableDictionary *queryDic = [NSMutableDictionary dictionary];
    [queryDic setObject:service forKey:(__bridge id)kSecAttrService];   // service
    [queryDic setObject:account forKey:(__bridge id)kSecAttrAccount];   // account
    [queryDic setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];   // 标明存储的是一个密码
    OSStatus status = -1;
    CFTypeRef result = NULL;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)queryDic, &result);
    if (status == errSecItemNotFound) {
        // 没有找到则添加
        // 把password转化为data
        NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
        // 添加密码
        [queryDic setObject:passwordData forKey:(__bridge id)kSecValueData];
        // 关键的添加API
        status = SecItemAdd((__bridge CFDictionaryRef)queryDic, NULL);
    }else if (status == errSecSuccess){
        // 找到就更新
        NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:queryDic];
        // 添加密码
        [dict setObject:passwordData forKey:(__bridge id)kSecValueData];
        // 更新密码吗
        status = SecItemUpdate((__bridge CFDictionaryRef)queryDic, (__bridge CFDictionaryRef)dict);
    }
    
    return (status == errSecSuccess);
}

// 查：调用原生API，实现查询密码
- (NSString *)passwordForService:(nonnull  NSString *)service account:(nonnull NSString *)account{
    // 生成一个查询用的可变字典
    NSMutableDictionary *queryDic = [NSMutableDictionary dictionary];
    // 首先添加获取密码所需的搜索键和雷属性
    // 标明为一般密码可能是证书或其他东西
    [queryDic setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
