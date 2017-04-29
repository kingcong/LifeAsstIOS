//
//  LASplitViewController.m
//  LifeAsstIOS
//
//  Created by kingcong on 2017/4/28.
//  Copyright © 2017年 lifeasst. All rights reserved.
//

#import "LASplitViewController.h"
#import "LASplitViewCell.h"
#import "AFHTTPSessionManager.h"
#import "MJExtension.h"
#import "LASplitModel.h"

@interface LASplitViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

static NSString * const LASplitTableCellID = @"LASplitTableCell";

@implementation LASplitViewController

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTableView];
    
    [self startRequest];
}

#pragma mark - 基本设置
- (void)setupTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LASplitViewCell class]) bundle:nil] forCellReuseIdentifier:LASplitTableCellID];
    
    self.tableView.rowHeight = 135;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)startRequest
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *appcode = @"feec4bfa9ec145c48e23e380057a3bfc";
    NSString *host = @"http://toutiao-ali.juheapi.com";
    NSString *path = @"/toutiao/index";
    NSString *querys = @"?type=type";
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
    LASplitViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LASplitTableCellID];
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


@end
