//
//  paperListViewController.m
//  GHSidebarNav
//
//  Created by Apple on 13-11-3.
//
//

#import "paperListViewController.h"
#import "paperCellViewController.h"
#import "NSString+PDRegex.h"
#import "imageCacheManager.h"
#import "paperDetailWebViewController.h"
#import "DZWebBrowser.h"
@interface paperListViewController ()

@end

@implementation paperListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set defaul string
    
    
    
    // 下拉刷新
    self._header = [[MJRefreshHeaderView alloc] init];
    self._header.delegate = self;
    self._header.scrollView = self.tableview;
    
    // 上拉加载更多
    self._footer = [[MJRefreshFooterView alloc] init];
    self._footer.delegate = self;
    self._footer.scrollView = self.tableview;
    
    // 假数据
    self._data = [NSMutableArray array];
    
    
    
    //get local cache html string
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString* htmlString = [ud valueForKey:self.urlStringHead];
    if (htmlString!=Nil) {
        [self getPagesInformation:htmlString];
        [self.tableview reloadData];
    }
    
    
    
    [self startHttp:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 代理方法-进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH : mm : ss.SSS";
    if (self._header == refreshView) {
       
        
        
        [self startHttp:@""];
        
    } else {
        ///
        IS_loadingMore = 1;
        [self startHttp:@""];
        
    }
    //[NSTimer scheduledTimerWithTimeInterval:1 target:self.tableview selector:@selector(reloadData) userInfo:nil repeats:NO];
}

- (void)dealloc
{
    // 释放资源
    [self._footer free];
    [self._header free];
}

#pragma mark 数据源-代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 让刷新控件恢复默认的状态
    [self._header endRefreshing];
    [self._footer endRefreshing];
    
    return self._data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [@"PushInformationCell" stringByAppendingFormat:@"%d", indexPath.row];
    paperCellViewController *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *aNib = [[NSBundle mainBundle]loadNibNamed:@"paperCellViewController" owner:self options:nil];
        cell = [aNib objectAtIndex:0];
        cell.backgroundColor = [UIColor clearColor];
        [cell.image setContentMode:UIViewContentModeScaleAspectFit];
    }

    NSMutableDictionary* singleData = [self._data objectAtIndex:indexPath.row];
    [imageCacheManager setImageView:cell.image withUrlString:[singleData valueForKey:@"image"]];
    cell.title.text = [singleData valueForKey:@"title"];
    cell.contentString.text = [singleData valueForKey:@"content"];
   
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 113;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    paperDetailWebViewController* detail = [[paperDetailWebViewController alloc] initWithNibName:@"paperDetailWebViewController" bundle:nil];
   
   detail.urlString= [[self._data objectAtIndex:indexPath.row] valueForKey:@"urlstring"];
//    [self.navigationController pushViewController:detail animated:YES];
    
    
    
    
    NSURL *URL = [NSURL URLWithString: detail.urlString];
    
    DZWebBrowser *webBrowser = [[DZWebBrowser alloc] initWebBrowserWithURL:URL];
    webBrowser.showProgress = YES;
    webBrowser.allowSharing = YES;
     webBrowser.resourceBundleName = @"custom-controls";
    UINavigationController *webBrowserNC = [[UINavigationController alloc] initWithRootViewController:webBrowser];
    [self presentViewController:webBrowserNC animated:YES completion:NULL];
}


static int pageIndex = 1;
-(void)startHttp:(NSString*)inputString
{
    if (IS_loadingMore) {
        pageIndex ++;
    }
   
    NSString* urlstring = [@"" stringByAppendingFormat:@"%@/horizontal/%d", self.urlStringHead,pageIndex];
    NSURL *url = [NSURL URLWithString:urlstring];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDelegate:self];
    
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // 当以文本形式读取返回内容时用这个方法
    //NSString *responseString = [request responseString];
    // 当以二进制形式读取返回内容时用这个方法
    //NSData *responseData = [request responseData];
    
    NSString*  responseString =  [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding] ;
    
    NSLog(@"the return is %@", responseString);
    
    
    //////store to local cache html string
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:responseString forKey:self.urlStringHead];
   
    
    
    
    
    [self getPagesInformation:responseString];
    [self.tableview reloadData];
    
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    //NSError *error = [request error];
    //NSLog(@"the return is %@", @"error ");
    
}
static int IS_loadingMore = 0;
-(void)getPagesInformation:(NSString*)inputstring
{
    if (IS_loadingMore==1) {
        IS_loadingMore = 0;
    }
    else{
        [self._data removeAllObjects];
    }
    
    inputstring = [inputstring stringByReplacingOccurrencesOfString:@" " withString:@""];
    inputstring = [inputstring stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    inputstring = [inputstring stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    inputstring = [inputstring stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    inputstring = [inputstring stringByReplacingOccurrencesOfString:@"s_i_articleclearfix" withString:@"\n"];
    
    
    NSLog(@" the new string is %@", inputstring);
    NSArray* pagesArray= [inputstring stringsByExtractingGroupsUsingRegexPattern:@"imageclearfix(.*)</div></"];
    
    
    NSLog(@"the match result count is %i",[pagesArray count]);
    
    if ([pagesArray count]==0) {

    }
    for (unsigned i = 0; i< [pagesArray count]; i++) {
        
        @try {
            NSString* temp = [pagesArray objectAtIndex:i];
            temp = [temp stringByReplacingOccurrencesOfString:@"</a>" withString:@"</a>\n"];
            
            NSLog(@"%@",temp);
            
            NSArray* imageArray= [temp stringsByExtractingGroupsUsingRegexPattern:@"<imgsrc=\"(.*)\"/></"];
            NSLog(@"The image string is %@", [imageArray objectAtIndex:0]);
            
            NSArray* titleArray = [temp stringsByExtractingGroupsUsingRegexPattern:@"title\">.*\">(.*)</a>"];
            NSLog(@"the title string is %@", [titleArray objectAtIndex:0]);
            
            NSArray* contentArray = [temp stringsByExtractingGroupsUsingRegexPattern:@"<divclass=\"text\">(.*)"];
            NSLog(@"the content string is %@", [contentArray objectAtIndex:0]);
            
            NSArray* urlArray = [temp stringsByExtractingGroupsUsingRegexPattern:@"atarget=\"_blank\"href=\"(.*)\">"];
            NSLog(@"the detail url string is %@", [urlArray objectAtIndex:0]);
            
            NSMutableDictionary* singleData = [[NSMutableDictionary alloc] init];
            [singleData setObject:[imageArray objectAtIndex:0] forKey:@"image"];
            [singleData setObject:[titleArray objectAtIndex:0] forKey:@"title"];
            [singleData setObject:[contentArray objectAtIndex:0] forKey:@"content"];
            [singleData setObject:[urlArray objectAtIndex:0] forKey:@"urlstring"];
            
            [self._data addObject:singleData];
            
            NSLog(@"%@",temp);

        }
        @catch (NSException *exception) {
            ;
        }
        
    }
}



@end


