//
//  CHAuthenticationViewController.h
//  CodeEver
//
//  Created by hangchen on 1/3/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHAuthenticationViewController;
@protocol CHAuthenticationViewControllerDelegate<NSObject>
@optional
- (void)authenticationCancled:(CHAuthenticationViewController*)viewController;
- (void)authenticationFinished:(CHAuthenticationViewController*)viewController withRedirectURLString:(NSString*)str;
@end

@interface CHAuthenticationViewController : CHBaseViewController
@property(nonatomic, weak)id<CHAuthenticationViewControllerDelegate>delegate;
@end
