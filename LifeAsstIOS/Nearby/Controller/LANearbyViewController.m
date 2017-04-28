//
//  LANearbyViewController.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/3/1.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LANearbyViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "LocationDemoViewController.h"

#import "TZNavigationViewController.h"
#import "PoiSearchDemoViewController.h"
#import "RouteSearchDemoViewController.h"
#import "BusLineSearchViewController.h"
#import "DistrictSearchDemoViewController.h"

@interface LANearbyViewController () <BMKMapViewDelegate,BMKLocationServiceDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (strong, nonatomic) UISearchBar *searchBar;


@property (strong, nonatomic) BMKLocationService* locService;

@end

@implementation LANearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setTitleSearchBar];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
//        self.navigationController.navigationBar.translucent = NO;
    }
    _segment.selectedSegmentIndex = 0;
    [_mapView setTrafficEnabled:NO];
    [_mapView setBuildingsEnabled:YES];
    
    _mapView.showsUserLocation = YES;//显示定位图层
//    [_mapView updateLocationData:userLocation];
    
    [_mapView setBaiduHeatMapEnabled:NO];
    
    _locService = [[BMKLocationService alloc]init];
    
    [self startLocating:nil];
}

- (void)setTitleSearchBar
{
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _searchBar.delegate = self;
        [_searchBar setPlaceholder:@"附近餐厅/景点/优惠查询"];
    //    _searchBar.tintColor = COLOR_TEXT_II;
        _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
        [_searchBar setSearchFieldBackgroundImage:[[UIImage imageNamed:@"icon_search_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)] forState:UIControlStateNormal];
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.navigationItem.titleView = _searchBar;

}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

/*
 开始定位
 */
- (IBAction)startLocating:(UIButton *)sender {
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"textDidChange");
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"-------");
    
    PoiSearchDemoViewController *searchCtl = [[PoiSearchDemoViewController alloc] init];
//    [self.navigationController pushViewController:searchCtl animated:NO];
    
    searchCtl.hidesBottomBarWhenPushed = YES;
    [searchCtl setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    TZNavigationViewController *tznavc = [[TZNavigationViewController alloc] initWithRootViewController:searchCtl];
    [self presentViewController:tznavc animated:YES completion:nil];
    
    return NO;
}


#pragma mark - 点击事件

- (IBAction)roadGuide:(UIButton *)sender {
    RouteSearchDemoViewController *routeVc = [[RouteSearchDemoViewController alloc] init];
    [self.navigationController pushViewController:routeVc animated:YES];
}

- (IBAction)busQuery:(UIButton *)sender {
    BusLineSearchViewController *busVc = [[BusLineSearchViewController alloc] init];
    [self.navigationController pushViewController:busVc animated:YES];
}

- (IBAction)districtSearch:(UIButton *)sender {
    DistrictSearchDemoViewController *districtVc = [[DistrictSearchDemoViewController alloc] init];
    [self.navigationController pushViewController:districtVc animated:YES];
}



@end
