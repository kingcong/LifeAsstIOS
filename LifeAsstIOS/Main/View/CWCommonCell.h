//
//  CWCommonCell.h
//  新浪微博架构搭建
//
//  Created by WangCong on 15/6/18.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CWCommonItem;

@interface CWCommonCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;

@property (nonatomic,strong)CWCommonItem * item;

@end
