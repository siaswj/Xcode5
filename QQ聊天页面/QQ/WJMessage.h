//
//  WJMessage.h
//  QQ
//
//  Created by wangjie on 14-11-12.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    WJMessageTypeMe = 0,    //自己发的
    WJMessageTypeOther = 1  //对方发的
} WJMessageType;


@interface WJMessage : NSObject

@property (nonatomic, copy) NSString *text;   //聊天内容
@property (nonatomic, copy) NSString *time;   // 消息发送时间
@property (nonatomic, assign) WJMessageType type;  // 发送者

@property (nonatomic, assign) BOOL hideTime;   // 隐藏相同时间

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)messageWithDic:(NSDictionary *)dic;

@end
