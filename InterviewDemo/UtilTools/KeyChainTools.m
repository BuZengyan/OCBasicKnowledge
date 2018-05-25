//
//  KeyChainTools.m
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/25.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  密匙存储

/**
 *  KeyChain是iOS OSX 用于存储用户名、密码、什么验证等信息。常用的一个安全容器，防止重复输入用户名密码。
 */

#import "KeyChainTools.h"
#import <Security/Security.h>
/**
 *  自定义存储条目：Prefix + BundleID 例如:8UXF6NUE7S.com.baozun.ZyShare
 *  默认存储条目：BundleID 命名的条目
 */
NSString *const accessItem = @"8UXF6NUE7S.com.baozun.ZyShare";
@implementation KeyChainTools

// 返回基本字典
+(NSMutableDictionary *)getKeyChainQuery:(NSString *)service{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service,(id)kSecAttrService,
            service,(id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible, nil];
}

// add
+ (void)addKeyChainData:(id)data forKey:(NSString *)key{
    // 1.get search dictionary
    NSMutableDictionary *keyChainQuery = [self getKeyChainQuery:key];
    
    // 2.delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keyChainQuery);
    
    /**
     *  setObject:accessItem 意思是把密码存储在我们自己设置的条目下，系统默认存储在用bundle ID 命名的条目下。自定义条目格式：TeamID.BundleID。如果不想其他APP共享KeyChain，则使用系统默认条目即可。
     */
    [keyChainQuery setObject:accessItem forKey:(id)kSecAttrAccessGroup];
    
    // 3.add new object to search dictionary (Attention:the data format)
    [keyChainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    
    // 4.add Item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keyChainQuery, NULL);
}

// delete
+ (void)deleteWithService:(NSString *)service{
    NSMutableDictionary *keyChainQuery = [self getKeyChainQuery:service];
    SecItemDelete((CFDictionaryRef)keyChainQuery);
}

// update
+ (void)updateKeyChainData:(id)data forKey:(NSString *)key{
    // 1.get search dictionary
    NSMutableDictionary *keyChainQuery = [self getKeyChainQuery:key];
    
    // 2.
    [keyChainQuery setObject:accessItem forKey:(id)kSecAttrAccessGroup];
    
    // 3.
    NSData *updata = [NSKeyedArchiver archivedDataWithRootObject:data];
    NSDictionary *myDate = @{(__bridge id)kSecValueData : updata};
    SecItemUpdate((__bridge CFDictionaryRef)keyChainQuery, (__bridge CFDictionaryRef)myDate);
}

+ (id)readForKey:(NSString *)key{
    id ret = nil;
    NSMutableDictionary *keyChainQuery = [self getKeyChainQuery:key];
    [keyChainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keyChainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keyChainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try{
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        }@catch(NSException *e){
            NSLog(@"Unarchive of %@ failed:%@",key,e);
        }@finally{
            
        }
    }
    
    if (keyData) {
        CFRelease(keyData);
    }
    return ret;
}
@end
