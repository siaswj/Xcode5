//
//  WJMessageFrame.h
//  QQ
//
//  Created by wangjie on 14-11-12.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WJTextFont [UIFont systemFontOfSize:14];  // 只要包含该头文件（接口文件）都可以用这个宏

// 消息按钮上文字的内边距
#define WJEdgeOfContent 20

@class WJMessage;

// 作用：设置cell内部子控件的frame和cell的行高; 这个模型包含三部分：
@interface WJMessageFrame : NSObject

// 1.cell内部子控件的frame
@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect textF;

// 2.cell的高度
@property (nonatomic, assign, readonly) CGFloat cellHeight;

// 3.要展示的模型数据
@property (nonatomic, strong) WJMessage *message;  //数据

@end
