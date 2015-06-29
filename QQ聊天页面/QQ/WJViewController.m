//
//  WJViewController.m
//  QQ
//
//  Created by wangjie on 14-11-12.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJViewController.h"
#import "WJMessage.h"
#import "WJMessageFrame.h"
#import "WJMessageCell.h"



@interface WJViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *messageFrames;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputView;   //文本输入框

@end



@implementation WJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.view的设置
    // 去除tableView中cell与cell之间的分割线（tableView的一个属性）
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // tableView的背景颜色(注意：这是tableView的背景色，不是cell的！)
    self.tableView.backgroundColor = [UIColor grayColor];
    
    // 不允许cell被选中
    self.tableView.allowsSelection = NO;
    
    // 2.通知机制：处理键盘,监听键盘的通知
    // 2.1程序中唯一的通知中心对象：单粒对象(一个程序就一个)
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 3.文本输入框设置
    self.inputView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 0)];
    self.inputView.leftViewMode = UITextFieldViewModeAlways;
    
    // 设置控制器为文本框的代理
    self.inputView.delegate = self;
    
    
}

#pragma mark - UITextField的代理的方法
// 点击了键盘最右下角的return按钮，就会调用这个方法并拿到文本框中的文字
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    return YES;
}


// 删除监听者(有add就有remove)
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 监听者的方法
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
//    NSLog(@"%@",note.userInfo);
    /*
    note.userInfo中的信息：
    UIKeyboardAnimationCurveUserInfoKey = 7;   // 动画的执行速度、节奏
    UIKeyboardAnimationDurationUserInfoKey = "0.25";   // 键盘弹出/隐藏动画执行需要的时间
    UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {320, 216}}";
    UIKeyboardCenterBeginUserInfoKey = "NSPoint: {160, 588}";
    UIKeyboardCenterEndUserInfoKey = "NSPoint: {160, 372}";
    UIKeyboardFrameChangedByUserInteraction = 0;
     
    不管键盘是弹出还是隐藏都会调用该方法！！！
    弹出键盘
    键盘的frame（键盘的高是216）
    键盘刚出来那一刻的frame
    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 480}, {320, 216}}";
    键盘显示完毕后的frame
    UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 264}, {320, 216}}";
     
    隐藏键盘
    UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 264}, {320, 216}}";
    UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 480}, {320, 216}}";
     */
    
    // 让文本框、tableView和键盘一块平移
    // 利用transform来做，要巧妙利用键盘在两个状态下的frame数据
    // 1.取出note.userInfo中键盘最后状态下的frame信息
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 1.1.取出note.userInfo中键盘的动画信息（动画执行时间）
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.键盘此时的Y值 － 控制器的高度
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height;
    
    // 3.利用transform来使键盘和view一起平移（这一步执行动画）
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
    
    // 4.处理一些小细节(键盘弹出/隐藏时文本框和键盘之间的缝隙)
    self.view.window.backgroundColor = self.tableView.backgroundColor;
    
}




// 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}


// 懒加载－控制器获取数据
- (NSMutableArray *)messageFrames
{
    if (_messageFrames == nil) {
        
        // 1.取出数据－字典数组
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSDictionary *dicArray = [NSArray arrayWithContentsOfFile:path];
        
        // 2.字典转模型
        NSMutableArray *messageFrameArray = [NSMutableArray array];
        
        for (NSDictionary *dic in dicArray) {
            
            // message模型
            WJMessage *message = [WJMessage messageWithDic:dic];
            
            
            // 注意：这个要放在messageFrame模型前面，因为messageFrame模型调用了setMessage方法
            // 判断当前的message模型和上一个message模型的时间是否一样
            WJMessageFrame *lastMF = [messageFrameArray lastObject];
            WJMessage *lastM = lastMF.message;
            message.hideTime = [message.time isEqualToString:lastM.time];
            
            
            // messageFrame模型，并把message模型添加到messageFrame模型上
            WJMessageFrame *messageFrame = [[WJMessageFrame alloc] init];
            messageFrame.message = message;  // 调用了setMessage方法
            
            // 把转换好的模型对象添加到对象数组中
            // 此时messageFrame对象中，子控件的frame、cellHeight、message模型对象都已有值
            [messageFrameArray addObject:messageFrame];
        }
        
        // 3.把数据交给控制器
        _messageFrames = messageFrameArray;
        
    }
    return _messageFrames;
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建一个cell（一个模版）
    WJMessageCell *cell = [WJMessageCell cellWithTableView:tableView];
    
    // 2.给cell数据（给cell传一个messageFrame的模型数据，因为cell中有一个messageFrame模型属性）
    cell.messageFrame = self.messageFrames[indexPath.row];  // 用到了messageFrame的set方法
    
    // 3.返回一个带有数据的cell（这里有子控件的frame数据，有cellHeight数据，有message数据）
    return cell;
}


#pragma mark - UITableView的代理方法
// 设置行高 ----- UITableViewDelegate中的一个方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJMessageFrame *messageFrame = self.messageFrames[indexPath.row];
    
    return messageFrame.cellHeight;
}

// 当一开始拖拽tableView就会调用该方法。作用：滑动tableview让键盘退下去（用scrollView的一个代理方法）
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"-----------=--------");
    // 退出键盘
    [self.view endEditing:YES];
    /*  叫出键盘后，滑动tableView，调用该方法，停止编辑，返回键盘的frame以及其他相关信息
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 264}, {320, 216}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 480}, {320, 216}}";
     */
    
}

@end
