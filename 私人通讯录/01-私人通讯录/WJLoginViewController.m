//
//  WJLoginViewController.m
//  01-私人通讯录
//
//  Created by wangjie on 14-12-14.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJLoginViewController.h"
#import "MBProgressHUD+MJ.h"  // 第三方类库，效果：HUD，指示器

#define WJAccountKey @"accoount"
#define WJPasswordKey @"password"
#define WJRememberPasswordKey @"rememberPassword"
#define WJAutoLoginKey @"autoLogin"

@interface WJLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;  // 账号文本框
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;   // 密码文本框
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;   // 登录按钮

@property (weak, nonatomic) IBOutlet UISwitch *rmbPswSwitch; // “记住密码”的属性
- (IBAction)rmbPswChange;     // “记住密码”开关被点击
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;  // “自动登录”的属性
- (IBAction)autoLoginChange;    // “自动登录”开关被点击

- (IBAction)login;  // 登录按钮被点击

@end

@implementation WJLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
/********* 监听有3种方法：1.addTarge； 2.代理； 3.通知 (监听文本框是否有文字用第3种：通知) */
    
    // 拿到通知中心，这个 控制器 监听到 self.accountTextField 的UITextFieldTextDidChangeNotification 通知时，调用 textChanged 方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.accountTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
    
    
    // 读取上次设置的配置信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.accountTextField.text = [defaults objectForKey:WJAccountKey];  // 是否记住账户名
    self.rmbPswSwitch.on = [defaults boolForKey:WJRememberPasswordKey]; // 是否记住密码
    self.autoLoginSwitch.on = [defaults boolForKey:WJAutoLoginKey];  // 是否自动登录
    
    // 判断密码设置
    if (self.rmbPswSwitch.isOn) {
        self.passwordTextField.text = [defaults objectForKey:WJPasswordKey]; // 把密码赋给密码框
        self.loginBtn.enabled = YES;  // 若记住密码&&不自动登录，则登录按钮默认可点
    }
    
    // 判断自动登录设置
    if (self.autoLoginSwitch.isOn) {
        [self login];  
    }
    
}

// 通知中心有add就要有remove
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




// 如果两个文本框的文字都有了的话，就改变登录按钮的属性
- (void)textChanged
{
//    if (self.accountTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
//        self.loginBtn.enabled = YES;
//    } else {
//        self.loginBtn.enabled = NO;
//    }
    
    self.loginBtn.enabled = (self.accountTextField.text.length && self.passwordTextField.text.length);
}





// 只要“记住密码”开关的状态发生改变，就会调用这个方法
- (IBAction)rmbPswChange {
    
    if (self.rmbPswSwitch.isOn == NO) {  // “记住密码“没有开
//        self.autoLoginSwitch.on = NO;
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
    
}

// 只要“自动登录”开关的状态发生改变，就会调用这个方法
- (IBAction)autoLoginChange {
    
    if (self.autoLoginSwitch.isOn == YES) {  // “自动登录”开着
//        self.rmbPswSwitch.on = YES;
        [self.rmbPswSwitch setOn:YES animated:YES];
    }
}




// 判断账号密码是否正确
- (IBAction)login {
    
    // 输入密码后退出键盘
    [self.passwordTextField endEditing:YES];
    [self.accountTextField endEditing:YES];
    
    // 正常下要发送网络数据给服务器判断，这里设置一组假数据：wj，123
    
    // 判断账号
    if (![self.accountTextField.text isEqualToString:@"wj"]) {
        [MBProgressHUD showError:@"账号不存在"];
        return;
    }
    
    // 判断密码
    if (![self.passwordTextField.text isEqualToString:@"123"]) {
        [MBProgressHUD showError:@"密码错误"];
        return;
    }
    
    // 如果账号密码都正确，则可以来到这里（只要有一个不正确，则不会来到这里）
    // 添加一块蒙板（阻止用户在这期间点击屏幕）
    [MBProgressHUD showMessage:@"主人，小的正在帮您拼命加载中"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2.0s后移除蒙板
        [MBProgressHUD hideHUD];
        // 跳转－－手动执行segue完成跳转
        [self performSegueWithIdentifier:@"loginToContact" sender:nil];
        
        // 存储数据
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.accountTextField.text forKey:WJAccountKey];
        [defaults setObject:self.passwordTextField.text forKey:WJPasswordKey];
        [defaults setBool:self.rmbPswSwitch.isOn forKey:WJRememberPasswordKey];
        [defaults setBool:self.autoLoginSwitch.isOn forKey:WJAutoLoginKey];
        [defaults synchronize];  // 要注意同步！！
    });
    
}



// 执行segue后，跳转之前会调用这个方法，所以这个方法用来在控制器之间传递数据
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // 1.取得目标控制器
    UIViewController *aimVc = [segue destinationViewController];
    
    // 2.传递数据
    aimVc.title = [NSString stringWithFormat:@"%@的联系人列表", self.accountTextField.text];
//    aimVc.navigationController.title = [NSString stringWithFormat:@"%@的联系人列表", self.accountTextField.text];

}




@end
