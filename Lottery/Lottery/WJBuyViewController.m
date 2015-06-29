//
//  WJBuyViewController.m
//  Lottery
//
//  Created by wangjie on 15-1-31.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJBuyViewController.h"

@interface WJBuyViewController ()
- (IBAction)titleClick:(UIButton *)sender;
@property (nonatomic, assign) CGFloat angl;
@end


@implementation WJBuyViewController

- (IBAction)titleClick:(UIButton *)sender
{
    self.angl += M_PI;
    [UIView animateWithDuration:0.25 animations:^{
        sender.imageView.transform = CGAffineTransformMakeRotation(self.angl);
    }];
}

@end
