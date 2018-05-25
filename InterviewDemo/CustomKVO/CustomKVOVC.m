//
//  CustomKVOVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/22.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#define kPointX 20
#import "CustomKVOVC.h"
#import "Person.h"
#import "Sun.h"
#import "Animal.h"
#import "CommonLabel.h"

@interface CustomKVOVC ()
@property (nonatomic, strong)   Person  *p;
@property (nonatomic, strong)   Animal *animal;
@property (nonatomic, strong)   CommonLabel *label;

@end

@implementation CustomKVOVC
-(void)dealloc{
    [self.p removeObserver:self forKeyPath:@"name"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"KVO实践及原理";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.label];
    [self testKVO];
}

- (CommonLabel *)label{
    if (!_label) {
        _label = [[CommonLabel alloc] initWithFrame:CGRectMake(kPointX, kNavibarHeight / 4, kScreenWidth - kPointX * 2, 300)];
        _label.text = @"KVO底层实现原理：当我们注册监听时，会对注册者动态的创建一个子类对象，然后底层找方法的isa指针会指向新创建的子类对象。当改变注册对象的某个属性时，重写属性的get方法。\n参考文献：";
        __weak typeof(self) weakSelf = self;
        _label.pushToWebBlock = ^{
            [weakSelf pushToWebVC];
        };
    }
    return _label;
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


#pragma mark - PushToWebVC
- (void)pushToWebVC{
    
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
