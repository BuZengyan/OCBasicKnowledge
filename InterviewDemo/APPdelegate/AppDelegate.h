//
//  AppDelegate.h
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/11.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

