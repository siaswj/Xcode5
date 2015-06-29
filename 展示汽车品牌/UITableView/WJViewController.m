//
//  WJViewController.m
//  UITableView
//
//  Created by wangjie on 14-10-28.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJViewController.h"
#import "WJCarGroup.h"
#import "WJCar.h"   // 谁需要用谁包含 就行了 (对外的接口)

@interface WJViewController () <UITableViewDataSource>
@property (nonatomic, strong) NSArray *groups;

@end


@implementation WJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

// 隐藏最上面的状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

// 加载plist数据
- (NSArray *)groups {
    
    if (_groups == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_total.plist" ofType:nil];
        NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *groupArray = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            WJCarGroup *group = [WJCarGroup groupWithDict:dic];
            [groupArray addObject:group];
        }
        _groups = groupArray;
        
    }
    return _groups;
}

//数据源方法
//
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"car";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    WJCarGroup *group = self.groups[indexPath.section];
    WJCar *car = group.cars[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:car.icon];
    cell.textLabel.text = car.name;
   
    return cell;
}

// section这一组有多少cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    WJCarGroup *group = self.groups[section];
    return group.cars.count;
}


// 有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.groups.count;
}

// 头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    WJCarGroup *group = self.groups[section];
    return group.title;
}

// 右边的索引提示栏
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.groups valueForKeyPath:@"title"];
}

@end
