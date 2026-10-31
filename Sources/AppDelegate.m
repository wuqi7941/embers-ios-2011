#import "AppDelegate.h"
#import <WebKit/WebKit.h>

static NSString *const kHomeURL = @"https://guanjin2011.de5.net/";

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
    WKWebView *web = [[WKWebView alloc] initWithFrame:bounds configuration:config];
    web.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    web.opaque = YES;
    web.backgroundColor = paper;
    web.allowsBackForwardNavigationGestures = YES;

    UIViewController *controller = [[UIViewController alloc] init];
    controller.view = web;

    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];

    NSURL *url = [NSURL URLWithString:kHomeURL];
    [web loadRequest:[NSURLRequest requestWithURL:url]];

    return YES;
}

@end
