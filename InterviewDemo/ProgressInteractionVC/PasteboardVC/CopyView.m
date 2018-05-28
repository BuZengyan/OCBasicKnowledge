//
//  CopyView.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/28.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#define kImageViewSize (60.0)
#define kPointX (30.0f)

#import "CopyView.h"
#import "UIImage+TestUIImage.h"

@implementation CopyView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        [self initView];
    }
    return self;
}

#pragma mark - 初始化控件
- (void)initView{
    [self addSubview:self.img1];
    [self addSubview:self.img2];
}

- (UIImageView *)img1{
    if (!_img1) {
        _img1 = [[UIImageView alloc] initWithFrame:CGRectMake(kPointX, kPointX, kImageViewSize, kImageViewSize)];
        _img1.image = [UIImage xh_imageNamed:@"0003.jpg"];
        _img1.backgroundColor = [UIColor lightGrayColor];
        _img1.tag = 1001;
    }
    return _img1;
}

- (UIImageView *)img2{
    if (!_img2) {
        _img2 = [[UIImageView alloc] initWithFrame:CGRectMake(kPointX * 2 + kImageViewSize, kPointX, kImageViewSize, kImageViewSize)];
        _img2.backgroundColor = [UIColor lightGrayColor];
        _img2.tag = 1002;
    }
    return _img2;
}

#pragma mark - 重写复制、粘贴方法
- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    NSArray *methodNameArr = @[@"copy:",@"cut:",@"select:",@"selectAll:",@"paste:"];
//    NSArray *methodNameArr = @[@"copy:",@"cut:",@"paste:"];
    if ([methodNameArr containsObject:NSStringFromSelector(action)]) {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

// 拷贝
- (void)copy:(id)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setImage:self.img1.image];
}

// 粘贴
- (void)paste:(id)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    self.img2.image = [pasteboard image];
    if (self.img1.image == nil) {
        self.img1.image = [pasteboard image];
    }
}

// 剪切
- (void)cut:(id)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setImage:self.img1.image];
    self.img1.image = nil;
}


// 选择
- (void)select:(id)sender{
    
}

// 选择全部
- (void)selectAll:(id)sender{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {
        NSLog(@"touch.view = %@ touch.view.tag = %ld",[touch.view class],touch.view.tag);
    }
    [self becomeFirstResponder];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    [menuController setTargetRect:self.img1.frame inView:self];
    [menuController setMenuVisible:YES animated:YES];
}


@end
