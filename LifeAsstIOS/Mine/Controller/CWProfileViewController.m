//
//  CWProfileViewController.m
//  新浪微博架构搭建
//
//  Created by WangCong on 15/6/5.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import "CWProfileViewController.h"
#import "CWCommonGroup.h"
#import "CWCommonArrowItem.h"
#import "CWCommonSwitchItem.h"
#import "CWCommonLabelItem.h"
#import "MBProgressHUD+MJ.h"
#import "CWSettingViewController.h"

#import "LAMineHeaderView.h"

@interface CWProfileViewController ()

@end

@implementation CWProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
    
    [self setupHeaderView];
    [self setupGroups];
}

- (void)setupHeaderView
{
    LAMineHeaderView *headerView = [LAMineHeaderView headerView];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 100);
    self.tableView.tableHeaderView = headerView;
}

- (void)setting
{
    CWSettingViewController *setting = [[CWSettingViewController alloc] init];
    [self.navigationController pushViewController:setting animated:YES];
}


/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1.创建组
    CWCommonGroup *group = [CWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    CWCommonArrowItem *newFriend = [CWCommonArrowItem itemWithTitle:@"新的好友" icon:@"new_friend"];
//    newFriend.badgeValue = @"5";
    CWCommonArrowItem *newFriend2 = [CWCommonArrowItem itemWithTitle:@"新的好友2" icon:@"new_friend"];

    
    group.items = @[newFriend,newFriend2];
}

- (void)setupGroup1
{
    // 1.创建组
    CWCommonGroup *group = [CWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    CWCommonArrowItem *album = [CWCommonArrowItem itemWithTitle:@"我的相册" icon:@"album"];
    album.subtitle = @"(100)";
    
    CWCommonArrowItem *collect = [CWCommonArrowItem itemWithTitle:@"我的收藏" icon:@"collect"];
    collect.subtitle = @"(10)";
//    collect.badgeValue = @"1";
    
    CWCommonArrowItem *like = [CWCommonArrowItem itemWithTitle:@"赞" icon:@"like"];
    like.subtitle = @"(36)";
//    like.badgeValue = @"10";
    
    group.items = @[album, collect, like];
}

- (void)setupGroup2
{
    // 1.创建组
    CWCommonGroup *group = [CWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    CWCommonArrowItem *album = [CWCommonArrowItem itemWithTitle:@"我的相册" icon:@"album"];
    album.subtitle = @"(100)";
    
    CWCommonArrowItem *collect = [CWCommonArrowItem itemWithTitle:@"我的收藏" icon:@"collect"];
    collect.subtitle = @"(10)";
    //    collect.badgeValue = @"1";
    
    CWCommonArrowItem *like = [CWCommonArrowItem itemWithTitle:@"赞" icon:@"like"];
    like.subtitle = @"(36)";
    //    like.badgeValue = @"10";
    
    group.items = @[album, collect, like];
}


@end
