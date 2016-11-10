//
//  AppDelegate.m
//  VKVickey_NCE
//
//  Created by Leou on 16/8/3.
//  Copyright © 2016年 Leou. All rights reserved.
//

#import "AppDelegate.h"

#import "VKTabBarController.h" //TabBar
#import "VKNavigationController.h" //Navigation

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark - 系统 application didFinishLaunchingWithOptions

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /** 设置属性 */
    [self initSubStatus];
    
    /** 初始化TabBarController 及 NavigationCOntrollers */
    [self initTabBarControllers];
    
    return YES;
}

#pragma mark - 设置导航和TabBarControllers

- (void)initTabBarControllers {
    
    VKTabBarController *vkTabBarController = [[VKTabBarController alloc] init];
    
    self.window.rootViewController = vkTabBarController;
}

#pragma mark - 设置全局状态或属性

- (void)initSubStatus {
    
    /** 设置导航／Tab的基本属性 */
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - 系统 UIApplicationDelegate

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
