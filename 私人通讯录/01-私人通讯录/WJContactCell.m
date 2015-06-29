//
//  WJContactCell.m
//  01-私人通讯录
//
//  Created by wangjie on 14-12-19.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJContactCell.h"
#import "WJContact.h"

@interface WJContactCell ()

@property (nonatomic, weak) UIView *divider;   //分割线

@end



@implementation WJContactCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"contact";
    // 先从缓存池中取，如果缓存池中没有可循环利用的cell，再去storyboard中找合适的cell
    // cell是从storyboard中创建的（但要注意：storyboard中的cell的类型一定丫记住修改为:WJContactCell）
    return [tableView dequeueReusableCellWithIdentifier:ID];
}

- (void)setContact:(WJContact *)contact
{
    _contact = contact;
    
    self.textLabel.text = contact.name;
    self.detailTextLabel.text = contact.phone;
}



/**
 *  如果cell是通过storyboard或xib创建的，则系统不会调用这个方法来初始化cell
 *  如果cell是通过代码创建的，才会调用这个方法来初始化cell
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


/**
 *  如果cell是通过storyboard或xib创建的，则系统会调用这个方法来初始化cell
 *  这个方法的作用类似于init方法
 */
- (void)awakeFromNib
{
    UIView *divider = [[UIView alloc] init];
    divider.backgroundColor = [UIColor blackColor];
    divider.alpha = 0.2;
    
    [self.contentView addSubview:divider];
    self.divider = divider;
    
}

/**
 *  只要cell及cell内部的子控件的frame发生改变，系统就会自动调用这个方法
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat dividerX = 0;
    CGFloat dividerH = 1;
    CGFloat dividerY = self.frame.size.height - dividerH;
    CGFloat dividerW = self.frame.size.width;
    self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
}

@end
