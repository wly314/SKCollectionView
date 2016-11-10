//
//  SK_AFNetworking.m
//  VKVickey_NCE
//
//  Created by Leou on 16/8/4.
//  Copyright © 2016年 Leou. All rights reserved.
//

#import "SK_AFNetworking.h"

//网络请求基础IP地址
static NSString *sk_privateNetworkBaseUrl = nil;

//默认超时时间
static NSTimeInterval sk_timeout = 30.0f;

@implementation SK_AFNetworking

#pragma mark - 基础属性

+ (void)sk_setBaseUrl:(NSString *)skBaseUrl {
    
    sk_privateNetworkBaseUrl = skBaseUrl;
}

+ (NSString *)skBaseUrl {
    
    return sk_privateNetworkBaseUrl;
}

+ (void)sk_setTimeout:(NSTimeInterval)skTimeout {
    
    sk_timeout = skTimeout;
}

#pragma mark - GET 请求

@end
