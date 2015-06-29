//
//  WJViewController.m
//  02pickerView选择国旗
//
//  Created by wangjie on 14-12-7.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJViewController.h"
#import "WJFlag.h"
#import "WJFlagView.h"

@interface WJViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *flags;

@end




@implementation WJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


// 懒加载（字典转模型）
- (NSArray *)flags
{
    if (_flags == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
        NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *flagArray = [NSMutableArray array];
        for (NSDictionary *dic in dicArray) {
            WJFlag *flag = [WJFlag flagWithDic:dic];
            [flagArray addObject:flag];
        }
        _flags = flagArray;
    }
    return _flags;
}

#pragma mark - 数据源方法－－－－（这两个方法要求必须实现）
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;    // 1列
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.flags.count;   // 多少行
}


#pragma mark - 代理方法
/**
 * 第component列第row行的view显示什么内容
 * 每当有一行内容出现在视野范围之内的时候，就会调用这个方法（调用频率非常高）
 */
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    // 1.创建一个view（注意：这个方法本身就有一个view参数，要利用这个参数来做到循环利用view！！！）
    WJFlagView *flagView = [WJFlagView flagViewWithReusingView:view];
    
    // 2.给view赋值（传递模型对象）
    flagView.flag = self.flags[row];
    
    // 3.返回这个view
    return flagView;
}

/**
 * 返回行的高度（代理方法）
 */
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return [WJFlagView flagViewHeight];   // 封装到View类中
}


@end
