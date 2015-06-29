//
//  WJFriendGroup.h
//  2-QQ好友列表
//
//  Created by wangjie on 14-12-1.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJFriendGroup : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *friends;  // 里面装的都是friend的模型对象
@property (nonatomic, assign) int online;
// 表示这组的状态，是打开状态，还是关闭状态，YES就是开着，NO就是关闭
@property (nonatomic, assign, getter = isOpened) BOOL opened;

+ (instancetype)groupWithDic:(NSDictionary *)dic;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
