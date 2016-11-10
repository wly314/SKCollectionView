//
//  SKAdScrollView.h
//  VKVickey_NCE
//
//  Created by Leou on 2016/10/8.
//  Copyright © 2016年 Leou. All rights reserved.
//

//  循环轮播图

#import <UIKit/UIKit.h>

/** PageControl的样式：居中 居左 居右 */
typedef NS_ENUM(NSUInteger, UIPageControlShowStyle) {
    
    UIPageControlShowStyleNone,//default = center
    UIPageControlShowStyleLeft,
    UIPageControlShowStyleCenter,
    UIPageControlShowStyleRight,
};

@protocol SKAdScrollViewDelegate;

@interface SKAdScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, weak) id<SKAdScrollViewDelegate> adDelegate;

/** 展示的图片数组 */
@property (retain, nonatomic, readwrite) NSArray    *skImagesUrlArray;
/** PageControl的样式，不设置默认居中 */
@property (assign, nonatomic, readwrite) UIPageControlShowStyle  skPageControlShowStyle;

/** 广告标题 */
@property (retain, nonatomic, readwrite) NSArray    *skAdTitleArray;

@end

@protocol SKAdScrollViewDelegate <NSObject>

@optional

- (void)adScrollView:(SKAdScrollView *)adScrollView didClickAdView:(UIImageView *)adView;

@end
