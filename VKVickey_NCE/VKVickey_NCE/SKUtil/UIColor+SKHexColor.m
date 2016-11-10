//
//  UIColor+SKHexColor.m
//  Vickey_NCE
//
//  Created by LeouWang on 16/5/3.
//  Copyright © 2016年 网赢天下. All rights reserved.
//

#import "UIColor+SKHexColor.h"

@implementation UIColor (SKHexColor)

+ (UIColor *)colorWithHexString:(NSString *) stringToConvert {
    
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

#pragma mark - 主题色
/** 颜色代码 - 主题色 22d3b6 **/
+ (UIColor *)skThemeColor {
    
    return [self colorWithHexString:@"#22d3b6"];
}

#pragma mark - 透明无颜色
+ (UIColor *)skClearColor {
    
    return [UIColor clearColor];
}

#pragma mark - 白色
+ (UIColor *)skWhiteColor {
    
    return [UIColor whiteColor];
}

#pragma mark - 背景颜色
+ (UIColor *)skBackgroundLowGrayColor {
    
    return [self colorWithHexString:@"#f3f3f3"];
}

#pragma mark - TabBarItem

/** 颜色代码 - TabBarItem 正常状态颜色 768da4 **/
+ (UIColor *)skTabBarItemNormalColor {
    
    return [self colorWithHexString:@"#768da4"];
}

/** 颜色代码 - TabBarItem 选中状态颜色 22d3b6 **/
+ (UIColor *)skTabBarItemSelectColor {
    
    return [self colorWithHexString:@"#22d3b6"];
}

@end
