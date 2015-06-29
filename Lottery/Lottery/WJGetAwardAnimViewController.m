//
//  WJGetAwardAnimViewController.m
//  Lottery
//
//  Created by wangjie on 15-2-2.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJGetAwardAnimViewController.h"
#import "WJSettingGroup.h"
#import "WJSettingItemSwitch.h"

@interface WJGetAwardAnimViewController ()

@end

@implementation WJGetAwardAnimViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WJSettingGroup *group = [[WJSettingGroup alloc] init];
    
    WJSettingItem *awarded = [WJSettingItemSwitch itemWithTitle:@"中奖动画"];
    group.items = @[awarded];
    group.header = @"当你有新的中奖订单，启动程序时通过动画提醒你。为避免过于频繁，高频彩不会提示";
    
    [self.data addObject:group];
}

@end
