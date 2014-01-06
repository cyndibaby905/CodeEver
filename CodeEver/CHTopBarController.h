//
//  CHTopBarController.h
//  CodeEver
//
//  Created by HangChen on 1/5/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHTopBarViewController;

@protocol CHTopBarControllerDelegate <NSObject>
@optional
- (void)tabBarController:(CHTopBarViewController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index;
@end

@interface CHTopBarController : UIViewController

@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, weak) id <CHTopBarControllerDelegate> delegate;

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setSelectedViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

@interface UIViewController (CHTopBarController)
@property (nonatomic,readonly,retain)CHTopBarViewController *topBarController;
@property (nonatomic,retain)UIBarItem *topBarItem;
@end