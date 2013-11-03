//
//  GHRootViewController.h
//  GHSidebarNav
//
//  Created by Greg Haines on 11/20/11.
//

#import <Foundation/Foundation.h>
#import "GADBannerView.h"
typedef void (^RevealBlock)();

@interface GHRootViewController : UIViewController <GADBannerViewDelegate>{

	RevealBlock _revealBlock;
}
@property(nonatomic,retain) GADBannerView *adView;
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock;
-(void)addAdviewToCurrent;
@end
