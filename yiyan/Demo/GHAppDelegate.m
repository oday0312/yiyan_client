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
#import "MobClick.h"
#import "imageCacheManager.h"

#import "paperListViewController.h"
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

- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}

#pragma mark UIApplicationDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [MobClick startWithAppkey:@"4ff7ec16527015083e00000b"];
    [imageCacheManager initCacheDirectory];
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
	
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
    
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
    
    paperListViewController* controller1 = [[paperListViewController alloc] initWithTitle:@"译言精选－社会" withRevealBlock:revealBlock];
    paperListViewController* controller2 = [[paperListViewController alloc] initWithTitle:@"译言精选－科学" withRevealBlock:revealBlock];
    paperListViewController* controller3 = [[paperListViewController alloc] initWithTitle:@"译言精选－生活" withRevealBlock:revealBlock];
    paperListViewController* controller4 = [[paperListViewController alloc] initWithTitle:@"译言精选－经济" withRevealBlock:revealBlock];
    paperListViewController* controller5 = [[paperListViewController alloc] initWithTitle:@"译言精选－文化" withRevealBlock:revealBlock];
    
    controller1.urlStringHead = @"http://select.yeeyan.org/lists/social";
    controller2.urlStringHead = @"http://select.yeeyan.org/lists/science";
    controller3.urlStringHead = @"http://select.yeeyan.org/lists/lifestyle";
    controller4.urlStringHead = @"http://select.yeeyan.org/lists/economic";
    controller5.urlStringHead = @"http://select.yeeyan.org/lists/culture";
    
	NSArray *controllers = @[
		@[
            [[UINavigationController alloc] initWithRootViewController:controller1]
		],
		@[
			[[UINavigationController alloc] initWithRootViewController:controller2],
			[[UINavigationController alloc] initWithRootViewController:controller3],
			[[UINavigationController alloc] initWithRootViewController:controller4],
			[[UINavigationController alloc] initWithRootViewController:controller5],
			
		]
	];
    
    
    
	NSArray *cellInfos = @[
		@[
			@{kSidebarCellImageKey: [UIImage imageNamed:@"searchBarIcon.png"], kSidebarCellTextKey: NSLocalizedString(@"译言精选-社会", @"")}
		],
		@[
			@{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"译言精选-科学", @"")},
			@{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"译言精选-生活", @"")},
			@{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"译言精选-经济", @"")},
			@{kSidebarCellImageKey: [UIImage imageNamed:@"user.png"], kSidebarCellTextKey: NSLocalizedString(@"译言精选-文化", @"")},
			
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
