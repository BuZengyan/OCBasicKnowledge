//
//  ViewController.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/11.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//


#define kPointX (30)
#define kPointY (60)
#define kCellHeight (60.0f)

#import "ViewController.h"
#import <objc/objc.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "Person.h"
#import "UIImageView+UIImageViewSelf.h"
#import "Sun.h"
#import "Animal.h"
#import "NSObject+KVO.h"
#import "RuntimeMessageVC.h"
#import "CustomRunLoopVC.h"
#import "CustomKVOVC.h"
#import "AppTurnToOtherAppVC.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)   Person  *p;
@property (nonatomic, strong)   Animal *animal;
@property (nonatomic, strong)   UIButton *runtimeButton;
@property (nonatomic, strong)   UITableView *mainTableView;
@property (nonatomic, strong)   NSMutableArray  *dataArray;
@property (nonatomic, strong)   NSMutableArray  *viewControllersArray;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"OC知识实践";
    // 基本知识点
//    [self testRunTime];
//    [self testGCD];
//    [self testRunLoop];
//    [self testKVO];
//    objc_msgSend(self, @selector(testKVO));
    
    [self.view addSubview:self.mainTableView];
}
#pragma mark - 初始化数据源
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        [_dataArray addObject:@"Runtime"];
        [_dataArray addObject:@"RunLoop"];
        [_dataArray addObject:@"StackAndHeap"];
        [_dataArray addObject:@"KVO"];
        [_dataArray addObject:@"进程间的通信"];
        [_dataArray addObject:@"APP间的跳转传值"];
    }
    return _dataArray;
}

- (NSMutableArray *)viewControllersArray{
    if (!_viewControllersArray) {
        _viewControllersArray = [[NSMutableArray alloc] init];
        [_viewControllersArray addObject:@"RuntimeMessageVC"];
        [_viewControllersArray addObject:@"CustomRunLoopVC"];
        [_viewControllersArray addObject:@"StackAndHeapVC"];
        [_viewControllersArray addObject:@"CustomKVOVC"];
        [_viewControllersArray addObject:@"ProgressInteractionVC"];
        [_viewControllersArray addObject:@"AppTurnToOtherAppVC"];
    }
    return _viewControllersArray;
}

#pragma mark - 初始化控件
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
    }
    return _mainTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"cellStr";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [self.viewControllersArray objectAtIndex:indexPath.row];
    Class class = NSClassFromString(str);
    if (class) {
        UIViewController *vc = class.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - runtime使用
- (void)testRunTime{
    [Person run];
    [Person study];
    
    // 利用runtime实现方法交换
    Method m1 = class_getClassMethod([Person class], @selector(run));
    Method m2 = class_getClassMethod([Person class], @selector(study));
    // 交换实现方法
    method_exchangeImplementations(m1, m2);
    [Person run];
    [Person study];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(10, 200, 200, 200);
    imgView.backgroundColor = [UIColor orangeColor];
    imgView.image = [UIImage imageNamed:@""];
    [self.view addSubview:imgView];
    
    Method m3 = class_getClassMethod([UIImageView class], @selector(init));
    Method m4 = class_getClassMethod([UIImageView class], @selector(test_init:));
    method_exchangeImplementations(m3, m4);
}

#pragma mark - 线程通信
- (void)testGCD{
    // 开启一个全局队列的子线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 1.开始数据请求
        // ...
        // 2.数据请求完毕
        
        // 主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回到主线程刷新UI
            
        });
    });
    
    // 自定义队列,开启新的子线程
    dispatch_queue_t custom_queue =  dispatch_queue_create("concurrentqueue", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(custom_queue, ^{
            NSLog(@"#### 并行队列 %d ##",i);
            // 数据更新完毕回调主线程，线程之间通信
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"我在主线程通信");
            });
        });
    }
    
    // 线程中延迟调用某个方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (ino64_t)(5.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 在主线程延迟5秒调用
    });
    
    // 常用线程通信方法：
    // 1.需要更新UI操作时更新UI操作
    dispatch_async(dispatch_get_main_queue(), ^{
        // 数据执行完毕回调到主线程更新UI操作
    });
    
    // 2.使用系统的全局队列：一般用这个处理遍历大数据查询操作
    // 全局并发队列执行处理大量逻辑时使用
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        //
    });
    
    // 同步线程
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        // 全部等待该线程完成
    });
    
}

#pragma mark - testRunLoop
- (void)testRunLoop{
    [NSRunLoop currentRunLoop]; /// 获取当前线程的runLoop
    [NSRunLoop mainRunLoop];    /// 主线程的runloop对象
    CFRunLoopGetMain();
    CFRunLoopGetCurrent();
    
}

#pragma mark - 获取字符串中字符个数
- (void)testCharNumbersOfString{
    
}

// 1.只针对英文
- (NSUInteger)unicodeLengthOfString:(NSString *)text{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex:i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
    
}

// 2.中英文混合
- (int)convertToInt:(NSString *)strTemp{
    return 0;
}

#pragma mark - KVO原理及自定义KVO
/**
 *  KVO底层实现原理：
    当我们注册监听时，会对注册者动态的创建一个子类对象，然后底层找方法的isa指针会指向新创建的子类对象。当改变注册对象的某个属性时，重写属性的get方法。
 */
- (void)testKVO{
    self.p = [[Person alloc] init];
    
    // 注册监听，p有Person类变为NSKVONotyfing_Person类
    [self.p addObserver:self
             forKeyPath:@"name"
                options:NSKeyValueObservingOptionNew context:nil];
}

// 点击屏幕后改变属性的值
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.p.name = @"小明";
}

// KVO监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context{
    NSString *newName = [change objectForKey:@"new"];
    NSLog(@"%@监听到%@属性的值改变为%@",object,keyPath,newName);
}

#pragma mark - 自定义KVO
- (void)testCustomKVO{
    self.animal = [[Animal alloc] init];
    // 注册自定义监听
    [self.animal ZY_addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
}


#pragma mark - super Class

#pragma mark - object_class
- (void)testObject_Class{
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
