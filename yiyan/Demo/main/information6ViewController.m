//
//  information5ViewController.m
//  GHSidebarNav
//
//  Created by Apple on 13-7-20.
//
//

#import "information6ViewController.h"

@interface information6ViewController ()

@end

@implementation information6ViewController
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock {
    if (self = [super initWithNibName:@"information6ViewController" bundle:nil]) {
		self.title = title;
		_revealBlock = [revealBlock copy];
		self.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                      target:self
                                                      action:@selector(revealSidebar)];
	}
	return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)startHttp
{
    // Do any additional setup after loading the view from its nib.
    NSURL* url = [NSURL URLWithString:[@"http://php.weather.sina.com.cn/flight/" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    if (url) {
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        if (request) {
            [self.webview loadRequest:request];
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addAdviewToCurrent];
   
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startHttp];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setWebview:nil];
    [super viewDidUnload];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
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
- (void)revealSidebar {
	_revealBlock();
}
@end
