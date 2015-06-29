//
//  WJSettingViewController.m
//  Lottery
//
//  Created by wangjie on 15-2-1.
//  Copyright (c) 2015年 sias. All rights reserved.
//  设置控制器

#import "WJSettingViewController.h"
#import "WJSettingGroup.h"
#import "WJSettingItemArrow.h"
#import "WJSettingItemSwitch.h"
#import "WJSettingCell.h"
#import "WJTestViewController.h"
#import "MBProgressHUD+MJ.h"
#import "WJProductViewController.h"
#import "WJPushViewController.h"
#import "WJHelpViewController.h"

@interface WJSettingViewController ()

@end


@implementation WJSettingViewController



- (void)groupData0
{
    WJSettingGroup *group = [[WJSettingGroup alloc] init];
    
    // 箭头类型的item
    WJSettingItem *push = [WJSettingItemArrow itemWithIcon:@"MorePush" title:@"推送提醒" destVcClass:[WJPushViewController class]];
    
    // 开关类型的item
    WJSettingItem *handShake = [WJSettingItemSwitch itemWithIcon:@"handShake" title:@"摇一摇机选"];
    WJSettingItem *sound = [WJSettingItemSwitch itemWithIcon:@"sound_Effect" title:@"声音效果"];
    
    group.items = @[push, handShake, sound];
    
//    [_data addObject:group0];
    [self.data addObject:group];
}

- (void)groupData1
{
    WJSettingGroup *group = [[WJSettingGroup alloc] init];
    
    WJSettingItem *update = [WJSettingItemArrow itemWithIcon:@"MoreUpdate" title:@"检查新版本" destVcClass:[WJTestViewController class]];

#warning block的循环引用问题。看self是否调用dealloc就可以知道结果了
    // __unsafe_unretained typeof(self) selfVc = self;
    __weak typeof(self) selfVc = self;     // 解决block循环引用控制器
    update.option = ^{
        // [self showAlert];
        [selfVc showHUD];
    };
    
    WJSettingItem *help = [WJSettingItemArrow itemWithIcon:@"MoreHelp" title:@"帮助" destVcClass:[WJHelpViewController class]];
    WJSettingItem *share = [WJSettingItemArrow itemWithIcon:@"MoreShare" title:@"分享" destVcClass:[WJTestViewController class]];
    WJSettingItem *message = [WJSettingItemArrow itemWithIcon:@"MoreMessage" title:@"查看消息" destVcClass:[WJTestViewController class]];
    WJSettingItem *netease = [WJSettingItemArrow itemWithIcon:@"MoreNetease" title:@"产品推荐" destVcClass:[WJProductViewController class]];
    WJSettingItem *about = [WJSettingItemArrow itemWithIcon:@"MoreAbout" title:@"关于" destVcClass:[WJTestViewController class]];
    
    group.items = @[update, help, share, message, netease, about];
//    [_data addObject:group];
    [self.data addObject:group];
}

- (void)showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"当前已是最新版本" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"立即更新", nil];
    [alert show];
}

- (void)showHUD
{
    [MBProgressHUD showMessage:@"正在检查中...."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"当前已是最新版本"];
        
    });
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [self groupData0];
    [self groupData1];
}



- (void)dealloc
{
    NSLog(@"-----------dealloc");
}



@end
