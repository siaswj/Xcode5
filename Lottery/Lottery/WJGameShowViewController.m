//
//  WJGameShowViewController.m
//  Lottery
//
//  Created by wangjie on 15-2-2.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJGameShowViewController.h"
#import "WJSettingGroup.h"
#import "WJSettingItemLabel.h"
#import "WJSettingItemSwitch.h"

@interface WJGameShowViewController ()

@end

@implementation WJGameShowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 0
    WJSettingGroup *group0 = [[WJSettingGroup alloc] init];
    
    WJSettingItem *gamesNoticed = [WJSettingItemSwitch itemWithTitle:@"提醒我关注的比赛"];
    group0.items = @[gamesNoticed];
    group0.footer = @"当我关注的比赛发生变化时，通过弹窗提醒我";
    
    [self.data addObject:group0];
    
    
    // 1
    WJSettingGroup *group1 = [[WJSettingGroup alloc] init];
    
    WJSettingItem *startTime = [WJSettingItemLabel itemWithTitle:@"开始时间"];
    group1.items = @[startTime];
    group1.header = @"在以下时间内提醒我";
    
    [self.data addObject:group1];
    
    
    // 2
    WJSettingGroup *group2 = [[WJSettingGroup alloc] init];
    
    WJSettingItem *endTime = [WJSettingItemLabel itemWithTitle:@"结束时间"];
    group2.items = @[endTime];
    
    [self.data addObject:group2];
    
}


@end
