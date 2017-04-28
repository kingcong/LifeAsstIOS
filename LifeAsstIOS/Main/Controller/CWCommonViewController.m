//
//  CWCommonViewController.m
//  新浪微博架构搭建
//
//  Created by WangCong on 15/6/18.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import "CWCommonViewController.h"
#import "CWCommonGroup.h"
#import "CWCommonItem.h"
#import "CWCommonCell.h"

#define CWStatusCellMargin 10

@interface CWCommonViewController ()

@property (nonatomic,strong)NSMutableArray * groups;

@end

@implementation CWCommonViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置tableView属性
//    self.tableView.separatorStyle = UITableViewScrollPositionNone;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(CWStatusCellMargin - 35, 0, 0, 0);
}

#pragma mark - 实现数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CWCommonGroup * group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CWCommonCell * cell = [CWCommonCell cellWithTabelView:tableView];
    CWCommonGroup * group = self.groups[indexPath.section];
    CWCommonItem * item = group.items[indexPath.row];
    cell.item = item;
    return cell;
}

#pragma mark - 选中某一行Cell的跳转事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 1.取出这行对应的Item模型
    CWCommonGroup * group = self.groups[indexPath.section];
    CWCommonItem * item = group.items[indexPath.row];
    
    // 2.判断有没有需要跳转的控制器
    if (item.destVcClass) {
        UIViewController * destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 3.判断有没有执行的操作
    if (item.operation) {
        item.operation();
    }
}

#pragma mark - 设置头部和尾部
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    CWCommonGroup *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CWCommonGroup *group = self.groups[section];
    return group.header;
}

@end
