//
//  CommonLabel.h
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/22.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

typedef void(^PushToWebBlock)(void);
#import <UIKit/UIKit.h>

@interface CommonLabel : UILabel
@property (nonatomic, copy) PushToWebBlock pushToWebBlock;  /// 跳转到web
@end
