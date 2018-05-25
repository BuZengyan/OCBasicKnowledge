//
//  KeyChainTools.h
//  InterviewDemo
//
//  Created by zengyan.bu on 2018/5/25.
//  Copyright © 2018年 zengyan.bu. All rights reserved.
//  密匙存储

#import <Foundation/Foundation.h>

@interface KeyChainTools : NSObject
/**
 *  KeyChain的基础用法：
 *  1.加入Security库，引入头文件#import<Security/Security.h>
 *  2.KeyChain的用法类似于数据库splite3.0，有增、删、查、改功能
 */


/**
 *  KeyChain是基于字典的
 *  @param  service 查询、创建关键字
 *  @return 基本字典
 */
+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)service;

/**
 *  增加一个值
 *  @param  data    增加的数据
 *  @param  key     钥匙
 */
+ (void)addKeyChainData:(id)data forKey:(NSString *)key;

/**
 *  删除一个值
 *  @param  service 删除key？可以这样理解
 */
+ (void)deleteWithService:(NSString *)service;

/**
 *  更改一个值
 *  @param  data    更改的值
 *  @param  key     钥匙
 */
+ (void)updateKeyChainData:(id)data forKey:(NSString *)key;

/**
 *  查找一个值
 *  @param  key 关键字
 */
+ (id)readForKey:(NSString *)key;

@end
