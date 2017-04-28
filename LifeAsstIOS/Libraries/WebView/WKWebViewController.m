//
//  WKWebViewController.m
//  Faith in life
//
//  Created by 王聪 on 16/4/27.
//  Copyright © 2016年 allan. All rights reserved.
//

#import "WKWebViewController.h"
#import "MJRefresh.h"
#import <WebKit/WebKit.h>
#import <Masonry.h>
#define WebViewNav_TintColor ([UIColor orangeColor])

@interface WKWebViewController () <WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate>

@property (weak, nonatomic) WKWebView *webView;

// toobar按钮
@property (weak, nonatomic) UIButton *goBackItem;
@property (weak, nonatomic) UIButton *goForwardItem;
@property (weak, nonatomic) UIButton *goRefreshItem;

@property (weak, nonatomic) UIView *toolBar;

@property (weak, nonatomic) UIProgressView *progressView;

@property (weak, nonatomic) UIActivityIndicatorView *activityView;

@property (strong, nonatomic) WKWebViewConfiguration *configuretion;

@property (nonatomic, copy)NSString *method;
@property (nonatomic, copy)NSString *seqid;
@property (nonatomic, copy)NSString *callback;
@property (nonatomic, copy)NSString *result;
@property (nonatomic, copy)NSString *data;

@property (nonatomic, strong) NSURLRequest *request;

@property (assign, nonatomic) NSUInteger loadCount;

@end

@implementation WKWebViewController

//- (WKWebViewConfiguration *)configuretion
//{
//    if (_configuretion == nil) {
//        _configuretion = [[WKWebViewConfiguration alloc] init];
//    }
//    return _configuretion;
//}

- (instancetype)initWithUrlStr:(NSString *)urlStr
{
    if (self  = [super init]) {
        
        self.url = urlStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    self.toolBar.hidden = YES;
    
    [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(0);
    }];

    
    // 加载请求
    [self loadRequest];

}

- (void)setup
{
    
    // 0.创建配置
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKPreferences *preferences = [[WKPreferences alloc] init];
    preferences.minimumFontSize = 10;
    preferences.javaScriptEnabled = YES;
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;
    
    configuration.userContentController = [[WKUserContentController alloc] init];
    
    
    // 1.设置webView
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    webView.backgroundColor = APP_PAGE_COLOR;
    webView.allowsBackForwardNavigationGestures = YES;
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView = webView;
    [self.view addSubview:webView];
    
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-40);
    }];
    
    // 2.设置进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, kWindowWidth, 3)];
    progressView.progress = 0.0;
    progressView.tintColor = WebViewNav_TintColor;
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    // 3.加载圆圈
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] init];
    activityView.color = [UIColor blackColor];
    self.activityView = activityView;
    [self.view addSubview:activityView];
    
    [activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    // 4.下方工具条
    UIView *toolBar = [[UIView alloc] init];
    self.toolBar = toolBar;
    toolBar.backgroundColor = [UIColor grayColor];
    [self.view addSubview:toolBar];
    
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_equalTo(40);
    }];
    
    //    self.toolBar.hidden = YES;
    
    // 5.工具条按钮
    UIButton *goBackItem = [UIButton buttonWithType:UIButtonTypeCustom];
    goBackItem.backgroundColor = [UIColor redColor];
    [goBackItem setTitle:@"后退" forState:UIControlStateNormal];
    [goBackItem setTintColor:[UIColor whiteColor]];
    self.goBackItem = goBackItem;
    
    [goBackItem addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar addSubview:goBackItem];
    
    [goBackItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.toolBar).offset(10);
        make.top.bottom.mas_equalTo(self.toolBar);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *goForwardItem = [UIButton buttonWithType:UIButtonTypeCustom];
    goForwardItem.backgroundColor = [UIColor greenColor];
    self.goForwardItem = goForwardItem;
    [goForwardItem setTitle:@"前进" forState:UIControlStateNormal];
    [goForwardItem setTintColor:[UIColor whiteColor]];
    [goForwardItem addTarget:self action:@selector(goForward:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:goForwardItem];
    [goForwardItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(goBackItem.mas_right).mas_offset(10);
        make.top.bottom.mas_equalTo(self.toolBar);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *goRefreshItem = [UIButton buttonWithType:UIButtonTypeCustom];
    goRefreshItem.backgroundColor = [UIColor blueColor];
    self.goRefreshItem = goRefreshItem;
    [goRefreshItem setTitle:@"刷新" forState:UIControlStateNormal];
    [goRefreshItem setTintColor:[UIColor whiteColor]];
    [goRefreshItem addTarget:self action:@selector(goRefresh:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:goRefreshItem];
    [goRefreshItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.toolBar);
        make.width.mas_equalTo(50);
        make.right.mas_equalTo(-10);
    }];
    
    // 特殊设置
    [self setNavView];
}

- (void)setNavView
{
//    [self setLeftItem];
}

- (void)setLeftItem
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 10, 20, 20);
    [button setImage:[UIImage imageNamed:@"Login_icon_back.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}


// 1.加载请求
- (void)loadRequest
{
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    if (self.url == nil || self.url.length == 0) {
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    self.request = request;
    
    [self.webView loadRequest:request];

    
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.11/test/index.html"]]];
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
    
}

- (void)goRefresh:(id)sender {
    [self.webView reload];
}

- (void)goBack:(id)sender {
    [self.webView goBack];
}

- (void)goForward:(id)sender {
    [self.webView goForward];
}



#pragma mark - wkWebView代理


// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

// 记得取消监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s",__func__);
    self.activityView.hidden = NO;
    [self.activityView startAnimating];

}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s",__func__);
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s",__func__);
    [self.activityView stopAnimating];
    self.activityView.hidden = YES;
    
    [self.webView.scrollView.mj_header endRefreshing];
    
    //    self.goBackItem.enabled = webView.canGoBack;
    //    self.goForwardItem.enabled = webView.canGoForward;
    
    // OC调用JS代码
    //    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        self.title = (NSString *)result;
    }];
    

}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s",__func__);
    
    [self.activityView stopAnimating];
    self.activityView.hidden = YES;
    self.progressView.hidden = YES;
    
//    [USProgressHud showErrorWithStatus:OTHER_FAIL_OR_NETWORK];

}

- (void)setLeftItemWithType:(int)type
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 10, 30, 20);
    [backBtn setImage:[UIImage imageNamed:@"Login_icon_back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 10, 30, 20);
    [closeBtn setImage:[UIImage imageNamed:@"closeWeb"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *closeBtnItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    
    
    if (type == 1) {
        self.navigationItem.leftBarButtonItems = @[backBtnItem,closeBtnItem];
        return;
    } else if(type == 0){
        self.navigationItem.leftBarButtonItems = @[backBtnItem];
        return;
    }
    
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark - 接收到服务器请求调用的方法
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s",__func__);
    
//    NSString *urlStr = webView.URL.absoluteString;
    
//    NSLog(@"-------%@",urlStr);

}
//
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
//    NSString *urlStr = webView.URL.absoluteString;
    
//    NSLog(@"-------%@",urlStr);
    
    NSURLResponse *response = navigationResponse.response;
//    NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:[NSURL URLWithString:@""]];
//    for (NSHTTPCookie *cookie in newCookies) {
//        // Do something with the cookie
//    }

    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 在发送请求之前，决定是否跳转
// 如果不添加这个，那么wkwebview跳转不了AppStore
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSLog(@"%s",__func__);
    
    NSString *urlStr = webView.URL.absoluteString;
    
    NSLog(@"-------%@",urlStr);
    
    decisionHandler(WKNavigationActionPolicyAllow);

}

- (void)back{
    NSLog(@"%s",__func__);
    
    if (self.webView.canGoBack) {
        [self setLeftItemWithType:1];
        [self.webView goBack];
        
        return;
    }
    //    [self setLeftItemWithType:0];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)close{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  关闭当前webView
 *
 *  @param propertyDict
 */
- (void)closeWebView:(NSDictionary *)propertyDict
{
    [self close];
}


/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"%s",__func__);
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示框" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alertVc addAction:action];
    [self presentViewController:alertVc animated:YES completion:^{
        
    }];

}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    NSLog(@"%s",__func__);
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示框" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }];
    [alertVc addAction:action];
    [self presentViewController:alertVc animated:YES completion:^{
        
    }];

}


/**
 *  下面的代码不添加，通过js弹出的AlertView就不能执行
 *
 *  @param webView
 *  @param configuration
 *  @param navigationAction
 *  @param windowFeatures
 *
 *  @return
 */
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"%@",message);
}


// 对于HTTPS的都会触发此代理，如果不要求验证，传默认就行
// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}


//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//    NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:[NSURL URLWithString:@""]];
//    for (NSHTTPCookie *cookie in newCookies) {
//        // Do something with the cookie
//    }
//    
//    decisionHandler(WKNavigationResponsePolicyAllow);
//}

@end
