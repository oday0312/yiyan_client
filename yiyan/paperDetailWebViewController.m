//
//  paperDetailWebViewController.m
//  GHSidebarNav
//
//  Created by Alex on 13-11-4.
//
//

#import "paperDetailWebViewController.h"

@interface paperDetailWebViewController ()

@end

@implementation paperDetailWebViewController
@synthesize urlString;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webview.backgroundColor = [UIColor clearColor];
    self.webview.delegate = self;
    
    self.webview.scalesPageToFit = YES;
    NSURL* url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (url) {
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        if (request) {
            [self.webview loadRequest:request];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUrlString:(NSString *)inputUrlString
{
    if (![self.urlString isEqualToString:inputUrlString]) {
        urlString = inputUrlString;
        
        
}}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //[self.loadingImage setHidden:NO];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[self.loadingImage setHidden:YES];
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //[self.loadingImage setHidden:YES];
}

@end
