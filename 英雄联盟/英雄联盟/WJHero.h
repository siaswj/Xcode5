//
//  WJHero.h
//  英雄联盟
//
//  Created by wangjie on 14-10-29.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJHero : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *intro;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)heroWithDic:(NSDictionary *)dic;

@end
