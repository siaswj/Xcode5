//
//  WJView.m
//  02-小黄人
//
//  Created by wangjie on 14-12-29.
//  Copyright (c) 2014年 sias. All rights reserved.
//


/**
 *  图形上下文栈（ctx为图形上下文）
 *  1.上下文是唯一的（正在使用的上下文是唯一的）
 *  2.CGContextSaveGState(ctx) : 将内存中的ctx拷贝一份放到栈中保存起来
 *  3.CGContextRestoreGState(ctx) : 将栈顶的上下文出栈，替换当前的正在使用的上下文
 */


#import "WJView.h"

#define WJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define WJTopArcX rect.size.width * 0.5
#define WJTopArcY 130
#define WJTopArcRadius 60

@implementation WJView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



/**
 *  本程序中，控制器的view就是WJView，所以WJView的rect就是整个屏幕(view)的rect
 */
- (void)drawRect:(CGRect)rect
{
    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.脸轮廓
    drawFace(ctx, rect);
    
    // 3.嘴巴
    drawSmile(ctx, rect);
    
    // 4.眼睛和眼镜框
    drawEye(ctx, rect);
    
    // 5.头发
    drawhair(ctx, rect);
}


/**
 *  头发
 */
void drawhair(CGContextRef ctx, CGRect rect)
{
    // 第三根
    CGContextMoveToPoint(ctx, WJTopArcX, WJTopArcY - WJTopArcRadius + 7);
    CGContextAddLineToPoint(ctx, WJTopArcX, WJTopArcY - WJTopArcRadius - 40);
    CGContextSetLineWidth(ctx, 2);
    CGContextStrokePath(ctx);
    
    // 第二根
    CGContextMoveToPoint(ctx, WJTopArcX - 8, WJTopArcY - WJTopArcRadius + 7);
    CGContextAddLineToPoint(ctx, WJTopArcX - 15, WJTopArcY - WJTopArcRadius - 30 - 8);
    CGContextSetLineWidth(ctx, 2);
    CGContextStrokePath(ctx);
    
    // 第一根
    CGContextMoveToPoint(ctx, WJTopArcX - 16, WJTopArcY - WJTopArcRadius + 8);
    CGContextAddLineToPoint(ctx, WJTopArcX - 30, WJTopArcY - WJTopArcRadius - 30 - 6);
    CGContextSetLineWidth(ctx, 2);
    CGContextStrokePath(ctx);
    
    // 第四根
    CGContextMoveToPoint(ctx, WJTopArcX + 9, WJTopArcY - WJTopArcRadius + 7);
    CGContextAddLineToPoint(ctx, WJTopArcX + 15, WJTopArcY - WJTopArcRadius - 40);
    CGContextSetLineWidth(ctx, 2);
    CGContextStrokePath(ctx);
    
    // 第五根
    CGContextMoveToPoint(ctx, WJTopArcX + 16, WJTopArcY - WJTopArcRadius + 7);
    CGContextAddLineToPoint(ctx, WJTopArcX + 25, WJTopArcY - WJTopArcRadius - 40);
    CGContextSetLineWidth(ctx, 2);
    CGContextStrokePath(ctx);
}


/**
 *  眼镜和眼镜框
 */
void drawEye(CGContextRef ctx, CGRect rect)
{
    // 眼镜框的腿
    CGContextMoveToPoint(ctx, WJTopArcX - WJTopArcRadius - 3, WJTopArcY);
    CGContextAddLineToPoint(ctx, WJTopArcX + WJTopArcRadius + 3, WJTopArcY);
    CGContextSetLineWidth(ctx, 15);
    CGContextStrokePath(ctx);
    
    // 眼镜框
    CGContextAddArc(ctx, WJTopArcX * 0.85, WJTopArcY, WJTopArcRadius * 0.4, 0, M_PI * 2, 0);  // 右眼
    CGContextAddArc(ctx, WJTopArcX * 1.15, WJTopArcY, WJTopArcRadius * 0.4, 0, M_PI * 2, 0);  // 左眼
    CGContextSetLineWidth(ctx, 10);
    [WJColor(61, 62, 66) set];
    CGContextFillPath(ctx);
    
    // 眼睛
    CGContextAddArc(ctx, WJTopArcX * 0.85, WJTopArcY, WJTopArcRadius * 0.26, 0, M_PI * 2, 0);  // 右眼
    CGContextAddArc(ctx, WJTopArcX * 1.15, WJTopArcY, WJTopArcRadius * 0.26, 0, M_PI * 2, 0);  // 左眼
    [[UIColor whiteColor] set];
    CGContextFillPath(ctx);
    
    // 点睛
    CGContextAddArc(ctx, WJTopArcX * 0.85 * 1.02, WJTopArcY, WJTopArcRadius * 0.26 * 0.6, 0, M_PI * 2, 0); //右眼
    CGContextAddArc(ctx, WJTopArcX * 1.15 * 0.98, WJTopArcY, WJTopArcRadius * 0.26 * 0.6, 0, M_PI * 2, 0); //左眼
    [WJColor(66, 21, 10) set];
    CGContextFillPath(ctx);
    
    // 黑点
    CGContextAddArc(ctx, WJTopArcX * 0.85 * 1.02, WJTopArcY, WJTopArcRadius * 0.26 * 0.6 * 0.4, 0, M_PI * 2, 0);
    CGContextAddArc(ctx, WJTopArcX * 1.15 * 0.98, WJTopArcY, WJTopArcRadius * 0.26 * 0.6 * 0.4, 0, M_PI * 2, 0);
    [[UIColor blackColor] set];
    CGContextFillPath(ctx);
}


/**
 *  嘴巴
 *  贝塞尔曲线
 */
void drawSmile(CGContextRef ctx, CGRect rect)
{
    // 中间的控制点(嘴的位置)
    CGFloat controlX = 160;
    CGFloat controlY = 250;
    
    // 当前点
    CGFloat marginX = 30;
    CGFloat marginY = 20;
    CGFloat currentX = controlX - marginX;
    CGFloat currentY = controlY - marginY;
    CGContextMoveToPoint(ctx, currentX, currentY);
    
    // 结束点
    CGFloat endX = controlX + marginX;
    CGFloat endY = currentY;
    
    // 调用该方法画贝塞尔曲线
    CGContextAddQuadCurveToPoint(ctx, controlX, controlY, endX, endY);
    
    // 设置颜色
    [[UIColor blackColor] set];
    
    // 渲染
    CGContextStrokePath(ctx);
    
}


/**
 *  脸轮廓
 */
void drawFace(CGContextRef ctx, CGRect rect)
{
    // 头顶圆弧
    CGFloat topArcX = WJTopArcX;
    CGFloat topArcY = WJTopArcY;
    CGFloat topArcRadius = WJTopArcRadius;
    CGContextAddArc(ctx, topArcX, topArcY, topArcRadius, 0, M_PI, 1);
    
    // 两边脸颊
    CGFloat midX = topArcX - topArcRadius;
    CGFloat midH = 120;  // 脸长120
    CGFloat midY = topArcY + midH;
    CGContextAddLineToPoint(ctx, midX, midY);
    
    // 底部下巴
    CGFloat bottomArcX = topArcX;
    CGFloat bottomArcY = topArcY + midH;
    CGFloat bottomArcRadius = topArcRadius;
    CGContextAddArc(ctx, bottomArcX, bottomArcY, bottomArcRadius, M_PI, 0, 1);
    
    // 合并路径
    CGContextClosePath(ctx);
    
    // 设置脸的颜色
    [WJColor(252, 218, 0) set];
    
    // 渲染
    CGContextFillPath(ctx);
}
@end
