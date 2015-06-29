//
//  WJOpenAwardViewController.m
//  Lottery
//
//  Created by wangjie on 15-2-2.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJOpenAwardViewController.h"
#import "WJSettingItemSwitch.h"
#import "WJSettingGroup.h"

@interface WJOpenAwardViewController ()

@end

@implementation WJOpenAwardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WJSettingGroup *group = [[WJSettingGroup alloc] init];
    
    WJSettingItem *doubleBall = [WJSettingItemSwitch itemWithTitle:@"双色球"];
    WJSettingItem *bigHappy = [WJSettingItemSwitch itemWithTitle:@"大乐透"];
    
    group.items = @[doubleBall, bigHappy];
    group.header = @"sdghfdhstrsfgjsaja";
    
    [self.data addObject:group];
}


@end
