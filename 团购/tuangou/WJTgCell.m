//
//  WJTgCell.m
//  tuangou
//
//  Created by wangjie on 14-10-30.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJTgCell.h"
#import "WJTg.h"

@interface WJTgCell ()

/** View中不对外的属性，私有属性－－－Xib内部的属性 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *priceView;
@property (weak, nonatomic) IBOutlet UILabel *buyCountView;

@end

@implementation WJTgCell

// “创建一个cell并返回给控制器使用（此时这个cell中仍无数据或者是旧数据）”－－－内存池中有合适的，就直接使用，没有就重新创建一个符合类型的
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString *ID = @"tg";
    WJTgCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        // 加载Xib的两种方式
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WJTgCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

// 重写 cell中tg属性的 setter 来加载数据
- (void)setTg:(WJTg *)tg {
    
    _tg = tg;  // ??这里不是特别明白。。。。
    
    // 把模型对象的数据加载到Xib内部的属性上 显示出来到屏幕上（M －> V , 由 C 来控制）
    self.iconView.image = [UIImage imageNamed:tg.icon];
    self.priceView.text = [NSString stringWithFormat:@"$%@", tg.price];
    self.titleView.text = tg.title;
    self.buyCountView.text = [NSString stringWithFormat:@"%@人已购买", tg.buyCount];
}

@end
