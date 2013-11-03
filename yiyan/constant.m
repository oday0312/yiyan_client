//
//  constant.m
//  meizhouer
//
//  Created by Alex on 3/26/12.
//  Copyright (c) 2012 theindex. All rights reserved.
//

#import "constant.h"
#import "DataSingleton.h"
#import <QuartzCore/QuartzCore.h>
/////////////////////////////////////////////////
@implementation constant









//int nType;
//1,round
//2,square 
+(void)AddImageBG:(UIImageView*) pImage angleType:(int) nAngleType isHaveShadow:(bool)bIsHaveShadow
{
    if(bIsHaveShadow)
    {
        [[pImage layer] setShadowOffset:CGSizeMake(2, 2)];
        [[pImage layer] setShadowRadius:2];
        [[pImage layer] setShadowOpacity:1];
        [[pImage layer] setShadowColor:[UIColor blackColor].CGColor];
    }
    
    if(nAngleType == 1)
    {
        pImage.layer.cornerRadius = 2.0;
    }
    else if(nAngleType == 2)
    {
        pImage.layer.cornerRadius = 0.0;
    }
    if(!bIsHaveShadow)
        pImage.layer.masksToBounds = YES;
    pImage.layer.borderWidth = 2.0;
    pImage.layer.borderColor = [[UIColor whiteColor] CGColor];
}
//int nType;
//1,round
//2,square 
+(void)AddViewerBG:(UIView*) pImage angleType:(int) nAngleType isHaveShadow:(bool)bIsHaveShadow
{
    if(bIsHaveShadow)
    {
        [[pImage layer] setShadowOffset:CGSizeMake(2, 2)];
        [[pImage layer] setShadowRadius:2];
        [[pImage layer] setShadowOpacity:1];
        [[pImage layer] setShadowColor:[UIColor blackColor].CGColor];
    }
    
    if(nAngleType == 1)
    {
        pImage.layer.cornerRadius = 2.0;
    }
    else if(nAngleType == 2)
    {
        pImage.layer.cornerRadius = 0.0;
    }
    if(!bIsHaveShadow)
        pImage.layer.masksToBounds = YES;
    pImage.layer.borderWidth = 2.0;
    pImage.layer.borderColor = [[UIColor whiteColor] CGColor];
}
+(void) AnimatinNavigationShowFrame:(UIView*)NavigationControllerView 
{
    [UIView animateWithDuration:0.3 
                     animations:^{
                         NavigationControllerView.frame = CGRectMake(0, 
                                                                     0,
                                                                     320,
                                                                     44                                                         );
                     } 
                     completion:^(BOOL finished){
                         
                     }];
    
    
}
+(void) AnimatinNavigationHiddenFrame:(UIView*)NavigationControllerView
{
    [UIView animateWithDuration:0.3 
                     animations:^{
                         NavigationControllerView.frame = CGRectMake(0, 
                                                                     -44,
                                                                     320,
                                                                     44                                                         );
                     } 
                     completion:^(BOOL finished){
                         
                     }];
    
    
}




+(UIBarButtonItem*)woodBarButtonItemWithText:(NSString*)buttonText addTarget:(id)navigationBar selector:(SEL)mypressfunction type:(NSInteger)leftOrRight
{
    return [[[UIBarButtonItem alloc] initWithCustomView:[self woodButtonWithText:buttonText stretch:CapLeftAndRight addTarget:navigationBar selector:mypressfunction type:leftOrRight]] autorelease];
}




+(UIButton*)woodButtonWithText:(NSString*)buttonText stretch:(CapLocation)location addTarget:(id)navigationBar selector:(SEL)mypress type:(NSInteger)leftOrRight
{
    UIImage* buttonImage = nil;
    UIImage* buttonPressedImage = nil;
    NSUInteger buttonWidth = 0;
    if (location == CapLeftAndRight)
    {
        if (buttonText.length <= 6) {
            buttonWidth = BUTTON_WIDTH;
        }else
        {
            buttonWidth = BUTTON_WIDTH + (buttonText.length -6 )*8;
        }
        
        
        if (leftOrRight == NAV_ITEM_LEFT) {
            buttonImage = [[UIImage imageNamed:@"navigationBarBackButton.png"] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0];
            buttonPressedImage = [[UIImage imageNamed:@"navigationBarBackButton.png"] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0];
        }else
        {
            buttonImage = [[UIImage imageNamed:@"nav-button.png"] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0 ];
            buttonPressedImage = [[UIImage imageNamed:@"nav-button.png"] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0 ];
        }
        
    }else{
        buttonImage=[UIImage imageNamed:@""];
    }
     
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, buttonWidth, buttonImage.size.height);
    button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.shadowOffset = CGSizeMake(0,-1);
    button.titleLabel.shadowColor = [UIColor darkGrayColor];
    
    [button setTitle:buttonText forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = NO;
    
    [button addTarget:navigationBar action:mypress forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


@end

/////////////////////////////////////////////////


