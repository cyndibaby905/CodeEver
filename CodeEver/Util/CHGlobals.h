//
//  CHGlobals.h
//  CodeEver
//
//  Created by HangChen on 1/3/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import <Foundation/Foundation.h>
extern const NSString *appKey;
extern const NSString *secretKey;
extern NSString *redirectURL;
extern const NSString *scope;
extern NSString *authURL;
extern NSString *exchangeURL;
#define is_iOS7 ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)