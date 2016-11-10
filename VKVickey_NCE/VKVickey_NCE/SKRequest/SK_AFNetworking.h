//
//  SK_AFNetworking.h
//  VKVickey_NCE
//
//  Created by Leou on 16/8/4.
//  Copyright © 2016年 Leou. All rights reserved.
//

/**
 *  基于AFNetworking的二次封装：减少对第三方库的依赖，便于替换或更改第三方库
 */

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

/**
 *  所有接口返回的类型都是基类NSURLSessionTask，若要接收返回值且处理，请转换成对应的子类类型
 */
typedef NSURLSessionTask SKURLSessionTask;


@interface SK_AFNetworking : NSObject


#pragma mark - 基础属性设置
/**
 *  外部设置／更新IP
 *  用于指定网络请求接口的基础IP，如：http://baidu.com或者http://192.168.1.1 通常在AppDelegate中启动时就设置一次就可以了。如果接口有来源于多个服务器。可以调用更新
 *
 *  @param skBaseUrl 网络接口的基础url
 */
+ (void)sk_setBaseUrl:(NSString *)skBaseUrl;

/**
 *  外部只读IP
 */
@property (nonatomic, strong, readonly)NSString *skBaseUrl;

+ (NSString *)skBaseUrl;

/**
 *  设置请求超时时间，默认为30秒
 *
 *  @param skTimeout 超时时间
 */
+ (void)sk_setTimeout:(NSTimeInterval)skTimeout;

#pragma mark - GET 请求


@end
