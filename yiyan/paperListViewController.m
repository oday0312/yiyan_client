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
        for (int i = 0; i<5; i++) {
            [self._data insertObject:[formatter stringFromDate:[NSDate date]] atIndex:0];
        }
        
        
        [self startHttp:@""];
        
    } else {
        for (int i = 0; i<5; i++) {
            [self._data addObject:[formatter stringFromDate:[NSDate date]]];
        }
    }
    [NSTimer scheduledTimerWithTimeInterval:1 target:self.tableview selector:@selector(reloadData) userInfo:nil repeats:NO];
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
    }

    
   
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 113;
}





-(void)startHttp:(NSString*)inputString
{
    
   
    NSString* urlstring = [@"" stringByAppendingFormat:@"http://select.yeeyan.org/lists/social/horizontal/1"];
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
    [self getPagesInformation:responseString];
}

- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    NSError *error = [request error];
    NSLog(@"the return is %@", @"error ");
    
}
static int IS_loadingMore = 0;
-(void)getPagesInformation:(NSString*)inputstring
{
    
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
        NSString* temp = [pagesArray objectAtIndex:i];
        temp = [temp stringByReplacingOccurrencesOfString:@"</a>" withString:@"</a>\n"];
        
        NSLog(@"%@",temp);
        
        NSArray* imageArray= [temp stringsByExtractingGroupsUsingRegexPattern:@"<imgsrc=(.*)/></"];
        NSLog(@"The image string is %@", [imageArray objectAtIndex:0]);
        
        NSArray* titleArray = [temp stringsByExtractingGroupsUsingRegexPattern:@"title\">.*\">(.*)</a>"];
        NSLog(@"the title string is %@", [titleArray objectAtIndex:0]);
        
        NSArray* contentArray = [temp stringsByExtractingGroupsUsingRegexPattern:@"<divclass=\"text\">(.*)"];
        NSLog(@"the content string is %@", [contentArray objectAtIndex:0]);
        
        NSArray* urlArray = [temp stringsByExtractingGroupsUsingRegexPattern:@"atarget=\"_blank\"href=(.*)\">"];
        NSLog(@"the detail url string is %@", [urlArray objectAtIndex:0]);
        
        
               NSLog(@"%@",temp);
        
    }
}



@end




//
//-(void)startHttp:(NSString*)inputString
//{
//    
//    ///////
//    NSString *postURL = [NSString stringWithFormat:@"http://sfz.8684.cn/"];
//    
//    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:postURL]];
//    
//    if ([inputString isEqualToString:@"a"]) {
//        [request addPostValue:@"43010419860419588X" forKey:@"userid"];
//    }
//    else{
//        [request addPostValue:inputString forKey:@"userid"];
//        
//    }
//    
//    request.delegate= self;
//    [request startSynchronous];
//}
