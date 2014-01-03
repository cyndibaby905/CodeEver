//
//  NSString+URLEncoding.h
//  CodeEver
//
//  Created by HangChen on 1/3/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

@interface NSString (DTURLEncoding)


- (NSString *)stringByURLEncoding;
- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding;

@end
