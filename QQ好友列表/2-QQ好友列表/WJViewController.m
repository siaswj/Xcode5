//
//  WJViewController.m
//  2-QQ好友列表
//
//  Created by wangjie on 14-12-1.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJViewController.h"
#import "WJFriendGroup.h"
#import "WJFriend.h"
#import "WJHeaderView.h"
#import "WJFriendCell.h"

@interface WJViewController () <WJHeaderViewDelegate>

@property (nonatomic, strong) NSArray *groups;

@end

@implementation WJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置cell的高度
    self.tableView.rowHeight = 50;
    
    // 2.设置section的头部的高度
    self.tableView.sectionHeaderHeight = 44;

}

// 懒加载_groups数据
- (NSArray *)groups
{
    if (_groups == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil];
        
        NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *groupArray = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            WJFriendGroup *group = [WJFriendGroup groupWithDic:dic];
            [groupArray addObject:group];
        }
        _groups = groupArray;
    
    }
    return _groups;
}

// 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - 数据源方法
// tableView有几组section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

// 每组section有几个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WJFriendGroup *group = self.groups[section];
    //section的状态如果显示的是开着的话，返回这个section中有几个cell，否则返回0
    return (group.isOpened ? group.friends.count : 0);
}

// 每个cell要展示的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    // 1.创建cell（1.暂时不封装; 2.系统自带的cell就可以满足需求）
//    static NSString *ID = @"friend";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
    
//    // 2.给cell设置数据
//    WJFriendGroup *group = self.groups[indexPath.section];
//    WJFriend *friend = group.friends[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:friend.icon];
//    cell.textLabel.text = friend.name;
//    cell.detailTextLabel.text = friend.intro;
    
    
    // 1.创建cell（封装）
    WJFriendCell *cell = [WJFriendCell cellWithtableView:tableView];
    
    // 2.给cell设置数据
    WJFriendGroup *group = self.groups[indexPath.section];
    WJFriend *friend = group.friends[indexPath.row];
    cell.friendData = friend;    // setFriendData:方法
    
    // 3.返回cell
    return cell;
}

// 返回section的头部的标题－（这个方法的作用效果和WJHeaderView.m文件中setGroup:方法中’设置按钮的文字标题‘作用效果相同）
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    WJFriendGroup *group = self.groups[section];
//    return group.name;
//}

// 返回每个section要显示的的头部header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 1.创建一个头部控件
    WJHeaderView *header = [WJHeaderView headerViewWithTableView:tableView];
    
    // 2.给这个头部内部的子控件赋值（但是子控件的属性在.m文件中，所以可以传递模型数据）
    header.group = self.groups[section];
    
    // 3.设置header(headerView)的代理为控制器
    header.delegate = self;
    
    return header;
}


#pragma mark - headerView的代理方法
// 点击了headerView调用
- (void)headerViewDidClickedNameView:(WJHeaderView *)headerView
{
    // 刷新表格的数据
    [self.tableView reloadData];
}

@end
