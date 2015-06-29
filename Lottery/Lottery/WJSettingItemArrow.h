//
//  WJSettingItemArrow.h
//  Lottery
//
//  Created by wangjie on 15-2-1.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJSettingItem.h"

@interface WJSettingItemArrow : WJSettingItem

/**
 *  点击item后要跳转的控制器
 */
@property (nonatomic, assign) Class destVcClass;


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;

@end
