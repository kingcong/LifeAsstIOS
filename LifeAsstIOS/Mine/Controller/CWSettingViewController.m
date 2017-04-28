//
//  CWSettingViewController.m
//  新浪微博架构搭建
//
//  Created by WangCong on 15/6/18.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import "CWSettingViewController.h"
#import "CWCommonGroup.h"
#import "CWCommonItem.h"
#import "CWCommonArrowItem.h"
#import "CWCommonSwitchItem.h"
#import "CWCommonLabelItem.h"
//#import "CWTest1ViewController.h"
//#import "SDImageCache.h"
#import "NSString+File.h"
#import "MBProgressHUD+MJ.h"
@interface CWSettingViewController ()

@end

@implementation CWSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupGroups];
    
    [self setupFooter];
}

- (void)setupFooter
{
    // 1.创建按钮
    UIButton *logout = [[UIButton alloc] init];
    
    // 2.设置属性
    logout.titleLabel.font = [UIFont systemFontOfSize:14];
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizedImage:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置尺寸(tableFooterView和tableHeaderView的宽度跟tableView的宽度一样)
    logout.height = 35;
    
    self.tableView.tableFooterView = logout;
}
/**
 *  初始化模型数据
 */
- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    [self setupGroup3];
}

- (void)setupGroup0
{
    // 1.创建组
    CWCommonGroup *group = [CWCommonGroup group];
    group.footer = @"tail部";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    CWCommonArrowItem *newFriend = [CWCommonArrowItem itemWithTitle:@"帐号管理"];
    
    group.items = @[newFriend];
}

- (void)setupGroup1
{
    // 1.创建组
    CWCommonGroup *group = [CWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    CWCommonArrowItem *newFriend = [CWCommonArrowItem itemWithTitle:@"主题、背景"];
    
    group.items = @[newFriend];
}

- (void)setupGroup2
{
    // 1.创建组
    CWCommonGroup *group = [CWCommonGroup group];
    group.header = @"头部";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    CWCommonArrowItem *generalSetting = [CWCommonArrowItem itemWithTitle:@"通用设置"];
    generalSetting.destVcClass = [CWSettingViewController class];
    
    group.items = @[generalSetting];
}

- (void)setupGroup3
{
    // 1.创建组
    CWCommonGroup *group = [CWCommonGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    CWCommonArrowItem *clearCache = [CWCommonArrowItem itemWithTitle:@"清除图片缓存"];
    
    // 获取缓存路径
    //    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //    [caches stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
//    NSString * imageCachedPath = [SDImageCache sharedImageCache].diskCachePath;
//    long long fileSize = [imageCachedPath fileSize];
//    
//    
//    
//    clearCache.subtitle = [NSString stringWithFormat:@"%.1fM",fileSize / (1000.0 * 1000.0)];
//    
//    __weak typeof(clearCache) weakClearCache = clearCache;
//    __weak typeof(self) weakVc = self;
//    clearCache.operation = ^{
//        [MBProgressHUD showMessage:@"正在清除缓存..."];
//        
//        // 清除缓存
//        NSFileManager *mgr = [NSFileManager defaultManager];
//        [mgr removeItemAtPath:imageCachedPath error:nil];
//        
//        // 设置subtitle
//        weakClearCache.subtitle = nil;
//        
//        // 刷新表格
//        [weakVc.tableView reloadData];
//        
//        [MBProgressHUD hideHUD];
//    };
    
    group.items = @[clearCache];
}
@end
