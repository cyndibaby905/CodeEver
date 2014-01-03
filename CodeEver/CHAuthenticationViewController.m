//
//  CHAuthenticationViewController.m
//  CodeEver
//
//  Created by hangchen on 1/3/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import "CHAuthenticationViewController.h"
#import "NSString+URLEncoding.h"

@interface CHAuthenticationViewController ()<UIWebViewDelegate>
- (void)closeAction;
@end

@implementation CHAuthenticationViewController
{
    UIWebView* webview_;
    NSString *state_;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [webview_ stopLoading];
    webview_.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(closeAction)];
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    webview_ = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webview_.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    webview_.delegate = self;
    state_ = [NSString stringWithFormat:@"%ld",random()];
    [webview_ loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:authURL,appKey,[redirectURL stringByURLEncoding],scope,state_]]]];
    [self.view addSubview:webview_];
    
}

- (void)closeAction
{
    if ([self.delegate respondsToSelector:@selector(authenticationCancled:)]) {
        [self.delegate authenticationCancled:self];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString hasPrefix:redirectURL]) {
        NSDictionary *para = [request.URL.query queryDictionaryUsingEncoding:NSUTF8StringEncoding];
        if ([para[@"state"] isEqualToString:state_] && para[@"code"]) {
            [self.delegate authenticationFinished:self withCode:para[@"code"]];
        }
        else {
            [self.delegate authenticationFailed:self];
        }
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
