//
//  CHTabBarViewController.h
//  CodeEver
//
//  Created by HangChen on 1/5/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHTabBarViewController;

@protocol CHTabBarViewControllerDelegate <NSObject>
@optional
- (void)tabBarController:(CHTabBarViewController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
@end

@interface CHTabBarViewController : UIViewController

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, weak) id <CHTabBarViewControllerDelegate> delegate;

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setSelectedViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
