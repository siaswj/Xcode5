//
//  WJTabBar.m
//  Lottery
//
//  Created by wangjie on 15-1-31.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJTabBar.h"
#import "WJTabBarButton.h"

@interface WJTabBar ()
/**
 *  记录上一个选中的按钮
 */
@property (nonatomic, weak) UIButton *selButton;
@end


@implementation WJTabBar

/**
 *  调用这个方法添加一个按钮到tababr中
 */
- (void)addButtonToTabBarWithName:(NSString *)name andSelName:(NSString *)selName
{
    WJTabBarButton *button = [WJTabBarButton buttonWithType:UIButtonTypeCustom];
    
    [self addSubview:button];
    
    [button setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selName] forState:UIControlStateSelected];
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];   // ...down：按下去就会触发点击事件

}

/**
 *  当一个控件的frame确定后，会自动调用这个方法来摆正其内部的子控件(设置内部子控件的frame)
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置frame
    for (int i = 0; i < self.subviews.count; i++) {
        WJTabBarButton *button = self.subviews[i];
        CGFloat buttonY = 0;
        CGFloat buttonW = self.frame.size.width / self.subviews.count;
        CGFloat buttonH = self.frame.size.height;
        CGFloat buttonX = i * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 2.进入界面默认显示选中第一个按钮
        if (i == 0) {
            [self buttonClick:button];
        }
        
        // 3.绑定button的tag －－ (一个button对应一个控制器)
        button.tag = i;
    }
}

/**
 *  tabbar上的按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    // 通知代理切换子控制器
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selButton.tag to:button.tag];
    }
    
    self.selButton.selected = NO;
    button.selected = YES;
    self.selButton = button;
}

@end
