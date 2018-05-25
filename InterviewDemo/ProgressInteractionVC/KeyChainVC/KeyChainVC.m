//
//  KeyChainVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/24.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  keyChain用法

#define kPointX (20.0f)
#define kBtnWidth (kScreenWidth - kPointX * 5)/4
#define kBtnHeight (30)
#define kTempTag 1000
#define kLabelWidth (100.0f)
//#define KEY_USERNAME_PASSWORD @"8UXF6NUE7S.com.baozun.ZyShare"

#import "KeyChainVC.h"
#import "CustomShowContentVC.h"
#import <Security/Security.h>

static  NSString * const KEY_PASSWORD = @"KEY_PASSWORD";
static  NSString * const KEY_NAME = @"KEY_NAME";
static  NSString * const KEY_USERNAME_PASSWORD = @"8UXF6NUE7S.com.baozun.ZyShare";

@interface KeyChainVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)   UIButton    *saveBtn;   /// 存
@property (nonatomic, strong)   UIButton    *takeBtn;   /// 取
@property (nonatomic, strong)   UIButton    *deleteBtn; /// 删
@property (nonatomic, strong)   UIButton    *changeBtn; /// 改
@property (nonatomic, strong)   UITextField *nameTextFeild; ///
@property (nonatomic, strong)   UITextField *passWordFeild; ///
@property (nonatomic, strong)   UILabel     *nameLabel;
@property (nonatomic, strong)   UILabel     *passWordLabel;

@property (nonatomic, strong)   UILabel     *takeLabel; /// 显示取出的值

@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, copy)     NSString    *password;

@property (nonatomic, strong)   UITableView *mainTableView;
@property (nonatomic, strong)   UILabel     *errorLabel;

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
    [self.view addSubview:self.saveBtn];
    [self.view addSubview:self.changeBtn];
    [self.view addSubview:self.takeBtn];
    [self.view addSubview:self.errorLabel];
    [self.view addSubview:self.nameLabel];
    [self.view addSubview:self.nameTextFeild];
    [self.view addSubview:self.passWordLabel];
    [self.view addSubview:self.passWordFeild];
    [self.view addSubview:self.takeLabel];
    [self.view addSubview:self.deleteBtn];
    [self.view addSubview:self.mainTableView];
    // 首先查询一次
    [self getKeyChain];
    
}

#pragma mark - 初始化控件
- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.frame = CGRectMake(kPointX,kNavibarHeight + kPointX, kBtnWidth, kBtnHeight);
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.layer.cornerRadius = kBtnHeight / 2;
        _saveBtn.layer.borderWidth = 1;
        _saveBtn.layer.borderColor = [UIColor blueColor].CGColor;
        [_saveBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _saveBtn.tag = kTempTag + 0;
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_saveBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setTitle:@"存" forState:UIControlStateNormal];
    }
    return _saveBtn;
}

- (UIButton *)changeBtn{
    if (!_changeBtn) {
        _changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _changeBtn.frame = CGRectMake(kPointX + kBtnWidth + kPointX * 2 ,kNavibarHeight + kPointX, kBtnWidth, kBtnHeight);
        _changeBtn.layer.masksToBounds = YES;
        _changeBtn.layer.cornerRadius = kBtnHeight / 2;
        _changeBtn.layer.borderWidth = 1;
        _changeBtn.layer.borderColor = [UIColor purpleColor].CGColor;
        [_changeBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        _changeBtn.tag = kTempTag + 3;
        _changeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_changeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_changeBtn setTitle:@"改" forState:UIControlStateNormal];
    }
    return _changeBtn;
}
- (UILabel *)errorLabel{
    if (!_errorLabel) {
        _errorLabel = [[UILabel alloc] init];
        _errorLabel.frame = CGRectMake(kPointX * 4 + kBtnWidth * 2, kNavibarHeight + kPointX , kScreenWidth - kPointX * 5 - kBtnWidth * 2, kBtnHeight);
        _errorLabel.text = @"";
        _errorLabel.textColor = [UIColor redColor];
        _errorLabel.font = [UIFont systemFontOfSize:12];
        _errorLabel.hidden = NO;
        _errorLabel.numberOfLines = 0;
    }
    return _errorLabel;
}

- (UIButton *)takeBtn{
    if (!_takeBtn) {
        _takeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _takeBtn.frame = CGRectMake(kPointX,kNavibarHeight + kPointX + kPointX * 4 + kBtnHeight * 3, kBtnWidth, kBtnHeight);
        _takeBtn.layer.masksToBounds = YES;
        _takeBtn.layer.cornerRadius = kBtnHeight / 2;
        _takeBtn.layer.borderWidth = 1;
        _takeBtn.layer.borderColor = [UIColor blueColor].CGColor;
        [_takeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _takeBtn.tag = kTempTag + 2;
        _takeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_takeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_takeBtn setTitle:@"取" forState:UIControlStateNormal];
    }
    return _takeBtn;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.frame = CGRectMake(kPointX, kNavibarHeight + kPointX * 2 + kBtnHeight, kLabelWidth, kBtnHeight);
        _nameLabel.text = @"name：";
        _nameLabel.textColor = [UIColor blueColor];
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}

- (UITextField *)nameTextFeild{
    if (!_nameTextFeild) {
        _nameTextFeild = [[UITextField alloc] init];
        _nameTextFeild.frame = CGRectMake(self.nameLabel.frame.origin.x + kLabelWidth, self.nameLabel.frame.origin.y, kScreenWidth - kPointX * 2 - kLabelWidth, kBtnHeight);
        _nameTextFeild.layer.masksToBounds = YES;
        _nameTextFeild.layer.cornerRadius = 8;
        _nameTextFeild.layer.borderColor = [UIColor blueColor].CGColor;
        _nameTextFeild.layer.borderWidth = 1;
        _nameTextFeild.delegate = self;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, kBtnHeight)];
        _nameTextFeild.leftView = leftView;
        _nameTextFeild.leftViewMode = UITextFieldViewModeAlways;
        _nameTextFeild.tag = 101;
    }
    return _nameTextFeild;
}

- (UILabel *)passWordLabel{
    if (!_passWordLabel) {
        _passWordLabel = [[UILabel alloc] init];
        _passWordLabel.frame = CGRectMake(kPointX, kNavibarHeight + kPointX * 2 + kBtnHeight + kPointX + kBtnHeight, kLabelWidth, kBtnHeight);
        _passWordLabel.text = @"password：";
        _passWordLabel.textColor = [UIColor blueColor];
        _passWordLabel.font = [UIFont systemFontOfSize:16];
    }
    return _passWordLabel;
}

- (UITextField *)passWordFeild{
    if (!_passWordFeild) {
        _passWordFeild = [[UITextField alloc] init];
        _passWordFeild.frame = CGRectMake(self.nameLabel.frame.origin.x + kLabelWidth, self.passWordLabel.frame.origin.y, kScreenWidth - kPointX * 2 - kLabelWidth, kBtnHeight);
        _passWordFeild.layer.masksToBounds = YES;
        _passWordFeild.layer.cornerRadius = 8;
        _passWordFeild.layer.borderColor = [UIColor blueColor].CGColor;
        _passWordFeild.layer.borderWidth = 1;
        _passWordFeild.delegate = self;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, kBtnHeight)];
        _passWordFeild.leftView = leftView;
        _passWordFeild.leftViewMode = UITextFieldViewModeAlways;
        _passWordFeild.tag = 102;
        
        
    }
    return _passWordFeild;
}


- (UILabel *)takeLabel{
    if (!_takeLabel) {
        _takeLabel = [[UILabel alloc] init];
        _takeLabel.frame = CGRectMake(kPointX, self.takeBtn.frame.origin.y + kBtnHeight + kPointX, kScreenWidth - kPointX * 2, kBtnHeight);
        _takeLabel.text = @"";
        _takeLabel.textColor = [UIColor orangeColor];
        _takeLabel.font = [UIFont systemFontOfSize:16];
    }
    return _takeLabel;
}



- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(kPointX,kNavibarHeight + kPointX + kPointX * 5 + kBtnHeight * 4 + kBtnHeight + kPointX, kBtnWidth, kBtnHeight);
        _deleteBtn.layer.masksToBounds = YES;
        _deleteBtn.layer.cornerRadius = kBtnHeight / 2;
        _deleteBtn.layer.borderWidth = 1;
        _deleteBtn.layer.borderColor = [UIColor redColor].CGColor;
        [_deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _deleteBtn.tag = kTempTag + 1;
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_deleteBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBtn setTitle:@"删" forState:UIControlStateNormal];
    }
    return _deleteBtn;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(kPointX, self.deleteBtn.frame.origin.y + kBtnHeight + kPointX, kScreenWidth - kPointX * 2, kScreenHeight - kNavibarHeight - self.deleteBtn.frame.origin.y - kBtnHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
    }
    return _mainTableView;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"cellStr";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    NSMutableDictionary *dic = [KeyChainTools readForKey:KEY_USERNAME_PASSWORD];
    NSLog(@"password = %@ name = %@",[dic objectForKey:KEY_PASSWORD],[dic objectForKey:KEY_NAME]);
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = [NSString stringWithFormat:@"name = %@ \npassword = %@",[dic objectForKey:KEY_NAME],[dic objectForKey:KEY_PASSWORD]];
    return cell;
}
#pragma mark - UITextFeildDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 101) {
        self.name = textField.text;
    }else{
        self.password = textField.text;
    }
}

#pragma mark - 点击事件
- (void)btnClick:(UIButton *)btn{
    [self.view endEditing:YES];

    if (btn.tag == kTempTag + 0) {
        // 存
        if (![self NameOrPasswordIsNull]) {
            return;
        }
        [self addKeyChain];
    }else if (btn.tag == kTempTag + 1){
        // 删
        [self deleteKeyChain];
    }else if (btn.tag == kTempTag + 2){
        // 取
        [self takeKeyChain];
    }else if (btn.tag == kTempTag + 3){
        // 改
        if (![self NameOrPasswordIsNull]) {
            return;
        }
        [self changeKeyChain];
    }
}


#pragma mark - 存、取、删、改

// 存
- (void)addKeyChain{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.password forKey:KEY_PASSWORD];
    [dic setObject:self.name forKey:KEY_NAME];
    [KeyChainTools addKeyChainData:dic forKey:KEY_USERNAME_PASSWORD];
    [self.mainTableView reloadData];
    
    NSMutableDictionary *tempDic = [KeyChainTools readForKey:KEY_USERNAME_PASSWORD];
    NSString *statusStr = nil;
    BOOL success = NO;
    if (tempDic == nil) {
        statusStr = @"error:存值为空！";
        success = NO;
    }else{
        statusStr = @"success:存值成功！";
        success = YES;
    }
    [self changeErrorLabelStyle:statusStr success:success];
    
}

// 取
- (void)takeKeyChain{
    NSMutableDictionary *dic = [KeyChainTools readForKey:KEY_USERNAME_PASSWORD];
    self.takeLabel.text = [NSString stringWithFormat:@"password = %@  name = %@",[dic objectForKey:KEY_PASSWORD],[dic objectForKey:KEY_NAME]];
    
    NSMutableDictionary *tempDic = [KeyChainTools readForKey:KEY_USERNAME_PASSWORD];
    NSString *statusStr = nil;
    BOOL success = NO;
    if (tempDic == nil) {
        statusStr = @"error:无原始值！";
        success = NO;
    }else{
        statusStr = @"success:取值成功!";
        success = YES;
    }
    [self changeErrorLabelStyle:statusStr success:success];
}

// 删
- (void)deleteKeyChain{
    [KeyChainTools deleteWithService:KEY_USERNAME_PASSWORD];
    [self getKeyChain];
    
    NSMutableDictionary *tempDic = [KeyChainTools readForKey:KEY_USERNAME_PASSWORD];
    NSString *statusStr = nil;
    BOOL success = NO;
    if (tempDic != nil) {
        statusStr = @"error:删除失败！";
        success = NO;
    }else{
        statusStr = @"success:删除成功！";
        success = YES;
    }
    [self changeErrorLabelStyle:statusStr success:success];
}

// 改
- (void)changeKeyChain{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.password forKey:KEY_PASSWORD];
    [dic setObject:self.name forKey:KEY_NAME];
    [KeyChainTools updateKeyChainData:dic forKey:KEY_USERNAME_PASSWORD];
    [self getKeyChain];
    NSMutableDictionary *tempDic = [KeyChainTools readForKey:KEY_USERNAME_PASSWORD];
    
    NSString *statusStr = nil;
    BOOL success = NO;
    if (tempDic == nil) {
        statusStr = @"error:无原始值更改失败";
        success = NO;
    }else{
        statusStr = @"success:更改成功！";
        success = YES;
    }
    [self changeErrorLabelStyle:statusStr success:success];
}

#pragma mark - 公用查询
- (void)getKeyChain{
    NSMutableDictionary *dic = [KeyChainTools readForKey:KEY_USERNAME_PASSWORD];
    NSLog(@"password = %@ name = %@",[dic objectForKey:KEY_PASSWORD],[dic objectForKey:KEY_NAME]);
    [self.mainTableView reloadData];
}

- (BOOL)NameOrPasswordIsNull{
    if ((self.password == nil || [self.password isEqualToString:@""]) || (self.name == nil || [self.name isEqualToString:@""])) {
        self.errorLabel.textColor = [UIColor redColor];
        self.errorLabel.text = @"error:name,password为空！";
        return NO;
    }
    return YES;
}

- (void)changeErrorLabelStyle:(NSString *)str success:(BOOL)success{
    if (success) {
        self.errorLabel.textColor = [UIColor greenColor];
    }else{
        self.errorLabel.textColor = [UIColor redColor];
    }
    self.errorLabel.text = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
