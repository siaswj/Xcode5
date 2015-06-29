//
//  WJSettingCell.m
//  Lottery
//
//  Created by wangjie on 15-2-1.
//  Copyright (c) 2015年 sias. All rights reserved.
//

#import "WJSettingCell.h"
#import "WJSettingItem.h"
#import "WJSettingItemArrow.h"
#import "WJSettingItemSwitch.h"
#import "WJSettingItemLabel.h"

@interface WJSettingCell ()
/**
 *  cell右边的箭头。这个需要用strong来修饰，如果用weak，那懒加载一结束，这个控件就销毁了。
 */
@property (nonatomic, strong) UIImageView *arrowView;
/**
 *  cell右边的开关
 */
@property (nonatomic, strong) UISwitch *switchView;
/**
 *  cell上的label
 */
@property (nonatomic, strong) UILabel *labelView;
@end


@implementation WJSettingCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"setting";
    WJSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[WJSettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    return _arrowView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        
        // 监听开关的点击
        [_switchView addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventValueChanged];
        
    }
    return _switchView;
}

/**
 *  在这里存储开关的状态
 */
- (void)valueChange
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.switchView.isOn forKey:self.item.title];
    [defaults synchronize];      // 立即更新
}

- (UILabel *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.bounds = CGRectMake(0, 0, 100, 30);
        _labelView.backgroundColor = [UIColor redColor];
    }
    return _labelView;
}

- (void)setItem:(WJSettingItem *)item
{
    _item = item;
    
    
    // 设置cell的数据
    if (item.icon) {
        self.imageView.image = [UIImage imageNamed:item.icon];
    }
    self.textLabel.text = item.title;
    
    
    
    // cell的样式
    if ([item isKindOfClass:[WJSettingItemArrow class]]) {
        
        // self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
        self.accessoryView = self.arrowView;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
    } else if ([item isKindOfClass:[WJSettingItemSwitch class]]) {
        
        // self.accessoryView = [[UISwitch alloc] init];
        // 这个方法调用频率很高，并且右边的控件都是一样的，所以没有必要调一次创建一个调一次创建一个，最好是有个成员变量来记录一下创建的控件对象(创建一个就够了)，这样性能比较好。
        // 这里要主动的调用switchView的get方法，不能用_switchView，不然不会调用switchView的get方法，也就没法创建控件对象
        self.accessoryView = self.switchView;
        
        // 读取开关保存的状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.switchView.on = [defaults boolForKey:self.item.title];
        
        // 选中看不到变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    } else if ([item isKindOfClass:[WJSettingItemLabel class]]) {
        
        self.accessoryView = self.labelView;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
    } else {
        
        self.accessoryView = nil;  // 如果传入的item是WJSettingItem类型。这点很重要！
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}
@end
