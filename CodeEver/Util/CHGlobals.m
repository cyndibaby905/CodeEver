//
//  CHGlobals.m
//  CodeEver
//
//  Created by HangChen on 1/3/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import "CHGlobals.h"
const NSString *appKey = @"6fcb0526854003406843";
const NSString *secretKey = @"75f368e6cea07c441929b91a0fa813f561b9aebe";
const NSString *redirectURL = @"http://hangchen.info";
const NSString *scope = @"user,public_repo,repo,repo:status,notifications,gist";
const NSString *authURL = @"https://github.com/login/oauth/authorize?client_id=%@&redirect_uri=%@&scope=%@&state=%@";
const NSString *exchangeURL = @"https://github.com/login/oauth/access_token";