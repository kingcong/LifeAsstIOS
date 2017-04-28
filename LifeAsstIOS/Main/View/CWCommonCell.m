//
//  CWCommonCell.m
//  新浪微博架构搭建
//
//  Created by WangCong on 15/6/18.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import "CWCommonCell.h"
#import "CWCommonItem.h"
#import "CWCommonArrowItem.h"
#import "CWCommonSwitchItem.h"
#import "CWCommonLabelItem.h"
#import "CWBadgeView.h"
@interface CWCommonCell ()

/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *rightArrow;
/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *rightSwitch;
/**
 *  标签
 */
@property (strong, nonatomic) UILabel *rightLabel;

/**
 *  提醒数字
 */
@property (strong, nonatomic) CWBadgeView *bageView;
@end

@implementation CWCommonCell

#pragma mark - 懒加载右边的view
- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        self.rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.textColor = [UIColor lightGrayColor];
        self.rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}
- (CWBadgeView *)bageView
{
    if (_bageView == nil) {
        self.bageView = [[CWBadgeView alloc] init];
    }
    return _bageView;
}

+ (instancetype)cellWithTabelView:(UITableView *)tableView
{
    static NSString * ID = @"cell";
    CWCommonCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[CWCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

#pragma mark - 调整子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
}

- (void)setItem:(CWCommonItem *)item
{
    _item = item;
    
    // 1.设置基本数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    // 2.设置右边的内容
    if (item.badgeValue) {
        self.bageView.badgeValue = item.badgeValue;
        self.accessoryView = self.bageView;
    }else if ([item isKindOfClass:[CWCommonArrowItem class]]) { // 箭头
        self.accessoryView = self.rightArrow;
    }else if ([item isKindOfClass:[CWCommonSwitchItem class]]){ // 开关
        self.accessoryView = self.rightSwitch;
    }else if ([item isKindOfClass:[CWCommonLabelItem class]]){ // label
        self.accessoryView = self.rightLabel;
    }else{ // 其他
        self.accessoryView = nil;
    }
}

@end
