//
//  UIImage+Stretch.h
//  CodeEver
//
//  Created by hangchen on 1/3/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Stretch)

- (UIImage *)stretchableImageByCenter;
- (UIImage *)stretchableImageByHeightCenter;
- (UIImage *)stretchableImageByWidthCenter;

@end
