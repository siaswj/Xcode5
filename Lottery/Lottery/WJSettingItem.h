//
//  WJSettingItem.h
//  Lottery
//
//  Created by wangjie on 15-2-1.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WJSettingItemOption)();

@interface WJSettingItem : NSObject
/**
 *  item的图片
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  item的标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  存一段代码，就是block
 */
@property (nonatomic, copy) WJSettingItemOption option;


+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
@end
