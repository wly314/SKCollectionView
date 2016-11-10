//
//  SKDefined.h
//  VKVickey_NCE
//
//  Created by Leou on 16/8/11.
//  Copyright © 2016年 Leou. All rights reserved.
//

/**
 *  该文件用于创建常用的宏定义 或者 导入常用的函数文件
 */

#ifndef SKDefined_h
#define SKDefined_h

#pragma mark - 导入头文件

/** 基本常用的函数 */
#import "SKFunction.h"
#import "UIColor+SKHexColor.h"//颜色库

/** 最常用的第三方库--大部分文件都会用到 */
#import "Masonry.h"
#import "MJRefresh.h"

#pragma mark - 宏定义

/** 屏幕宽 高 */
#define UISCREEN_WEIGHT ([UIScreen mainScreen].bounds.size.width)
#define UISCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#endif /* SKDefined_h */
