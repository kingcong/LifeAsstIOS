



#import "XMGWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface XMGWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewBottom;

/** 进度代理对象 */
@property (nonatomic, strong) NJKWebViewProgress *progress;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;


@end

@implementation XMGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = self.progress;
    __weak typeof(self) weakSelf = self;
    self.progress.progressBlock = ^(float progress) {
        weakSelf.progressView.progress = progress;
        
        weakSelf.progressView.hidden = (progress == 1.0);
    };
    self.progress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 10, 20, 20);
    [button setImage:[UIImage imageNamed:@"Login_icon_back.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.toolBar.hidden = self.isHideToolbar;
    
    if (self.toolBar.hidden == YES) {
        self.webViewBottom.constant = -49.0;
    } else {
        self.webViewBottom.constant = 0;
    }
}

- (void)setIsHideToolbar:(BOOL)isHideToolbar
{
    _isHideToolbar = isHideToolbar;
    
//    self.toolBar.hidden = isHideToolbar;
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

#pragma mark - <UIWebViewDelegate>

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityView stopAnimating];
    self.activityView.hidden = YES;
    
    self.goBackItem.enabled = webView.canGoBack;
    self.goForwardItem.enabled = webView.canGoForward;
    
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityView stopAnimating];
    self.activityView.hidden = YES;

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    NSLog(@"%@",urlStr);
    return YES;
}

- (void)back{
    NSLog(@"%s",__func__);
    
    if (self.webView.canGoBack) {
        [self.webView goBack];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
