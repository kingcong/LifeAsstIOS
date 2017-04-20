//
//  LAHomeViewController.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/3/1.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LAHomeViewController.h"
#import "LAHomeHeaderView.h"
#import "LAHomeTableCell.h"

static NSString * const LAHomeTableCellID = @"LAHomeTableCell";

@interface LAHomeViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation LAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self baseSet];
}

- (void)baseSet
{
    LAHomeHeaderView *headerView = [LAHomeHeaderView headerView];
    self.tableView.tableHeaderView = headerView;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LAHomeTableCell class]) bundle:nil] forCellReuseIdentifier:LAHomeTableCellID];

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
    LAHomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:LAHomeTableCellID];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
