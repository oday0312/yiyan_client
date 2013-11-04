//
//  paperCellViewController.h
//  GHSidebarNav
//
//  Created by Apple on 13-11-3.
//
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest/ASIHTTPRequest.h"
@interface paperCellViewController : UITableViewCell
{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *contentString;
@end
