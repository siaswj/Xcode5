//
//  WJView.m
//  01-Paint
//
//  Created by wangjie on 15-1-4.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJView.h"

@interface WJView ()
@property (nonatomic, strong) NSMutableArray *paths;  // 数组中存储的都是一条一条贝塞尔曲线
@end

@implementation WJView

- (void)clear
{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

- (void)back
{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}

- (NSMutableArray *)paths
{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获得当前触摸点
    UITouch *touch = [touches anyObject];
    CGPoint startP = [touch locationInView:touch.view];
    
    // 2.创建一个新的路径（对象-贝塞尔曲线）
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 2.1.设置path对象的属性
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5;
    
    // 3.设置路径的起点
    [path moveToPoint:startP];
    
    // 4.添加路径到数组中
    [self.paths addObject:path];
    
    // 5.重绘
    [self setNeedsDisplay];
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint midP = [touch locationInView:touch.view];
    
    [[self.paths lastObject] addLineToPoint:midP];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}


- (void)drawRect:(CGRect)rect
{
    for (UIBezierPath *path in self.paths) {
        [path stroke];
    }
}







- (void)testPath
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    CGContextMoveToPoint(ctx, 0, 0);
    //    CGContextAddLineToPoint(ctx, 100, 100);
    //    CGContextStrokePath(ctx);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 100, 100);
    CGContextAddPath(ctx, path);
    
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathMoveToPoint(path2, NULL, 250, 250);
    CGPathAddLineToPoint(path2, NULL, 110, 100);
    CGContextAddPath(ctx, path2);
    
    CGContextStrokePath(ctx);
    
    CGPathRelease(path);
}


@end
