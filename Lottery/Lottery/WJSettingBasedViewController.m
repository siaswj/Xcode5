//
//  WJSettingBasedViewController.m
//  Lottery
//
//  Created by wangjie on 15-2-2.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJSettingBasedViewController.h"
#import "WJSettingCell.h"
#import "WJSettingGroup.h"
#import "WJSettingItemArrow.h"
#import "WJSettingItemSwitch.h"

@interface WJSettingBasedViewController ()

@end


@implementation WJSettingBasedViewController

- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}

- (id)init
{
    if (self = [super init]) {
        self = [self initWithStyle:UITableViewStyleGrouped];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WJSettingGroup *group = self.data[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJSettingCell *cell = [WJSettingCell cellWithTableView:tableView];
    
    WJSettingGroup *group = self.data[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    WJSettingGroup *group = self.data[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    WJSettingGroup *group = self.data[section];
    return group.footer;
}

#pragma mark - tableView的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WJSettingGroup *group = self.data[indexPath.section];
    WJSettingItem *item = group.items[indexPath.row];
    
    
    if (item.option) {    // 如果option有值，就调用option存储的block代码块
        
        item.option();
        
    } else if ([item isKindOfClass:[WJSettingItemArrow class]]) {   // if yes, enter.
        
        // 把 item 强转成 WJSettingItemArrow类型。这句看不懂。。。。？？
        WJSettingItemArrow *arrowItem = (WJSettingItemArrow *)item;
        
        if (arrowItem.destVcClass == nil) return;
        
        UIViewController *vc = [[arrowItem.destVcClass alloc] init];
        vc.title = item.title;    // 目标控制器的标题＝点击的这行的标题
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
