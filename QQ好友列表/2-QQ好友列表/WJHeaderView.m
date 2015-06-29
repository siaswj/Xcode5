//
//  WJHeaderView.m
//  2-QQ好友列表
//
//  Created by wangjie on 14-12-3.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJHeaderView.h"
#import "WJFriendGroup.h"

@interface WJHeaderView ()

@property (nonatomic, weak) UILabel *countView;
@property (nonatomic, weak) UIButton *nameView;

@end

@implementation WJHeaderView

// 创建一个headerView
+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    WJHeaderView *header = [tableView dequeueReusableCellWithIdentifier:ID];
    if (header == nil) {
        header = [[WJHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return header;
}

// 这个初始化方法中，WJHeaderView的frame\bounds没有值
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        // 添加子控件
        // 1.添加button
        UIButton *nameView = [UIButton buttonWithType:UIButtonTypeCustom];
//        nameView.backgroundColor = [UIColor redColor];
        
        // 设置按钮的背景图片
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [nameView setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        
        // 设置按钮内部左边的箭头图片
        [nameView setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        
        // 设置按钮文字的状态、颜色
        [nameView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 设置按钮的内容左对齐
        nameView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        // 设置按钮的内边距
        nameView.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);   //标题的内边距
        nameView.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0); //内容的内边距
        
        // 添加headerView点击事件的监听者、监听到点击后所做的动作（单击事件）
        [nameView addTarget:self action:@selector(nameViewClicked) forControlEvents:UIControlEventTouchUpInside];
        
        // 设置按钮内部的imageView的内容模式为居中
        nameView.imageView.contentMode = UIViewContentModeCenter;
        
        // 设置小三角超出边框的内容不需要裁剪（默认是裁剪）(主要是考虑当小三角旋转后的变化)
        nameView.imageView.clipsToBounds = NO;
        
        [self.contentView addSubview:nameView];
        self.nameView = nameView;
        
        
        // 2.添加label
        UILabel *countView = [[UILabel alloc] init];
//        countView.backgroundColor = [UIColor blueColor];
        
        // 右对齐
        countView.textAlignment = NSTextAlignmentRight;
        
        // 文字颜色
        countView.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:countView];
        self.countView = countView;
        
    }
    return self;
}

//headerView监听到自己被点击后做出的动作
- (void)nameViewClicked
{
    // 状态取反
    self.group.opened = !(self.group.isOpened);
    
    // 刷新表格(界面)（控制器负责刷新，所以控制器要成为headerView的代理，控制器要实现headrView的代理方法）
    // 首先判断代理(控制器)是否已经实现headerView的代理方法－headerViewDidClickedNameView:
    // 判断代理的方法是否已经实现,用respondsToSelector:
    if ([self.delegate respondsToSelector:@selector(headerViewDidClickedNameView:)]) {
        [self.delegate headerViewDidClickedNameView:self];   // self就是headerView
    }
}

// 当一个控件的frame发生改变时就会调用这个方法，所以一般在这里设置子控件的frame(布局内部的子控件)
- (void)layoutSubviews
{
    // 0.调用super的方法
#warning 这里一定要调用super的方法
    [super layoutSubviews];
    
    // 1.设置nameView(也就是button)的frame
    self.nameView.frame = self.bounds;
    
    // 2.设置countView(也就是label)的frame
    CGFloat countViewY = 0;
    CGFloat countViewW = 100;
    CGFloat countViewH = self.frame.size.height;
    CGFloat countViewX = self.frame.size.width - 10 - countViewW;
    self.countView.frame = CGRectMake(countViewX, countViewY, countViewW, countViewH);
    
}

// 重写group的set方法
- (void)setGroup:(WJFriendGroup *)group
{
    _group = group;
    
    // 设置按钮的文字标题
    [self.nameView setTitle:group.name forState:UIControlStateNormal];
    
    // 设置label的在线数
    self.countView.text = [NSString stringWithFormat:@"%d/%d", group.online, group.friends.count];
    
}

// 当一个控件添加到父控件的时候就会调用该方法,作用：利用transform控制headerView上的小三角旋转
- (void)didMoveToSuperview
{
    if (self.group.opened) {
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        self.nameView.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

@end
