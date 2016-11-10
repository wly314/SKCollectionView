//
//  UIColor+SKHexColor.h
//  Vickey_NCE
//
//  Created by LeouWang on 16/5/3.
//  Copyright © 2016年 网赢天下. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface UIColor (SKHexColor)

#pragma mark - 十六进制颜色转换
+ (UIColor *)colorWithHexString:(NSString *) stringToConvert;

#pragma mark - 主题色
/** 颜色代码 - 主题色 22d3b6 **/
+ (UIColor *)skThemeColor;

#pragma mark - 无颜色
/** 颜色代码 - 无颜色 **/
+ (UIColor *)skClearColor;

#pragma mark - 背景颜色-白色
/** 颜色代码 - 白色 **/
+ (UIColor *)skWhiteColor;

#pragma mark - 背景颜色-浅灰色 f3f3f3
/** 颜色代码 - f3f3f3 **/
+ (UIColor *)skBackgroundLowGrayColor;



#pragma mark - TabBarItem

/** 颜色代码 - TabBarItem 正常状态颜色 768da4 **/
+ (UIColor *)skTabBarItemNormalColor;

/** 颜色代码 - TabBarItem 选中状态颜色 22d3b6 **/
+ (UIColor *)skTabBarItemSelectColor;





@end
