//
//  UIImage+Util.h
//  CodeEver
//
//  Created by HangChen on 1/11/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)
-(id)cropImageWithRect:(CGRect)rect;
-(UIImage *)boxblurImageWithBlur:(CGFloat)blur;
@end
