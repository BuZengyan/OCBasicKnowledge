//
//  PerformSelectorVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/21.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  performSelector与直接调用的区别

#define kPointX (60.0f)
#define kDistanceY (10)
#define kButtonHeight (30)
#define kButtonWidth (kScreenWidth - kPointX * 2)
#define kTempBtnTag 1000

#import "PerformSelectorVC.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "CommonWebVC.h"

@interface PerformSelectorVC ()
@property (nonatomic, strong)   UILabel *textLabel;
@property (nonatomic, strong)   NSMutableArray *btnNameArray;
@end

@implementation PerformSelectorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"PerformSelectorDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 直接调用：编译时会校验，如果方法不存在会直接报错
    [self testMethod];
    
    // performSelector:编译时不会报错，运行时才会校验，如果方法不存在直接崩溃，
    [self performSelector:@selector(testMethod) withObject:nil];
    
    [self usePerformSelector];
    
    [self addBtn];
    [self.view addSubview:self.textLabel];
}

#pragma mark - 设置按钮
- (NSMutableArray *)btnNameArray{
    if (!_btnNameArray) {
        _btnNameArray = [[NSMutableArray alloc] init];
        [_btnNameArray addObject:@"selectorNoParameter"];
        [_btnNameArray addObject:@"selectorOneParameter"];
        [_btnNameArray addObject:@"selectorTwoParameter"];
        [_btnNameArray addObject:@"动态调用"];
        [_btnNameArray addObject:@"onMainThread"];
        [_btnNameArray addObject:@"三个及以上参数：NSInvocation"];
        [_btnNameArray addObject:@"三个及以上参数：封装为一个参数"];
        [_btnNameArray addObject:@"三个及以上参数：objc_msgSend"];
        [_btnNameArray addObject:@"延迟调用：afterDelay"];
        [_btnNameArray addObject:@"延迟调用：Dispatch_after"];
        [_btnNameArray addObject:@"延迟调用：Dispatch_async"];
        [_btnNameArray addObject:@"实例应用：防止多次点击"];
        [_btnNameArray addObject:@"实例应用：tableView延时加载图片"];
        [_btnNameArray addObject:@"参考文献"];
    }
    return _btnNameArray;
}

- (void)addBtn{
    for (NSInteger i = 0; i < self.btnNameArray.count; i++) {
        NSString *title = [self.btnNameArray objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kPointX, kNavibarHeight + kDistanceY + (kDistanceY + kButtonHeight) * i, kButtonWidth, kButtonHeight);
        [btn setTitle:title forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = kButtonHeight / 2;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        btn.backgroundColor = [UIColor orangeColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.tag = i + kTempBtnTag;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        if (i == self.btnNameArray.count - 1) {
            //
            [btn setBackgroundColor:[UIColor redColor]];
              [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }
    }
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.frame = CGRectMake(kPointX, kScreenHeight - kButtonHeight * 4, kScreenWidth - kPointX * 2, kButtonHeight * 4);
        _textLabel.font = [UIFont boldSystemFontOfSize:13];
        _textLabel.textColor = [UIColor blueColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}
- (void)testMethod{
    NSLog(@"调用了testMethod");
}

#pragma mark - performSelector的使用
- (void)usePerformSelector{
    // 方法没有实现，会崩溃
    
    // 1.无参数传递:
    [self performSelector:@selector(selectorNoParameter)];
    
    // 2.传递一个参数
    [self performSelector:@selector(selectorOneParameter:) withObject:@"firstParameter"];
    
    // 3.传递两个参数
    [self performSelector:@selector(selectorFirstParameter:secondParameter:) withObject:@"firstParameter" withObject:@"secondParameter"];
}

// 1.无参数传递
- (void)selectorNoParameter{
    NSLog(@"无参数传递");
}

// 2.传递一个参数
- (void)selectorOneParameter:(NSString *)first{
    NSLog(@"传递一个参数Logs:%@",first);
}

// 3.传递两个参数
- (void)selectorFirstParameter:(NSString *)first secondParameter:(NSString *)second{
    NSLog(@"第一个参数：%@，第二个参数%@",first,second);
}

// 4.动态建立函数，然后调用他们
- (void)testDynamicMethodForPerformSelector{
    NSMutableArray *methodArray = [[NSMutableArray alloc] init];
    NSDictionary *dict1 = @{@"MethodName":@"DynamicParameterString:",@"value":@"1"};
    NSDictionary *dict2 = @{@"MethodName":@"DynamicParameterNumber:",@"value":@"2"};
    [methodArray addObject:dict1];
    [methodArray addObject:dict2];
    
    for (NSDictionary *dic in methodArray) {
        [self performSelector:NSSelectorFromString([dic objectForKey:@"MethodName"]) withObject:[dic objectForKey:@"value"]];
    }
}

- (void)DynamicParameterString:(NSString *)value{
    NSLog(@"动态调用：value = %@",value);
}

- (void)DynamicParameterNumber:(NSString *)number{
    NSLog(@"动态调用：number = %@",number);
}

// 5.在主线程执行代码
- (void)executeOnMainThread:(NSString *)tempParam{
    NSLog(@"在主线程执行代码：tempParam = %@",tempParam);
}

#pragma mark - performSelector传递三个以上的参数
// 1.NSInvocation
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects{
    // 方法签名
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:selector];
    if (signature == nil) {
        return nil;
    }
    
    // NSInvocation：利用NSInvocationc创建一个对像，包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    
    // 设置具体参数
    NSInteger paramsCount = signature.numberOfArguments - 2;    // 出去self，_cmd 以外的参数
    paramsCount = MIN(paramsCount, objects.count);
    for (NSInteger i = 0; i < paramsCount; i++) {
        id object = [objects objectAtIndex:i];
        if ([object isKindOfClass:[NSNull class]]) {
            continue;
        }
        [invocation setArgument:&object atIndex:i + 2];
    }
    
    // 调用方法
    [invocation invoke];
    // 获取放回值
    id returnValue = nil;
    if (signature.methodReturnLength) {
        // 如果有返回值采取获取返回值
        [invocation getReturnValue:&returnValue];
        return returnValue;
    }

    return nil;
}

- (void)sendTwoMoreParameters{
    NSString *str = @"字符串";
    NSNumber *num = @20;
    NSArray *arr = @[@"数组值1",@"数组值2"];
    SEL sel = NSSelectorFromString(@"NSInvocationWithString:Num:Array:");
    NSArray *objects = [NSArray arrayWithObjects:str,num,arr, nil];
    [self performSelector:sel withObjects:objects];
}

// 实现方法
- (void)NSInvocationWithString:(NSString *)string Num:(NSNumber *)num Array:(NSArray *)arr{
    NSLog(@"%@, %@, %@",string,num,arr[0]);
}


// 2.把多个参数封装成一个参数如NSDictionary
- (void)sendTwoMoreParamsWithDictionary{
    NSDictionary *dict = @{@"value1":@"1",@"value2":@"2",@"value3":@"3",@"value4":@"4"};
    [self performSelector:@selector(selectorTwoMoreParmas:) withObject:dict];
    
}

- (void)selectorTwoMoreParmas:(NSDictionary *)dic{
    NSLog(@"dic = %@",[dic objectForKey:@"value3"]);
}


// 3.利用objc_msgSend(id,SEL,param1,param2,param3,...);
- (void)selectorTwoMoreParamsWithObjc_msgSend{
    NSString *str = @"objc_msgSend";
    NSNumber *num = @20;
    NSArray *arr = @[@"数组值1",@"数组值2"];
    SEL sel = NSSelectorFromString(@"ObjcMsgSendWithString:Num:Array:");
    // 调用objc_msgSend(id, SEL, parma1, param2, param3)方法
    ((void (*) (id, SEL, NSString *, NSNumber *, NSArray *)) objc_msgSend) (self, sel, str, num, arr);

}

// 实现方法
- (void)ObjcMsgSendWithString:(NSString *)str Num:(NSNumber *)num Array:(NSArray *)arr{
    NSLog(@"str = %@, num = %@, arr[1] = %@",str,num,arr[0]);
}

#pragma mark - 被延时调用
// 1.afterDelay方法
- (void)selectorAfterDelay{
    NSLog(@"直接使用AfterDelay延时调用");
}

// 2.dispatch_after在子线程上执行
- (void)selectorDelayWithDispatch_after{
    NSLog(@"借住Dispatch_after延时调用");
}

// 3.dispatch_async 创建子线程执行
- (void)selectorDelayWithDispatch_aysnc{
    NSLog(@"借住Dispatch_aysnc延时调用");
}

#pragma mark - 实例应用：防止按钮被多次点击
- (void)changeBtnStyle:(id)sender{
    UIButton *btn = (UIButton *)sender;
    btn.enabled = YES;
    btn.backgroundColor = [UIColor orangeColor];
}

#pragma mark - 实例应用：优化tableView延时加载图片
- (void)afterDelayLoadImage:(UIImage *)downLoadImage{
    NSLog(@"downLoadImage = @",downLoadImage);
    
}


#pragma mark - 点击事件
- (void)btnClick:(UIButton *)btn{
    NSInteger btnTag = btn.tag - kTempBtnTag;
    NSString *labelText = nil;
    if (btnTag == 0) {
        // 无参数
        labelText = @"无参数传递";
        [self performSelector:@selector(selectorNoParameter)];
    }else if (btnTag == 1){
        // 一个参数
        labelText = @"一个参数:firstParameter";
         [self performSelector:@selector(selectorOneParameter:) withObject:@"firstParameter"];
    }else if (btnTag == 2){
        // 两个参数
        labelText = @"两个参数:twoParameters";
        [self performSelector:@selector(selectorFirstParameter:secondParameter:) withObject:@"firstParameter" withObject:@"secondParameter"];
    }else if (btnTag == 3){
        // 动态调用
        [self testDynamicMethodForPerformSelector];
        labelText = @"动态调用：创建数组，数组里为字典，字典包含方法名、object两对键值对，当然object可以有多个键值对";
    }else if (btnTag == 4){
        labelText = @"在主线程执行代码，YES代表需要阻塞主线程，直到主线程将我们的代码执行完毕，如果是NO等同于afterDelay，等改函数全部执行完毕后在执行方法";
        [self performSelectorOnMainThread:@selector(executeOnMainThread:) withObject:@"onMainThread" waitUntilDone:YES];
    }else if (btnTag == 5){
        labelText = @"传递三个及以上函数：利用NSInvocation创建一个对象，重新包装一次消息传送（方法调用者、方法名、参数），注意构造参数时，需要考虑self 和 _cmd，自带参数。";
        [self sendTwoMoreParameters];
    }else if (btnTag == 6){
        labelText = @"封装成一个参数，例如NSDictionary，然后传过去";
        [self sendTwoMoreParamsWithDictionary];
    }else if (btnTag == 7){
        labelText = @"objc_msgSend(id,SEL,param1,param2,param3)";
        [self selectorTwoMoreParamsWithObjc_msgSend];
    }else if (btnTag == 8){
        labelText = @"延迟调用:实际是添加了一个定时器，被加到方法队列的最后，当正在被调用的方法执行完毕后，在执行selectorAfterDelay方法。但不能直接在子线程中调用：";
        [self performSelector:@selector(selectorAfterDelay) withObject:@"003" afterDelay:3];
    }else if (btnTag == 9){
        labelText = @"使用dispatch_after在子线程上执行 利用dispatch_after()延时调用，";
        
        // 子线程上执行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(ino64_t)(3*NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
            if ([self respondsToSelector:@selector(selectorDelayWithDispatch_after)]) {
                [self performSelector:@selector(selectorDelayWithDispatch_after) withObject:nil];
            }
        });
    }else if (btnTag == 10){
        labelText = @"afterDelay方法不能直接在子线程中调用：afterDelay方式是使用当前线程的RunLoop中，根据afterDelay参数创建一个定时器，在一定时间后调用SEL，NO是直接调用SEL,子线程中是没有runLoop的 ，需要手动创建";
        // 创建子线程的runloop
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self performSelector:@selector(selectorDelayWithDispatch_aysnc) withObject:nil afterDelay:3];
            NSRunLoop *currentLoop = [NSRunLoop currentRunLoop];
            [currentLoop run];
        });
    }else if (btnTag == 11){
        labelText = @"防止按钮多次点击：点击一次，把button设置不可点击，afterDelay 3s后，改变按钮状态";
        btn.enabled = NO;
        btn.backgroundColor = [UIColor lightGrayColor];
        [self performSelector:@selector(changeBtnStyle:) withObject:btn afterDelay:3];
    }else if (btnTag == 12){
        labelText = @"一般处理方式：判断tableView滑动时，不加载图片，静止再加载；运用runloop优化，NSDefalutRunLoopModel";
        UIImage *img = [UIImage imageNamed:@""];
        [self performSelector:@selector(afterDelayLoadImage:) withObject:img afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
    }else if (btnTag == 13){
        CommonWebVC *webVC = [[CommonWebVC alloc] init];
        webVC.titleStr = @"PerformSelector";
        webVC.urlStr = @"https://www.jianshu.com/p/672c0d4f435a";
        [self.navigationController pushViewController:webVC animated:YES];
    }
    self.textLabel.text = labelText;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
