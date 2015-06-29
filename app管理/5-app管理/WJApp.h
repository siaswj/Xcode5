//
//  WJApp.h
//  5-app管理
//
//  Created by wangjie on 14-12-3.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 使用KVC注意事项：设置的成员名必须跟plist文件中的key的名一样，否则无法使用KVC!!!
 报错类型：（会在执行 KVC 的地方报错）
 Terminating app due to uncaught exception 'NSUnknownKeyException', reason: '[<WJApp 0x8d66570> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key download.'
 （如果成员变量‘download’的命名跟plist文件中的key‘download’命名不一样，就会出现这样的结果）
 */

@interface WJApp : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *download;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, assign, getter = isDownloaded) BOOL downloaded;

+ (instancetype)appWithDic:(NSDictionary *)dic;
- (instancetype)initWithDic:(NSDictionary *)dic;

@end
