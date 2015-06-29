//
//  WJTabBar.h
//  Lottery
//
//  Created by wangjie on 15-1-31.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJTabBar;

@protocol WJTabBarDelegate <NSObject>
@optional
- (void)tabBar:(WJTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
@end


@interface WJTabBar : UIView
@property (nonatomic, weak) id<WJTabBarDelegate> delegate;

- (void)addButtonToTabBarWithName:(NSString *)name andSelName:(NSString *)selName;
@end
