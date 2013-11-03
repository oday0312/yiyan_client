//
//  information4ViewController.h
//  GHSidebarNav
//
//  Created by Apple on 13-7-20.
//
//

#import <UIKit/UIKit.h>
#import "GHRootViewController.h"
#import "ASIHTTPRequest.h"
#import "SLGlowingTextField.h"
#import "UIGlossyButton.h"
@interface information4ViewController : GHRootViewController<ASIHTTPRequestDelegate>
{
    
}

- (IBAction)selectDate:(id)sender;

@property (weak, nonatomic) IBOutlet UIGlossyButton *button1;

@property (weak, nonatomic) IBOutlet SLGlowingTextField *timeLabel;

@property (weak, nonatomic) IBOutlet UITextView *resultTextView;

@end
