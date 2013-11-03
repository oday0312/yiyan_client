//
//  information4ViewController.m
//  GHSidebarNav
//
//  Created by Apple on 13-7-20.
//
//

#import "information4ViewController.h"
#import "VRGViewController.h"
#import "DataSingleton.h"
#import "NSString+PDRegex.h"
@interface information4ViewController ()

@end

@implementation information4ViewController
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock {
    if (self = [super initWithNibName:@"information4ViewController" bundle:nil]) {
		self.title = title;
		_revealBlock = [revealBlock copy];
		self.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                      target:self
                                                      action:@selector(revealSidebar)];
	}
	return self;
}- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)startPageData
{
    NSMutableString*dateString = [[NSMutableString alloc] init];
    
    
    NSDate * startDate = [[NSDate alloc] init];
    NSCalendar * chineseCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit |
    NSSecondCalendarUnit | NSDayCalendarUnit  |
    NSMonthCalendarUnit | NSYearCalendarUnit;
    
    NSDateComponents * cps = [chineseCalendar components:unitFlags fromDate:startDate];
    NSUInteger hour = [cps hour];
    NSUInteger minute = [cps minute];
    NSUInteger second = [cps second];
    NSUInteger day = [cps day];
    NSUInteger month = [cps month];
    NSUInteger year = [cps year];
    
    NSLog(@"hour=%d, minute=%d, second=%d", hour, minute, second);
    NSLog(@"day=%d, month=%d, year=%d", day, month, year);
    
    
    
    dateString =(NSMutableString*) [@"" stringByAppendingFormat:@"%d%d",month,day];
    
    self.timeLabel.text = [@"" stringByAppendingFormat:@"%d-%d-%d",year,month,day];
    
    
    [self startHttp:dateString];
    [self addAdviewToCurrent];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // All non iPhone-like but nice buttons
	[self.button1 useWhiteLabel: YES];
    self.button1.tintColor = [UIColor darkGrayColor];
    self.resultTextView.text = @"";
    
    
    self.timeLabel.backgroundColor = [UIColor colorWithRed:(38.0f/255.0f) green:(44.0f/255.0f) blue:(58.0f/255.0f) alpha:1.0f];
    self.resultTextView.backgroundColor = [UIColor colorWithRed:(38.0f/255.0f) green:(44.0f/255.0f) blue:(58.0f/255.0f) alpha:1.0f];
    
    
    self.timeLabel.textColor = [UIColor colorWithRed:(154.0f/255.0f) green:(162.0f/255.0f) blue:(176.0f/255.0f) alpha:1.0f];
    
    self.resultTextView.textColor = [UIColor colorWithRed:(154.0f/255.0f) green:(162.0f/255.0f) blue:(176.0f/255.0f) alpha:1.0f];
    
    [self startPageData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([DataSingleton singleton].needRefresh ==1) {
        [DataSingleton singleton].needRefresh=0;
        self.timeLabel.text = [DataSingleton singleton].timeString;
        
        NSArray* tArray = [self.timeLabel.text componentsSeparatedByString:@"-"];
        
        NSString*month = [tArray objectAtIndex:1];
        if ([month characterAtIndex:0]=='0') {
            month = [month substringFromIndex:1];
            NSLog(@"%@",month);
        }
        
        NSString*day = [tArray objectAtIndex:2];
        NSString* tempDateString = [@"" stringByAppendingFormat:@"%@%@",month,day];
        [self startHttp:tempDateString];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectDate:(id)sender {
    VRGViewController *controller = [[VRGViewController alloc] initWithNibName:@"VRGViewController" bundle:nil];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    
}

-(void)startHttp:(NSString*)inputString
{
  
    
    
    NSString* urlstring = [@"" stringByAppendingFormat:@"http://easynote.sinaapp.com/birthday/getcontent.php?day=%@",inputString];
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
    
    NSString*  responseString = [[NSString alloc] initWithData:request.responseData encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    
    NSLog(@"the return is %@", responseString);
    [self getPagesInformation:responseString];
}

- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    //NSError *error = [request error];
    NSLog(@"the return is %@", @"error ");
    
}

-(void)getPagesInformation:(NSString*)inputstring
{
    self.resultTextView.text = @"";
    
    NSArray* pagesArray= [inputstring stringsByExtractingGroupsUsingRegexPattern:@"宫位(.*)"];
    
    
    NSLog(@"the match result count is %i",[pagesArray count]);
    if ([pagesArray count]==0) {
        [DataSingleton singleton].resultstring = (NSMutableString*)@"查询失败，请查看你的输入是否正确";
    }
    for (unsigned i = 0; i< [pagesArray count]; i++) {
        NSString* temp = [pagesArray objectAtIndex:i];
        temp = [temp stringByReplacingRegexPattern:@"<br>" withString:@"\n" caseInsensitive:NO];
        temp = [temp stringByReplacingRegexPattern:@"</p>" withString:@"\n " caseInsensitive:NO];
        temp = [temp stringByReplacingRegexPattern:@"<p>" withString:@" " caseInsensitive:NO];
        
        self.resultTextView.text = (NSMutableString*) temp;
        
        NSLog(@"%@",temp);
        
    }
    
}



- (void)viewDidUnload {
    [self setButton1:nil];
    [self setTimeLabel:nil];
    [self setResultTextView:nil];
    [super viewDidUnload];
}
- (void)revealSidebar {
	_revealBlock();
}
@end
