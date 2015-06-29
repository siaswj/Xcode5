//
//  WJViewController.m
//  01-PickerView点菜系统
//
//  Created by wangjie on 14-12-7.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJViewController.h"

@interface WJViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *foods;

@property (weak, nonatomic) IBOutlet UILabel *zhucaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *shuiguoLabel;
@property (weak, nonatomic) IBOutlet UILabel *yinliaoLabel;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
- (IBAction)suiji;

@end




@implementation WJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 程序一开始启动时显示每列的第0行
    for (int component = 0; component < self.foods.count; component++) {
        [self pickerView:nil didSelectRow:0 inComponent:component];
    }
    
}


// 懒加载(这个不是字典转模型)
- (NSArray *)foods
{
    if (_foods == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"foods.plist" ofType:nil];
        
        NSArray *foodArray = [NSArray arrayWithContentsOfFile:path];
        
        _foods = foodArray;
        
    }
    return _foods;
}

#pragma mark - 数据源方法
// 一共有多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.foods.count;
}

// 每列显示多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *subfoods = self.foods[component];
    return subfoods.count;
}

#pragma mark - 代理方法
// 第component列第row行要显示内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.foods[component][row];
}

// 当选中某列某行时，就会调用这个方法（所以可以在这个方法里做一些事）
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {   // 水果
        self.shuiguoLabel.text = self.foods[component][row];
    } else if (component == 1){  // 主菜
        self.zhucaiLabel.text = self.foods[component][row];
    } else {   // 饮料
        self.yinliaoLabel.text = self.foods[component][row];
    }
}








// 对于每一列都产生一个随机数，根据这个随机数来确定每一列要显示的那一行食物名称
- (IBAction)suiji
{
    for (int component = 0; component < self.foods.count; component++) {
        
        // 第component列数组的总长度
        // 这里不能使用点语法（不过点语法的本质还是方法调用）
        int count = [self.foods[component] count];
        
        
        // 调用函数产生一个随机数(这个随机数对count求余，保证最后结果在数组长度范围之内)
        // 保证每次随机的都不一样
        int oldRow = [self.pickerView selectedRowInComponent:component];
        int row = oldRow;
        while (row == oldRow) {
            row = arc4random()%count;
//            arc4random(count); 这样也可以，这是c语言的函数调用，和上面的只不过是形式不同
        }
        
        
        // 让pickerView主动选中第count列的第row行，并且动画
        [self.pickerView selectRow:row inComponent:component animated:YES];
        
        
        // 显示所选中的文字到label上
        [self pickerView:nil didSelectRow:row inComponent:component];
    }
}
@end
