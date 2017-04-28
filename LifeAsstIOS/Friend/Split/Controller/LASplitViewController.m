//
//  LASplitViewController.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/28.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LASplitViewController.h"
#import "LASplitViewCell.h"

@interface LASplitViewController () <UITableViewDataSource,UITableViewDelegate>

@end

static NSString * const LASplitTableCellID = @"LASplitTableCell";

@implementation LASplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTableView];
}

#pragma mark - 基本设置
- (void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LASplitViewCell class]) bundle:nil] forCellReuseIdentifier:LASplitTableCellID];
    
    self.tableView.rowHeight = 120;
}

#pragma mark - tableView数据源方法和代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LASplitViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LASplitTableCellID];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
