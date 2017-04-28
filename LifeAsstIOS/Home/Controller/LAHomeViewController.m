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

#import "MainViewController.h"
#import "XMGWebViewController.h"
#import "SRLocationTool.h"

static NSString * const LAHomeTableCellID = @"LAHomeTableCell";

@interface LAHomeViewController () <UITableViewDataSource,UITableViewDelegate,LAHomeHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation LAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self baseSet];
    
    [[SRLocationTool sharedInstance] beginLocation];
}

- (void)baseSet
{
    LAHomeHeaderView *headerView = [LAHomeHeaderView headerView];
    headerView.delegate = self;
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

#pragma mark - LAHeaderViewDelegate的代理方法
- (void)tapHeaderView
{
    MainViewController *mainVc = [[MainViewController alloc] init];
    [self.navigationController pushViewController:mainVc animated:YES];
}

- (void)styleClick:(NSInteger)type
{
    WKWebViewController *wkVc = [[WKWebViewController alloc] init];
    wkVc.url = @"http://www.baidu.com";
    [self.navigationController pushViewController:wkVc animated:YES];
}

@end
