//
//  WJNavigationController.m
//  Lottery
//
//  Created by wangjie on 15-1-31.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJNavigationController.h"

@interface WJNavigationController ()

@end

@implementation WJNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"---viewDidLoad---");
}

/**
 *  这个方法一个类只会被调用一次
 *  storyboard中的五个导航控制器都是WJNavigationController，所以在这里设置导航栏的外观，只会设置一次，性能比在viewDidLoad中好一点（viewDidLoad中会调用五次）
 */
+ (void)initialize
{
    // 设置导航栏外观\主题：设置一次，整个项目的导航栏都会改变
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) {
        [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    } else {
        [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar"] forBarMetrics:UIBarMetricsDefault];
    }
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [navBar setTitleTextAttributes:attr];
    
    navBar.tintColor = [UIColor redColor];
    // navBar.barTintColor = [UIColor greenColor];
    
    
    
    
    // 设置BarButtonItem的外观\主题
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *itemAttr = [NSMutableDictionary dictionary];
    itemAttr[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    itemAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [item setTitleTextAttributes:itemAttr forState:UIControlStateNormal];
    
    // item.tintColor = [UIColor redColor];
}

/**
 *  想在控制器进栈的时候做一些操作，就拦截进栈，重写导航控制器的pushViewController:animated:
 *  想在控制器出栈的时候做一些操作，就拦截出栈，重写导航控制器的popViewControllerAnimated:
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end
