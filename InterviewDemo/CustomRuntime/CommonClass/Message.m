//
//  Message.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/18.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//

#import "Message.h"
#import <objc/runtime.h>
#import "MessageForwarding.h"

@implementation Message
/*
-(void)sendMessage:(NSString *)word{
    NSLog(@"normal way: sendMessage = %@",word);
}
 */

// Method Resolution
/**
 *  在方法调用过程中如果没有找到该方法，则会启用消息转发机制
 */

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    if (sel == @selector(sendMessage:)) {
        class_addMethod([self class], sel, imp_implementationWithBlock(^(id self, NSString *word){
            NSLog(@"method resolution way : sendMessag = %@",word);
        }), "v@:@");
    }
    return YES;
}


// Fast Forwarding
/**
 *  Fast Forwarding
 *  如果目标对象实现-forwardingTargetForSelector:方法，系统就会运行时调用这个方法，只要这个方法返回的不是nil或self，也会重启消息发送的过程，把这个消息转给其他对象处理。否则就会继续Normal Forwarding.
 */

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(sendMessage:)){
        return [[MessageForwarding alloc] init];
    }
    return nil;
}
 

//
/**
 *  Normal Forwarding:
 *  1.首先调用methodSignatureForSelector:方法获取函数的参数和返回值，如果返回nil，程序会崩溃，抛出异常信息。
    2.若果返回函数名，系统会自动创建一个NSInvocation对象并调用-forwardInvocation:方法。
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if(!methodSignature){
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    MessageForwarding *messageForwarding = [MessageForwarding new];
    if([messageForwarding respondsToSelector:anInvocation.selector]){
        [anInvocation invokeWithTarget:messageForwarding];
    }
}

@end
