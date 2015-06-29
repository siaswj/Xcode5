//
//  WJVideo.h
//  黑酷
//
//  Created by wangjie on 15-3-2.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJVideo : NSObject
/**
 *  视频ID
 */
@property (nonatomic, assign) int id;
/**
 *  视频时长
 */
@property (nonatomic, assign) int length;
/**
 *  视频截图
 */
@property (nonatomic, copy) NSString *image;
/**
 *  视频名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  视频的URL
 */
@property (nonatomic, copy) NSString *url;

+ (instancetype)videoWithDic:(NSDictionary *)dic;
@end
