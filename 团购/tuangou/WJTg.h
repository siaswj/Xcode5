//
//  WJTg.h
//  tuangou
//
//  Created by wangjie on 14-10-30.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJTg : NSObject

@property (nonatomic, copy) NSString *buyCount;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *price;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)tgWithDic:(NSDictionary *)dic;

@end
