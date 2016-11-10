//
//  SKNormalViewController.m
//  VKVickey_NCE
//
//  Created by Leou on 16/8/8.
//  Copyright © 2016年 Leou. All rights reserved.
//

#import "SKNormalViewController.h"

#import "UINavigationBar+SKBackground.h"

@interface SKNormalViewController () <UIGestureRecognizerDelegate> {
    
    /** 设置背景条颜色：如果从一个隐藏Navi的页面Push到该页面，则需要设置navigationView背景颜色，否则会有一个空白的闪烁，设置方法通过外部属性 */
    UIView                     *navigationView;
    
    
    /***  给导航覆盖一个物，用于渐变透明处理。 */
    /**
     *  是否开始导航透明状态：默认为NO
     *
     *      1 表示滑动的时候导航透明或者不透明
     *      0 表示滑动的时候导航一直显示
     */
    BOOL                        skNaviBarStatus;
    /**
     *  滑动隐藏的高度
     */
    CGFloat                     skHiddenHeight;
    /**
     *  显示的颜色
     */
    UIColor                     *skOverlayViewColor;
}

@end

@implementation SKNormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    skNaviBarStatus = NO;
}

/**
 *  下面这两个设置：设置导航状态(隐藏／不隐藏)，如果隐藏了导航则需要设置系统导航侧滑手势，否则隐藏后侧滑失效
 */
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setSkNavigationColor:(UIColor *)skNavigationColor {
    
    if (!skNavigationColor) {
        
        return;
    }
    
    if (!navigationView) {
        
        navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44 + 20)];
        [self.view addSubview:navigationView];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        [navigationView setBackgroundColor:[skNavigationColor colorWithAlphaComponent:1]];
        
    } completion:nil];
}

/**
 *  滑动页面的时候，让导航变渐变透明。可以只设置skNaviBarStatus，然后在子类单独处理。
 *
 *  @param skNavigationBarStatus    控制是否透明处理，默认NO，一直显示导航。
 *  @param scrollHeight             需要滑动隐藏的位置
 *  @param obj                      滑动的对象
 */
- (void)skSetupNaviBarStatus:(BOOL)skNavigationBarStatus willHiddenHeight:(CGFloat)scrollHeight overlayViewColor:(UIColor *)aColor {
    
    skNaviBarStatus = skNavigationBarStatus;
    skHiddenHeight  = scrollHeight;
    skOverlayViewColor = aColor;
}


/** 当滑动视图的时候，根据偏移量改变透导航明度 */
- (void)skNavigationBarAlphaChangedWithContentOffsetY:(CGFloat)contentOffsetY completed:(SKComplete)completed {
    
    if (!skNaviBarStatus) {
        
        return;
    }
    //颜色
    UIColor *overlayColor = (skOverlayViewColor ? skOverlayViewColor : [UINavigationBar appearance].barTintColor);
    //滑动偏移量
    CGFloat offsetY = contentOffsetY;
    
    if (offsetY >= skHiddenHeight - 64) {
        
        CGFloat alpha = MIN(1, (skHiddenHeight + 64 + offsetY)/skHiddenHeight);
        
        [UIView animateWithDuration:0.8 animations:^{
            
            [self.navigationController.navigationBar skBackgroundColor:[overlayColor colorWithAlphaComponent:alpha]];
            
        } completion:^(BOOL finished) {
            
            completed(YES);
        }];
        
    }else {
        
        [UIView animateWithDuration:0.8 animations:^{
            
            [self.navigationController.navigationBar skBackgroundColor:[overlayColor colorWithAlphaComponent:0]];
            
        } completion:^(BOOL finished) {
            
            completed(NO);
        }];
    }
}

/**
 *  重置Navi属性：恢复原始状态
 */
- (void)skResetNaviBarAllStatus {
    
    skNaviBarStatus = NO;
    
    [self.navigationController.navigationBar skResetNavigationBar];
}

- (void)dealloc {
    
    [navigationView removeFromSuperview];
    navigationView = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
