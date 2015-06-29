//
//  WJMessageCell.h
//  QQ
//
//  Created by wangjie on 14-11-12.
//  Copyright (c) 2014年 sias. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJMessageFrame;

@interface WJMessageCell : UITableViewCell

@property (nonatomic, strong) WJMessageFrame *messageFrame;

+ (instancetype)cellWithTableView:tableView;

@end
