//
//  WJCarGroup.h
//  UITableView
//
//  Created by wangjie on 14-10-28.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJCarGroup : NSObject

@property (nonatomic, strong) NSArray *cars;
@property (nonatomic, copy) NSString *title;

- (instancetype)initWithDict:(NSDictionary *)dic;
+ (instancetype)groupWithDict:(NSDictionary *)dic;

@end
