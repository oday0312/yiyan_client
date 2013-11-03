//
//  constant.h
//  meizhouer
//
//  Created by Alex on 3/26/12.
//  Copyright (c) 2012 theindex. All rights reserved.
//

#import <Foundation/Foundation.h>








#define SYSTEM_VERSION @"0.3.0"



#define ADMOB_PUBLISH_ID @"a14ff805c200cec"






#define NAV_ITEM_LEFT 1
#define NAV_ITEM_RIGHT 2
#define BUTTON_WIDTH 60.0
#define BUTTON_SEGMENT_WIDTH 51.0
#define CAP_WIDTH 15.0
typedef enum {
    CapLeft          = 0,
    CapMiddle        = 1,
    CapRight         = 2,
    CapLeftAndRight  = 3
} CapLocation;





#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#endif

#define EMPTY_STRING        @""

#define STR(key)            NSLocalizedString(key, nil)

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]



/////////////////////////////////////////////////

@interface constant : NSObject
{
    
}

+(void)AddImageBG:(UIImageView*) pImage angleType:(int) nAngleType isHaveShadow:(bool)bIsHaveShadow;
+(void)AddViewerBG:(UIView*) pImage angleType:(int) nAngleType isHaveShadow:(bool)bIsHaveShadow;



+(void)testRemoteImage;

//+(void) languagePackUpdata;
+(void) AnimatinNavigationShowFrame:(UIView*)NavigationControllerView ;
+(void) AnimatinNavigationHiddenFrame:(UIView*)NavigationControllerView;



+(UIButton*)woodButtonWithText:(NSString*)buttonText stretch:(CapLocation)location addTarget:(id)navigationBar selector:(SEL)mypress type:(NSInteger)leftOrRight;
+(UIBarButtonItem*)woodBarButtonItemWithText:(NSString*)buttonText addTarget:(id)navigationBar selector:(SEL)mypressfunction type:(NSInteger)leftOrRight;
+(void)AddImageBG:(UIImageView*) pImage angleType:(int) nAngleType isHaveShadow:(bool)bIsHaveShadow;
+(void)AddViewerBG:(UIView*) pImage angleType:(int) nAngleType isHaveShadow:(bool)bIsHaveShadow;



@end
