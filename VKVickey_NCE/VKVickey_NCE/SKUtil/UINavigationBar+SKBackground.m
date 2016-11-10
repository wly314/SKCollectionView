//
//  UINavigationBar+SKBackground.m
//  VKVickey_NCE
//
//  Created by Leou on 16/8/8.
//  Copyright © 2016年 Leou. All rights reserved.
//

#import "UINavigationBar+SKBackground.h"

#import <objc/runtime.h>

@implementation UINavigationBar (SKBackground)

static char overlayKey;

/** 通过runtime动态绑定修改属性 */
- (UIView *)overlay {
    
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay {
    
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/** 设置导航的背景颜色 **/
- (void)skBackgroundColor:(UIColor *)backgroundColor {
    
    if (!self.overlay) {
        
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        //用于去除导航栏的底线，也就是周围的边线
        [self setShadowImage:[UIImage new]];
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
    }
    self.overlay.backgroundColor = backgroundColor;
}

/** 恢复初始还导航的状态 */
- (void)skResetNavigationBar {
    
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //恢复用于去除导航栏的底线，也就是周围的边线
    [self setShadowImage:nil];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}

@end
