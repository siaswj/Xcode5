//
//  WJFlagView.m
//  02pickerView选择国旗
//
//  Created by wangjie on 14-12-7.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import "WJFlagView.h"
#import "WJFlag.h"

@interface WJFlagView ()

@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *flagView;

@end



@implementation WJFlagView

+ (instancetype)flagViewWithReusingView:(UIView *)reusingView
{
    if (reusingView == nil) {
        return [[[NSBundle mainBundle] loadNibNamed:@"WJFlagView" owner:nil options:nil] lastObject];   // 加载xib只写文件名，不写后缀
    } else {
        return (WJFlagView *)reusingView;
    }
}

- (void)setFlag:(WJFlag *)flag
{
    _flag = flag;
    
    // 1.名字
    self.nameView.text = flag.name;
    
    // 2.图标
    self.flagView.image = [UIImage imageNamed:flag.icon];
    
}

+ (CGFloat)flagViewHeight
{
    return 44;
}

@end
