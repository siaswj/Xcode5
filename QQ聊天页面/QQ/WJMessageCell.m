//
//  WJMessageCell.m
//  QQ
//
//  Created by wangjie on 14-11-12.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJMessageCell.h"
#import "WJMessageFrame.h"
#import "WJMessage.h"
#import "UIImage+WJExtension.h"   // UIImage类扩展的工具方法（工具类）：拉伸图片

// 这些属性(变量)都是cell内部的私有属性，所以要定义成私有的，不能被外界访问的
@interface WJMessageCell ()

@property (nonatomic, weak) UILabel *timeView;
@property (nonatomic, weak) UIButton *textView;
@property (nonatomic, weak) UIImageView *iconView;

@end

@implementation WJMessageCell

// 创建一个自定义的cell的对象
+ (instancetype)cellWithTableView:tableView
{
    NSString *ID = @"message";
    WJMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WJMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


// 这是自定义的cell：WJMessageCell，所以要重写cell的 构造方法 ，来设计自己需要的cell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 注意！
        // cell内部子控件的创建与初始化（这里要注意不能直接 self.timeView = [[UILable alloc] init]，因为 timeView 是弱指针 weak，一定要注意！所以要转换一下：1.先创建一个lable； 2.把这个lable添加到cell的contentView中；3.再把lable添加到 self.timeView 上。因为只要contentView在，lable就在！）
        
        // 1.时间
        UILabel *timeView = [[UILabel alloc] init];
        [self.contentView addSubview:timeView];
        timeView.textAlignment = NSTextAlignmentCenter;  // 文字居中
        timeView.font = [UIFont systemFontOfSize:13];
//        timeView.backgroundColor = [UIColor purpleColor];
        self.timeView = timeView;
        
        // 2.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        
        // 3.正文内容
        UIButton *textView = [[UIButton alloc] init];
        [self.contentView addSubview:textView];
        
        textView.titleLabel.numberOfLines = 0;   // 自动换行
        
        // 设置消息的字体大小
//        textView.titleLabel.font = [UIFont systemFontOfSize:14];  //也可以自定义一个宏
        textView.titleLabel.font = WJTextFont;
        
        // 注：利用背景色是一个很好的技巧。。。。。。。。。。。。。。。。。。。
        // 设置按钮的背景色
//        textView.backgroundColor = [UIColor purpleColor];
        // 设置按钮上label的背景色
//        textView.titleLabel.backgroundColor = [UIColor redColor];
        
        // 消息按钮的内边距（这样文字就就不会显示在四周所设置的内边距的范围上，还有超级猜图的设置内边距显示图片，显示图片、文字都是一样的）
        textView.contentEdgeInsets = UIEdgeInsetsMake(WJEdgeOfContent, WJEdgeOfContent, WJEdgeOfContent, WJEdgeOfContent);
        
        // 设置消息字体的颜色
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        self.textView = textView;
        
        // 创建cell的时候设置cell的背景色（也可以用RGB自定义颜色）
        self.backgroundColor = [UIColor clearColor];  // 没颜色，透明的
        
    }
    return self;
}


// 因为用到了<setMessageFrame:>方法而系统自动生成的<setMessageFrame:>又达不到我们想要的效果，所以需要重写messageframe的set方法。在这个方法中我们可以同时设置子控件的数据、frame(但是这个frame的值是无效值(空值)还是有效值，取决于我们是否在<setMessage:>中对子控件的frame属性进行赋值，这就是为什么要重写setMessage:方法，另见85行的注释。)
// 把 模型的数据 交给 cell的子控件的属性 －－ 使cell能显示数据
- (void)setMessageFrame:(WJMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    
    WJMessage *message = messageFrame.message;
    
    // 时间
    self.timeView.text = message.time;           // 数据
    self.timeView.frame = messageFrame.timeF;    // frame（用到了messageFrame.timeF，这是timeF的get方法，所以先要重写setMessage:方法来设置timeF的数据，然后才能使用timeF的get方法）
    
    // 头像
    NSString *icon = (message.type == WJMessageTypeMe) ? @"me" : @"other";   // 数据
    self.iconView.image = [UIImage imageNamed:icon];
    self.iconView.frame = messageFrame.iconF;     // frame
    
    // 内容
    [self.textView setTitle:message.text forState:UIControlStateNormal];   // 数据
    self.textView.frame = messageFrame.textF;      // frame
    
    // 设置消息的背景图片（background）
    if (message.type == WJMessageTypeMe) {    // 自己发送的
        
        UIImage *newNormal = [UIImage resizableImage:@"chat_send_nor"];
        [self.textView setBackgroundImage:newNormal forState:UIControlStateNormal];
        
    } else {     // 对方发送的
        
        UIImage *newNormal = [UIImage resizableImage:@"chat_recive_nor"];
        [self.textView setBackgroundImage:newNormal forState:UIControlStateNormal];
        
    }
}

@end
