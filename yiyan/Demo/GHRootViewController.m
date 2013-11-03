//
//  GHRootViewController.m
//  GHSidebarNav
//
//  Created by Greg Haines on 11/20/11.
//

#import "GHRootViewController.h"
#import "GHPushedViewController.h"


#pragma mark -
#pragma mark Private Interface
@interface GHRootViewController ()
- (void)pushViewController;
- (void)revealSidebar;
@end

#define ADMOB_PUBLISH_ID @"a14ff805c200cec"
#pragma mark -
#pragma mark Implementation
@implementation GHRootViewController

#pragma mark Memory Management
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock {
    if (self = [super initWithNibName:nil bundle:nil]) {
		self.title = title;
		_revealBlock = [revealBlock copy];
		self.navigationItem.leftBarButtonItem = 
			[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction 
														  target:self
														  action:@selector(revealSidebar)];
	}
	return self;
}

#pragma mark UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.view.backgroundColor = [UIColor lightGrayColor];
	UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[pushButton setTitle:@"Push" forState:UIControlStateNormal];
	[pushButton addTarget:self action:@selector(pushViewController) forControlEvents:UIControlEventTouchUpInside];
	[pushButton sizeToFit];
	//[self.view addSubview:pushButton];
    //[self addAdviewToCurrent];
}
-(void)addAdviewToCurrent
{
    // Do any additional setup after loading the view from its nib.
    {
        
        self.adView = [[GADBannerView alloc]
                        initWithFrame:CGRectMake(0.0,
                                                 self.view.frame.size.height -
                                                 GAD_SIZE_320x50.height-120,
                                                 GAD_SIZE_320x50.width,
                                                 GAD_SIZE_320x50.height)] ;
        
        // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
        self.adView.adUnitID = ADMOB_PUBLISH_ID;
        
        // Let the runtime know which UIViewController to restore after taking
        // the user wherever the ad goes and add it to the view hierarchy.
        self.adView.rootViewController = self;
        self.adView.delegate = self;
        
        
        [self.view addSubview:self.adView];
        
        
        [self.adView loadRequest:[GADRequest request]];
        
    }

}
#pragma mark Private Methods
- (void)pushViewController {
	NSString *vcTitle = [self.title stringByAppendingString:@" - Pushed"];
	UIViewController *vc = [[GHPushedViewController alloc] initWithTitle:vcTitle];
	[self.navigationController pushViewController:vc animated:YES];
}

- (void)revealSidebar {
	_revealBlock();
}

@end
