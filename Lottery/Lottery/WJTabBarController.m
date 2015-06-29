//
//  WJTabBarController.m
//  Lottery
//
//  Created by wangjie on 15-1-31.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJTabBarController.h"
#import "WJTabBar.h"

@interface WJTabBarController () <WJTabBarDelegate>
@end


@implementation WJTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.在系统的tabbar上添加一个自己定义的tabbar
    WJTabBar *tabBar = [[WJTabBar alloc] init];
    tabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:tabBar];
    
    // 2.往tabbar里添加按钮
    for (int i = 0; i < self.viewControllers.count; i++) {
        NSString *name = [NSString stringWithFormat:@"TabBar%d", i + 1];
        NSString *selName = [NSString stringWithFormat:@"TabBar%dSel", i + 1];
        [tabBar addButtonToTabBarWithName:name andSelName:selName];
    }

    // 3.设置代理
    tabBar.delegate = self;
    
    
}

#pragma mark - WJTabBarDelegate的代理方法
- (void)tabBar:(WJTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;   // to == button.tag
}

@end
