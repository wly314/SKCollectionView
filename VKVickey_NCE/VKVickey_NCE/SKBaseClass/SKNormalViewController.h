//
//  SKNormalViewController.h
//  VKVickey_NCE
//
//  Created by Leou on 16/8/8.
//  Copyright © 2016年 Leou. All rights reserved.
//

/**
 *  导航二级以及多级页面需要继承该页面。
 *  
 *      处理导航隐藏或透明
 */

#import <UIKit/UIKit.h>

#import "SKDefined.h"

@interface SKNormalViewController : UIViewController

/** 设置背景条颜色：如果从一个隐藏Navi的页面Push到该页面(该页面navi不隐藏)，则需要设置navigationView背景颜色，否则会有一个空白的闪烁，设置方法通过外部属性 */
@property (nonatomic, strong)UIColor  *skNavigationColor;

/**
 *  滑动页面的时候，让导航变渐变透明。可以只设置skNaviBarStatus，然后在子类单独处理。不设置该属性则默认一直显示。
 *
 *  @param skNavigationBarStatus    控制是否透明处理，默认NO，一直显示导航。
 *  @param scrollHeight             需要滑动隐藏的位置
 *  @param obj                      滑动的对象
 */
- (void)skSetupNaviBarStatus:(BOOL)skNavigationBarStatus willHiddenHeight:(CGFloat)scrollHeight overlayViewColor:(UIColor *)aColor;

/**
 *  当滑动视图的时候，根据偏移量改变透导航明度
 *
 *  @param contentOffsetY Y方向的偏移量
 *  @param completed      这里用来记录透明度：YES 透明度为1  NO 透明度为0
 */
- (void)skNavigationBarAlphaChangedWithContentOffsetY:(CGFloat)contentOffsetY completed:(SKComplete)completed;

/**
 *  重置Navi属性：恢复原始状态
 */
- (void)skResetNaviBarAllStatus;

@end
