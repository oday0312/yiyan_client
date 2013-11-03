//
//  paperListViewController.h
//  GHSidebarNav
//
//  Created by Apple on 13-11-3.
//
//

#import <UIKit/UIKit.h>
#import "MJRefreshFooterView.h"
#import "MJRefreshHeaderView.h"
#import "GHRootViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface paperListViewController : GHRootViewController
<UITableViewDataSource, UITableViewDelegate,MJRefreshBaseViewDelegate,ASICacheDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(nonatomic, retain) MJRefreshFooterView *_footer;
@property(nonatomic, retain) MJRefreshHeaderView *_header;

@property(nonatomic, retain) NSMutableArray *_data;
@end
