//
//  VKTabBarController.m
//  VKVickey_NCE
//
//  Created by Leou on 16/8/8.
//  Copyright © 2016年 Leou. All rights reserved.
//

#import "VKTabBarController.h"

#import "VKNavigationController.h"//导航

#import "SKTabHomeViewController.h"//首页的根页面
#import "SKTabCourseViewController.h"//课程页的根页面
#import "SKTabDiscussViewController.h"//讨论组的根页面
#import "SKTabMineViewController.h"//个人信息的根页面


@interface VKTabBarController ()

@end

@implementation VKTabBarController

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        /** 初始化所有的根视图 */
        [self initTabBarControllers];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置TabBarItem属性与TabBarControllers

- (void)initTabBarControllers {
    
    /** 设置字体颜色：选中状态和非选中状态 */
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor skTabBarItemNormalColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor skTabBarItemSelectColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    /** UIImageRenderingModeAlwaysOriginal 系统不处理图片，按照最原始状态显示 */
    
    SKTabHomeViewController *homeVC = [[SKTabHomeViewController alloc] init];
    VKNavigationController *homeNaviController = [[VKNavigationController alloc] initWithRootViewController:homeVC];
    homeNaviController.tabBarItem.title = NSLocalizedString(@"Home", @"");
    [homeNaviController.tabBarItem setImage:[[UIImage imageNamed:@"tab_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [homeNaviController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_home_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    SKTabCourseViewController *courseVC = [[SKTabCourseViewController alloc] init];
    VKNavigationController *courseNaviController = [[VKNavigationController alloc] initWithRootViewController:courseVC];
    courseNaviController.tabBarItem.title = NSLocalizedString(@"Course", @"");
    [courseNaviController.tabBarItem setImage:[[UIImage imageNamed:@"tab_course_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [courseNaviController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_course_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    SKTabCourseViewController *discussVC = [[SKTabCourseViewController alloc] init];
    VKNavigationController *discussNaviController = [[VKNavigationController alloc] initWithRootViewController:discussVC];
    discussNaviController.tabBarItem.title = NSLocalizedString(@"Discuss", @"");
    [discussNaviController.tabBarItem setImage:[[UIImage imageNamed:@"tab_discuss_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [discussNaviController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_discuss_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    SKTabMineViewController *meVC = [[SKTabMineViewController alloc] init];
    VKNavigationController *meNaviController = [[VKNavigationController alloc] initWithRootViewController:meVC];
    meNaviController.tabBarItem.title = NSLocalizedString(@"Me", @"");
    [meNaviController.tabBarItem setImage:[[UIImage imageNamed:@"tab_me_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [meNaviController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_me_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    NSArray *viewControllersArray = [NSArray arrayWithObjects:homeNaviController, courseNaviController, discussNaviController, meNaviController, nil];
    
    self.viewControllers = viewControllersArray;
}

#pragma mark - UITabBarControllerDelegate <NSObject>

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
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
