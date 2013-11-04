//
//  paperDetailWebViewController.h
//  GHSidebarNav
//
//  Created by Alex on 13-11-4.
//
//

#import <UIKit/UIKit.h>

@interface paperDetailWebViewController : UIViewController<UIWebViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property(nonatomic,strong)NSString* urlString;
@end
