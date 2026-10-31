#import "AppDelegate.h"
#import <WebKit/WebKit.h>

static NSString *const kHomeURL = @"https://guanjin2011.de5.net/";

@interface AppDelegate () <WKNavigationDelegate>
@property (strong, nonatomic) WKWebView *web;
@property (strong, nonatomic) UIRefreshControl *refresher;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    CGRect bounds = [UIScreen mainScreen].bounds;

    UIColor *paper = [UIColor colorWithRed:0xF2 / 255.0
                                    green:0xEC / 255.0
                                     blue:0xE1 / 255.0
                                    alpha:1.0];

    self.window = [[UIWindow alloc] initWithFrame:bounds];
    self.window.backgroundColor = paper;

    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.allowsInlineMediaPlayback = YES;

    WKWebView *web = [[WKWebView alloc] initWithFrame:bounds configuration:config];
    web.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    web.opaque = YES;
    web.backgroundColor = paper;
    web.allowsBackForwardNavigationGestures = YES;
    web.navigationDelegate = self;
    self.web = web;

    // 下拉刷新，染色用站点 favicon 的砖红
    UIRefreshControl *refresher = [[UIRefreshControl alloc] init];
    refresher.tintColor = [UIColor colorWithRed:0x9E / 255.0
                                          green:0x3B / 255.0
                                           blue:0x2E / 255.0
                                          alpha:1.0];
    [refresher addTarget:self
                  action:@selector(handlePullToRefresh:)
        forControlEvents:UIControlEventValueChanged];
    web.scrollView.refreshControl = refresher;
    self.refresher = refresher;

    UIViewController *controller = [[UIViewController alloc] init];
    controller.view = web;

    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];

    NSURL *url = [NSURL URLWithString:kHomeURL];
    [web loadRequest:[NSURLRequest requestWithURL:url]];

    return YES;
}

- (void)handlePullToRefresh:(UIRefreshControl *)sender {
    [self.web reload];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.refresher endRefreshing];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.refresher endRefreshing];
}

- (void)webView:(WKWebView *)webView
didFailProvisionalNavigation:(WKNavigation *)navigation
      withError:(NSError *)error {
    [self.refresher endRefreshing];
}

@end
