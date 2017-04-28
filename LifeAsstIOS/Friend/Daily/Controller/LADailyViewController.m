//
//  LADailyViewController.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/28.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LADailyViewController.h"
#import "LADailyViewCell.h"

@interface LADailyViewController () <UITableViewDelegate,UITableViewDataSource>

@end

static NSString * const LADailyTableCellID = @"LADailyTableCell";

@implementation LADailyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupTableView];
}

#pragma mark - 基本设置
- (void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LADailyViewCell class]) bundle:nil] forCellReuseIdentifier:LADailyTableCellID];
    
    self.tableView.rowHeight = 90;
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
    LADailyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LADailyTableCellID];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}



@end
