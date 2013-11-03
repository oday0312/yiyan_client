//
//  AppDelegate.h
//  meizhouer
//
//  Created by Alex on 3/22/12.
//  Copyright (c) 2012 theindex. All rights reserved.
//#import <Foundation/Foundation.h>

@interface DataSingleton : NSObject{
    NSMutableString* resultstring;
    
    
    ///////birthday
    NSMutableString* timeString;
    int needRefresh;
    
    
    
    
    //////////
    ////////////////////////
    NSMutableString* shortUrl;
    NSData* uploadData;
};

@property(nonatomic,retain) NSData* uploadData;
@property(nonatomic,retain) NSMutableString* shortUrl;


@property(nonatomic,assign)int needRefresh;
@property(nonatomic,retain)NSMutableString* timeString;

@property(nonatomic,retain)NSMutableString* resultstring;
+ (DataSingleton *)singleton;

@end

