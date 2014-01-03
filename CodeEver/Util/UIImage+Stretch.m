//
//  UIImage+Stretch.m
//  CodeEver
//
//  Created by hangchen on 1/3/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import "UIImage+Stretch.h"

@implementation UIImage (Stretch)

- (UIImage *)stretchableImageByCenter
{
	CGFloat leftCapWidth = floorf(self.size.width / 2);
	if (leftCapWidth == self.size.width / 2)
	{
		leftCapWidth--;
	}
	
	CGFloat topCapHeight = floorf(self.size.height / 2);
	if (topCapHeight == self.size.height / 2)
	{
		topCapHeight--;
	}
	
	return [self stretchableImageWithLeftCapWidth:leftCapWidth 
									 topCapHeight:topCapHeight];
}

- (UIImage *)stretchableImageByHeightCenter
{
	CGFloat topCapHeight = floorf(self.size.height / 2);
	if (topCapHeight == self.size.height / 2)
	{
		topCapHeight--;
	}
	
	return [self stretchableImageWithLeftCapWidth:0
									 topCapHeight:topCapHeight];
}

- (UIImage *)stretchableImageByWidthCenter
{
	CGFloat leftCapWidth = floorf(self.size.width / 2);
	if (leftCapWidth == self.size.width / 2)
	{
		leftCapWidth--;
	}
	
	return [self stretchableImageWithLeftCapWidth:leftCapWidth 
									 topCapHeight:0];
}

@end
