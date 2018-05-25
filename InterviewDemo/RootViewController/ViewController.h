//
//  ViewController.h
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/11.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/objc.h>

typedef struct objc_class *Class;
struct objc_object1{
    Class isa OBJC_ISA_AVAILABILITY;
};

@interface ViewController : UIViewController
@property (nonatomic, copy) NSString *name;

@end

