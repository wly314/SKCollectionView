//
//  UINavigationBar+SKBackground.h
//  VKVickey_NCE
//
//  Created by Leou on 16/8/8.
//  Copyright © 2016年 Leou. All rights reserved.
//

/**
 *  处理导航透明，以及上下滑动隐藏导航的逻辑
 *
 */

#import <UIKit/UIKit.h>

@interface UINavigationBar (SKBackground)

/** 设置导航的背景颜色 **/
- (void)skBackgroundColor:(UIColor *)backgroundColor;

/** 恢复初始还导航的状态 */
- (void)skResetNavigationBar;

@end
