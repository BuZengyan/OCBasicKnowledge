//
//  RuntimeMessageVC.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/18.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import "RuntimeMessageVC.h"
#import "Message.h"
#import "NSObject+AssociatedObject.h"
@interface RuntimeMessageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)   Message *message;
@property (nonatomic, strong)   UITableView *mainTableView;
@property (nonatomic, strong)   NSMutableArray  *dataArray;
@property (nonatomic, strong)   NSMutableArray  *nameArray;
@end

@implementation RuntimeMessageVC
#pragma mark - 初始化数据源
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        [_dataArray addObject:@"消息发送及转发"];
        [_dataArray addObject:@"categroy动态添加属性"];
        [_dataArray addObject:@"MethodSwizzling黑魔法：交换"];
        [_dataArray addObject:@"MethodSwizzling黑魔法：类簇"];
        [_dataArray addObject:@"performSelector与直接调用"];
    }
    return _dataArray;
}

- (NSMutableArray *)nameArray{
    if (!_nameArray) {
        _nameArray = [[NSMutableArray alloc] init];
        [_nameArray addObject:@"MessageSendAndForwardingVC"];
        [_nameArray addObject:@"AddAssociatedObjectedVC"];
        [_nameArray addObject:@"MethodSwizzlingVC"];
        [_nameArray addObject:@"MethodSwizzlingForLeiCuVC"];
        [_nameArray addObject:@"PerformSelectorVC"];

    }
    return _nameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Runtime运行机制";
    [self.view addSubview:self.mainTableView];
    
    /*
    self.message = [[Message alloc] init];
    self.message.associatedObject= @"3";
    NSLog(@"associatedObject = %@",self.message.associatedObject);
    [self.message sendMessage:@"sam"];
     */
    
}

#pragma mark - 初始控件
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
    }
    return _mainTableView;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
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
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *className = [self.nameArray objectAtIndex:indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = class.new;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
