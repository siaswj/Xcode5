//
//  WJPushViewController.m
//  Lottery
//
//  Created by wangjie on 15-2-2.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJPushViewController.h"
#import "WJSettingGroup.h"
#import "WJSettingItemArrow.h"
#import "WJSettingItemSwitch.h"
#import "WJSettingCell.h"
#import "WJTestViewController.h"  // 测试控制器
#import "WJOpenAwardViewController.h"
#import "WJGetAwardAnimViewController.h"
#import "WJGameShowViewController.h"


@interface WJPushViewController ()

@end


@implementation WJPushViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    WJSettingGroup *group = [[WJSettingGroup alloc] init];
    
    WJSettingItem *push = [WJSettingItemArrow itemWithTitle:@"开奖推送设置" destVcClass:[WJOpenAwardViewController class]];
    WJSettingItem *anima = [WJSettingItemArrow itemWithTitle:@"中奖动画" destVcClass:[WJGetAwardAnimViewController class]];
    WJSettingItem *game = [WJSettingItemArrow itemWithTitle:@"比赛直播提醒" destVcClass:[WJGameShowViewController class]];
    WJSettingItem *buyLottery = [WJSettingItemArrow itemWithTitle:@"定时购彩提醒" destVcClass:[WJTestViewController class]];
    
    group.items = @[push, anima, game, buyLottery];
    
    [self.data addObject:group];
}


@end
