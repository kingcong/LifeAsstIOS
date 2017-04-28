//
//  LATabBarController.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/3/10.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LATabBarController.h"
#import "LANavgationController.h"
#import "LAHomeViewController.h"
#import "LANearbyViewController.h"
#import "LAFriendViewController.h"
#import "LAMineViewController.h"
#import "MainViewController.h"

#import "CWProfileViewController.h"

@interface LATabBarController ()

@end

@implementation LATabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];;
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 添加子控制器
    [self setupChildVc:[[LAHomeViewController alloc] init] title:@"主页" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setupChildVc:[[LANearbyViewController alloc] init] title:@"附近" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setupChildVc:[[LAFriendViewController alloc] init] title:@"朋友圈" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setupChildVc:[[CWProfileViewController alloc] init] title:@"我的" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    // 替换系统的tabBar
//    [self setValue:[[CWTabBar alloc] init] forKeyPath:@"tabBar"];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.view.backgroundColor = CWGlobalBg;
    vc.navigationItem.title = title;
    // 添加为子控制器
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    LANavgationController *nav = [[LANavgationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [self addChildViewController:nav];}
@end
