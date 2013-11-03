//
//  information1ViewController.m
//  GHSidebarNav
//
//  Created by Apple on 13-7-20.
//
//

#import "information1ViewController.h"
#import "GHRootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "NSString+PDRegex.h"
@interface information1ViewController ()

@end

@implementation information1ViewController
- (id)initWithTitle:(NSString *)title withRevealBlock:(RevealBlock)revealBlock {
    if (self = [super initWithNibName:@"information1ViewController" bundle:nil]) {
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
    
    
    self.inputTextField.text = @"请输入要查询的身份证号码";
    
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
    
    ///////
    NSString *postURL = [NSString stringWithFormat:@"http://sfz.8684.cn/"];
    
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:postURL]];
    
    if ([inputString isEqualToString:@"a"]) {
        [request addPostValue:@"43010419860419588X" forKey:@"userid"];
    }
    else{
        [request addPostValue:inputString forKey:@"userid"];

    }
    
    request.delegate= self;
    [request startSynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // 当以文本形式读取返回内容时用这个方法
    //NSString *responseString = [request responseString];
    // 当以二进制形式读取返回内容时用这个方法
    //NSData *responseData = [request responseData];
        
      NSString*  responseString = [[NSString alloc] initWithData:[request responseData] encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
  
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
    inputstring = [inputstring stringByReplacingRegexPattern:@"</option>" withString:@"</option>\n" caseInsensitive:NO];
    NSArray* pagesArray= [inputstring stringsByExtractingGroupsUsingRegexPattern:@"地区:(.*)"];
    
    
    
    
    
    
    
    NSLog(@"the match result count is %i",[pagesArray count]);
    if ([pagesArray count]==0) {
        self.resultLabel.text = (NSMutableString*)@"查询失败，请查看你的输入是否正确";
    }
    
    
    for (unsigned i = 0; i< [pagesArray count]; i++) {
        NSString* temp = [pagesArray objectAtIndex:i];
        temp = [temp stringByReplacingRegexPattern:@"<br>" withString:@"\n" caseInsensitive:NO];
        temp = [temp stringByReplacingRegexPattern:@"<br />" withString:@"\n" caseInsensitive:NO];
        temp = [temp stringByReplacingRegexPattern:@"</font>" withString:@"" caseInsensitive:NO];
        temp = [temp stringByReplacingRegexPattern:@"<font.*>" withString:@"" caseInsensitive:NO];
        
        //[DataSingleton singleton].resultstring = (NSMutableString*)temp;
        
        NSLog(@"%@",temp);
        self.resultLabel.text = temp;
        
    }
    
}



@end
