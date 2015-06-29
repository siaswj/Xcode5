//
//  WJTabBarButton.m
//  Lottery
//
//  Created by wangjie on 15-1-31.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJTabBarButton.h"

@implementation WJTabBarButton

/**
 *  重写这个方法，按钮就不存在高亮状态了.不调用super就不会调用按钮的高亮调整
 */
- (void)setHighlighted:(BOOL)highlighted
{}

@end
