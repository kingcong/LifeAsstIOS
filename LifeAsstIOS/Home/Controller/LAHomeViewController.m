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

#import "PoiSearchDemoViewController.h"
#import "TZNavigationViewController.h"
#import "AFHTTPSessionManager.h"
#import "MJExtension.h"
#import "SRWeatherDataTool.h"
#import "SRWeatherCityTool.h"

#import "SRUserDefaults.h"
#import "NowWeatherData.h"
#import "CityWeatherData.h"
#import "SRWeatherAssist.h"

#import "LAWeatherModel.h"

static NSString * const LAHomeTableCellID = @"LAHomeTableCell";

@interface LAHomeViewController () <UITableViewDataSource,UITableViewDelegate,LAHomeHeaderViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) LAHomeHeaderView *headerView;

@end

@implementation LAHomeViewController

- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self baseSet];
    
    [self startRequest];
    
    [[SRLocationTool sharedInstance] beginLocation];
    
    [self beginLocation];
}

- (void)beginLocation {
    
    [SRLocationTool sharedInstance].delegate = self;
    
    if ([SRUserDefaults boolForKey:kHasRequestLocationAuthorization]) {
        if ([SRLocationTool sharedInstance].isAutoLocation) {
            [[SRLocationTool sharedInstance] beginLocation];
            
            NSString *city = [SRLocationTool sharedInstance].currentLocationCity;
            NSLog(@"city:%@",city);
            NSString *cityid = [SRWeatherCityTool cityidOfCityname:city];
            if (city && cityid) {
                [self loadWeatherDataOfCity:city cityid:cityid];
            } else {
//                [self loadWeatherDataOfCommonCity];
            }
        } else {
//            [self loadWeatherDataOfCommonCity];
        }
    } else {
        [SRUserDefaults setBool:YES forKey:kHasRequestLocationAuthorization];
        [[SRLocationTool sharedInstance] requestAuthorization];
    }
}


- (void)loadWeatherDataOfCity:(NSString *)city cityid:(NSString *)cityid {
    
    [SRWeatherDataTool loadWeatherDataCity:city cityid:cityid success:^(NSDictionary *weatherData) {
        NSLog(@"%@",weatherData);
        NSDictionary *nowWeatherInfo = weatherData[@"HeWeather data service 3.0"][0][@"now"];
        NSDictionary *cityWeatherInfo = weatherData[@"HeWeather data service 3.0"][0][@"aqi"][@"city"];
        NowWeatherData *nowWeatherData = [NowWeatherData mj_objectWithKeyValues:nowWeatherInfo];
        CityWeatherData *cityWeatherData = [CityWeatherData mj_objectWithKeyValues:cityWeatherInfo];
        NSInteger weatherCode = [nowWeatherData.code integerValue];
        NSString *imageName = [SRWeatherAssist getBackgroundImageNameWithWeatherCode:weatherCode];

        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"imageName"] = imageName;
        dict[@"tmp"] = nowWeatherData.tmp;
        dict[@"code"] = nowWeatherData.code;
        dict[@"txt"] = nowWeatherData.txt;
        dict[@"pm25"] = cityWeatherData.pm25;
        dict[@"qlty"] = cityWeatherData.qlty;
        LAWeatherModel *weatherModel = [[LAWeatherModel alloc] initWithDict:dict];
        self.headerView.weatherModel = weatherModel;
    } failure:^(NSError *error) {
        [self handleFailure:error];
    }];
}

- (void)handleFailure:(NSError *)error {
   
}


- (void)startRequest
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *appcode = @"feec4bfa9ec145c48e23e380057a3bfc";
    NSString *host = @"http://toutiao-ali.juheapi.com";
    NSString *path = @"/toutiao/index";
    NSString *querys = @"?type=keji";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  @"GET";
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    
    //发起请求
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            
            NSLog(@"Reply JSON: %@", responseObject);
            NSArray *dictArray = responseObject[@"result"][@"data"];
            self.dataArray = [LASplitModel mj_objectArrayWithKeyValuesArray:dictArray];
            [self.tableView reloadData];
            NSLog(@"%@",self.dataArray);
            
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            
        }
        
    }] resume];
}


- (void)baseSet
{
    self.headerView = [LAHomeHeaderView headerView];
    _headerView.delegate = self;
    _headerView.searchBar.delegate = self;
    self.tableView.tableHeaderView = _headerView;
    
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
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LAHomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:LAHomeTableCellID];
    cell.splitModel = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    WKWebViewController *wkVc = [[WKWebViewController alloc] init];
    LASplitModel *splitModel = self.dataArray[indexPath.row];
    wkVc.url = splitModel.url;
    [self.navigationController pushViewController:wkVc animated:YES];
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

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"searchBarShouldBeginEditing");
    
    PoiSearchDemoViewController *searchCtl = [[PoiSearchDemoViewController alloc] init];
    //    [self.navigationController pushViewController:searchCtl animated:NO];
    
    searchCtl.hidesBottomBarWhenPushed = YES;
    [searchCtl setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    TZNavigationViewController *tznavc = [[TZNavigationViewController alloc] initWithRootViewController:searchCtl];
    [self presentViewController:tznavc animated:YES completion:nil];
    
    return NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"textDidChange");
}

@end
