//
//  WJMessageFrame.m
//  QQ
//
//  Created by wangjie on 14-11-12.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJMessageFrame.h"
#import "WJMessage.h"
#import "NSString+WJExtension.h"     // NSString类的方法的扩展：计算字体的size

@implementation WJMessageFrame

// 为什么重写setMessage:方法，详见WJMessageCell.m文件中的第75行
- (void)setMessage:(WJMessage *)message
{
    // 0.模型
    _message = message;
    
    CGFloat margin = 10;   // 间距
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;  // 屏幕宽度
    
    // 1.时间
    if (!message.hideTime) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = screenW;
        CGFloat timeH = 40;
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    // 2.头像
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    CGFloat iconY = CGRectGetMaxY(_timeF) + margin;
    CGFloat iconX;
    if (message.type == WJMessageTypeMe) {
        iconX = screenW - margin - iconW;
    } else {
        iconX = margin;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 3.正文内容
    CGFloat textX;
    CGFloat textY = iconY;
    
    // 消息上的文字的大小
//    UIFont *textFont = [UIFont systemFontOfSize:14];
    UIFont *textFont = WJTextFont;
    
    // 消息上的文字的宽和高
    CGSize textMaxSize = CGSizeMake(200, MAXFLOAT);
    
    // 按钮上文字的size
    CGSize textSize = [message.text sizeWithFont:textFont maxSize:textMaxSize];
    
    // 按钮的size
    CGSize textBtnSize = CGSizeMake(textSize.width + WJEdgeOfContent * 2, textSize.height + WJEdgeOfContent * 2);
    
    if (message.type == WJMessageTypeMe) {
        textX = iconX - margin - textBtnSize.width;
    } else {
        textX = CGRectGetMaxX(_iconF) + margin;
    }
//    _textF = CGRectMake(textX, textY, textBtnSize.width, textBtnSize.height);
    _textF = (CGRect){{textX, textY}, textBtnSize};
    
    // cell的高度
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    _cellHeight = MAX(textMaxY, iconMaxY) + margin;
    
}

@end
