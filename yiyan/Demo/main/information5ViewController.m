//
//  information5ViewController.m
//  GHSidebarNav
//
//  Created by Apple on 13-7-20.
//
//

#import "information5ViewController.h"

@interface information5ViewController ()

@end

@implementation information5ViewController
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock {
    if (self = [super initWithNibName:@"information5ViewController" bundle:nil]) {
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
    NSURL* url = [NSURL URLWithString:[@"http://lvyou.hao123.com/huoche" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
    // Do any additional setup after loading the view from its nib.
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
