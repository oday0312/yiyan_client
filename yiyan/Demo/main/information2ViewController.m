//
//  information2ViewController.m
//  GHSidebarNav
//
//  Created by Apple on 13-7-20.
//
//

#import "information2ViewController.h"
#import "GHRootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NSString+PDRegex.h"
@interface information2ViewController ()

@end

@implementation information2ViewController
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock {
    if (self = [super initWithNibName:@"information2ViewController" bundle:nil]) {
		self.title = title;
		_revealBlock = [revealBlock copy];
		self.navigationItem.leftBarButtonItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                      target:self
                                                      action:@selector(revealSidebar)];
	}
	return self;
}

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
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self                 action:@selector(singleTapAction)];
    [self.view addGestureRecognizer:singleTap];
    
    self.resultLabel.backgroundColor =[UIColor colorWithRed:(38.0f/255.0f) green:(44.0f/255.0f) blue:(58.0f/255.0f) alpha:1.0f];
    self.resultLabel.textColor = [UIColor colorWithRed:(154.0f/255.0f) green:(162.0f/255.0f) blue:(176.0f/255.0f) alpha:1.0f];
    self.resultLabel.layer.cornerRadius = 4.0;
    self.resultLabel.font = [UIFont systemFontOfSize:15.0];
    self.resultLabel.text = @"";
    
    
    self.inputTextField.text = @"请输入要查询的手机号码";
    
    self.inputTextField.backgroundColor =  [UIColor colorWithRed:(38.0f/255.0f) green:(44.0f/255.0f) blue:(58.0f/255.0f) alpha:1.0f];
    self.inputTextField.textColor = [UIColor colorWithRed:(154.0f/255.0f) green:(162.0f/255.0f) blue:(176.0f/255.0f) alpha:1.0f];
    [self.inputTextField setClearsOnBeginEditing:YES];
    // Do any additional setup after loading the view from its nib.
    
    // All non iPhone-like but nice buttons
	[self.button1 useWhiteLabel: YES];
    self.button1.tintColor = [UIColor darkGrayColor];
	[self addAdviewToCurrent];
    
}
-(void)singleTapAction
{
    // 这里添加点击后要做的事情
    //resign
    [self.inputTextField endEditing:YES
     ];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)revealSidebar {
	_revealBlock();
}

- (void)viewDidUnload {
    [self setInputTextField:nil];
    [self setButton1:nil];
    [self setResultLabel:nil];
    [super viewDidUnload];
}



-(void)startHttp:(NSString*)inputString
{
    
    ///////http://www.ip.cn/getm.php?q=13911650018&from=web
    if ([inputString isEqualToString:@"a"]) {
        inputString =@"13911650018";
    }
    NSString* urlstring = [@"" stringByAppendingFormat:@"http://www.ip.cn/getm.php?q=%@&from=web",inputString];
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

- (IBAction)startSearch:(id)sender {
    
    [self startHttp:self.inputTextField.text];
}

-(void)getPagesInformation:(NSString*)inputstring
{
    
    self.resultLabel.text = @"";
    /////get the detail link url;
    //[[DataSingleton singleton].LevelA_pages removeAllObjects];
    
    
    NSArray* pagesArray= [inputstring stringsByExtractingGroupsUsingRegexPattern:@"</code>(.*)</div>"];
    
    
    NSLog(@"the match result count is %i",[pagesArray count]);
    
    if ([pagesArray count]==0) {
       self.resultLabel.text = (NSMutableString*)@"查询失败，请查看你的输入是否正确";
    }
    for (unsigned i = 0; i< [pagesArray count]; i++) {
        NSString* temp = [pagesArray objectAtIndex:i];
        temp = [temp stringByReplacingRegexPattern:@"&nbsp;" withString:@" " caseInsensitive:NO];
        
        self.resultLabel.text =(NSMutableString*) temp;
        
        NSLog(@"%@",temp);
        
    }
}



@end
