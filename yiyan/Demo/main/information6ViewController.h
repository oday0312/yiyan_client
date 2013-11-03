//
//  information6ViewController.h
//  GHSidebarNav
//
//  Created by Apple on 13-7-21.
//
//

#import <UIKit/UIKit.h>
#import "GHRootViewController.h"
#import "ASIHTTPRequest.h"
#import "SLGlowingTextField.h"
#import "UIGlossyButton.h"
@interface information6ViewController :  GHRootViewController<ASIHTTPRequestDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@end
