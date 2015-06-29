//
//  WJCar.h
//  UITableView
//
//  Created by wangjie on 14-10-28.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJCar : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)carWithDic:(NSDictionary *)dic;

@end
