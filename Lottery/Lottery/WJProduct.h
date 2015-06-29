//
//  WJProduct.h
//  Lottery
//
//  Created by wangjie on 15-2-2.
//  Copyright (c) 2015年 sias. All rights reserved.
//

/*
"title": "网易电影票",
"id": "com.netease.movie",
"url": "http://itunes.apple.com/app/id583784224?mt=8",
"icon": "movie@2x.png",
"customUrl": "movieticket163"
*/


#import <Foundation/Foundation.h>

@interface WJProduct : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)productWithDic:(NSDictionary *)dic;

@end
