//
//  informatio3ViewController.h
//  GHSidebarNav
//
//  Created by Apple on 13-7-20.
//
//

#import <UIKit/UIKit.h>
#import "GHRootViewController.h"
#import "SLGlowingTextField.h"
#import "UIGlossyButton.h"
#import "ASIHTTPRequest.h"
@interface information3ViewController : GHRootViewController<ASIHTTPRequestDelegate>
{

    
}
@property (weak, nonatomic) IBOutlet SLGlowingTextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIGlossyButton *button1;

- (IBAction)startSearch:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end
