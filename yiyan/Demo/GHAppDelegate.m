//
//  GHAppDelegate.m
//  GHSidebarNav
//
//  Created by Greg Haines on 11/20/11.
//

#import "GHAppDelegate.h"
#import "GHMenuCell.h"
#import "GHMenuViewController.h"
#import "GHRootViewController.h"
#import "GHRevealViewController.h"
#import "GHSidebarSearchViewController.h"
#import "GHSidebarSearchViewControllerDelegate.h"
#import "information1ViewController.h"
#import "information2ViewController.h"
#import "information3ViewController.h"
#import "information4ViewController.h"
#import "information5ViewController.h"
#import "information6ViewController.h"
#import "MobClick.h"

#pragma mark -
#pragma mark Private Interface
@interface GHAppDelegate () <GHSidebarSearchViewControllerDelegate>
@property (nonatomic, strong) GHRevealViewController *revealController;
@property (nonatomic, strong) GHSidebarSearchViewController *searchController;
@property (nonatomic, strong) GHMenuViewController *menuController;
@end


#pragma mark -
#pragma mark Implementation
@implementation GHAppDelegate

#pragma mark Properties
@synthesize window;
@synthesize revealController, searchController, menuController;

#pragma mark UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [MobClick startWithAppkey:@"4ff7ec16527015083e00000b"];
    
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
	
	UIColor *bgColor = [UIColor colorWithRed:(50.0f/255.0f) green:(57.0f/255.0f) blue:(74.0f/255.0f) alpha:1.0f];
	self.revealController = [[GHRevealViewController alloc] initWithNibName:nil bundle:nil];
	self.revealController.view.backgroundColor = bgColor;
	
	RevealBlock revealBlock = ^(){
		[self.revealController toggleSidebar:!self.revealController.sidebarShowing 
									duration:kGHRevealSidebarDefaultAnimationDuration];
	};
	
	NSArray *headers = @[
		[NSNull null],
		@"常用"
	];
	NSArray *controllers = @[
		@[
			[[UINavigationController alloc] initWithRootViewController:[[information1ViewController alloc] initWithTitle:@"身份证信息查询" withRevealBlock:revealBlock]]
		],
		@[
			[[UINavigationController alloc] initWithRootViewController:[[information2ViewController alloc] initWithTitle:@"手机号码归属地查询" withRevealBlock:revealBlock]],
			[[UINavigationController alloc] initWithRootViewController:[[information3ViewController alloc] initWithTitle:@"IP地址查询" withRevealBlock:revealBlock]],
			[[UINavigationController alloc] initWithRootViewController:[[information4ViewController alloc] initWithTitle:@"生日密码" withRevealBlock:revealBlock]],
			[[UINavigationController alloc] initWithRootViewController:[[information5ViewController alloc] initWithTitle:@"火车时刻查询" withRevealBlock:revealBlock]],
			[[UINavigationController alloc] initWithRootViewController:[[information6ViewController alloc] initWithTitle:@"全国航班进出港实时动态查询 " withRevealBlock:revealBlock]]
		]
	];
	NSArray *cellInfos = @[
		@[
			@{kSidebarCellImageKey: [UIImage imageNamed:@"searchBarIcon.png"], kSidebarCellTextKey: NSLocalizedString(@"身份证信息查询", @"")}
		],
		@[
			@{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"手机号码归属地查询", @"")},
			@{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"IP地址查询", @"")},
			@{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"生日密码", @"")},
			@{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"火车时刻查询", @"")},
			@{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"全国航班进出港实时动态查询 ", @"")},
		]
	];
	
	// Add drag feature to each root navigation controller
	[controllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
		[((NSArray *)obj) enumerateObjectsUsingBlock:^(id obj2, NSUInteger idx2, BOOL *stop2){
			UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.revealController 
																						 action:@selector(dragContentView:)];
			panGesture.cancelsTouchesInView = YES;
            
            
            UINavigationController* navigationController = (UINavigationController *)obj2;
			[navigationController.navigationBar addGestureRecognizer:panGesture];
            
            ((UINavigationController *)obj2).navigationBar.tintColor = [UIColor colorWithRed:(58.0f/255.0f) green:(67.0f/255.0f) blue:(104.0f/255.0f) alpha:1.0f];
            if([navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
                [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navgationbackground.png"] forBarMetrics: UIBarMetricsDefault];
            }

            
		}];
	}];
	
	self.searchController = [[GHSidebarSearchViewController alloc] initWithSidebarViewController:self.revealController];
	self.searchController.view.backgroundColor = [UIColor clearColor];
    self.searchController.searchDelegate = self;
	self.searchController.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	self.searchController.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
	self.searchController.searchBar.backgroundImage = [UIImage imageNamed:@"searchBarBG.png"];
	self.searchController.searchBar.placeholder = NSLocalizedString(@"Search", @"");
	self.searchController.searchBar.tintColor = [UIColor colorWithRed:(58.0f/255.0f) green:(67.0f/255.0f) blue:(104.0f/255.0f) alpha:1.0f];
	for (UIView *subview in self.searchController.searchBar.subviews) {
		if ([subview isKindOfClass:[UITextField class]]) {
			UITextField *searchTextField = (UITextField *) subview;
			searchTextField.textColor = [UIColor colorWithRed:(154.0f/255.0f) green:(162.0f/255.0f) blue:(176.0f/255.0f) alpha:1.0f];
		}
	}
	[self.searchController.searchBar setSearchFieldBackgroundImage:[[UIImage imageNamed:@"searchTextBG.png"] 
																		resizableImageWithCapInsets:UIEdgeInsetsMake(16.0f, 17.0f, 16.0f, 17.0f)]	
														  forState:UIControlStateNormal];
	[self.searchController.searchBar setImage:[UIImage imageNamed:@"searchBarIcon.png"] 
							 forSearchBarIcon:UISearchBarIconSearch 
										state:UIControlStateNormal];
	
	self.menuController = [[GHMenuViewController alloc] initWithSidebarViewController:self.revealController 
																		withSearchBar:self.searchController.searchBar 
																		  withHeaders:headers 
																	  withControllers:controllers 
																		withCellInfos:cellInfos];
	
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.revealController;
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark GHSidebarSearchViewControllerDelegate
- (void)searchResultsForText:(NSString *)text withScope:(NSString *)scope callback:(SearchResultsBlock)callback {
	callback(@[@"Foo", @"Bar", @"Baz"]);
}

- (void)searchResult:(id)result selectedAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"Selected Search Result - result: %@ indexPath: %@", result, indexPath);
}

- (UITableViewCell *)searchResultCellForEntry:(id)entry atIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView {
	static NSString* identifier = @"GHSearchMenuCell";
	GHMenuCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (!cell) {
		cell = [[GHMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	cell.textLabel.text = (NSString *)entry;
	cell.imageView.image = [UIImage imageNamed:@"user"];
	return cell;
}

@end
