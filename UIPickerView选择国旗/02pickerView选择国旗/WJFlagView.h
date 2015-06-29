//
//  WJFlagView.h
//  02pickerView选择国旗
//
//  Created by wangjie on 14-12-7.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJFlag;

@interface WJFlagView : UIView

@property (nonatomic, strong) WJFlag *flag;

+ (instancetype)flagViewWithReusingView:(UIView *)reusingView;
+ (CGFloat)flagViewHeight;

@end
