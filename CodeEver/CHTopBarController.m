//
//  CHTopBarController.m
//  CodeEver
//
//  Created by HangChen on 1/5/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import "CHTopBarController.h"
#import <objc/runtime.h>

@interface CHTopBarController ()
- (void)topButtonPressed:(UIButton *)sender;
- (void)selectTopButton:(UIButton *)button;
- (void)deselectTopButton:(UIButton *)button;
@end

#define CHTopBarOffset (is_iOS7?20:0)
#define CHTopBarHeight (is_iOS7?44+CHTopBarOffset:44)
#define CHTopBarBackgroundColor [UIColor colorWithRed:45/255.0f green:68/255.0f blue:94/255.0f alpha:1.0]
#define CHTopBarUnSelectedColor [UIColor colorWithRed:136/255.0f green:175/255.0f blue:175/255.0f alpha:1.0f]
#define CHTopBarSelectedColor [UIColor whiteColor]

@implementation CHTopBarController
{
	UIView *topButtonsContainerView;
	UIView *contentContainerView;
	UIImageView *indicatorView;
    NSMutableArray *topButtons;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
	CGRect rect = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, CHTopBarHeight);
	
	[self.view addSubview:({
        if (is_iOS7) {
            UIToolbar *tempView = [[UIToolbar alloc] initWithFrame:rect];
            tempView.barStyle = UIBarStyleBlack;
            tempView.translucent = YES;
            tempView.barTintColor = CHTopBarBackgroundColor;
            
            tempView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            topButtonsContainerView = tempView;
        }
        else {
            UIView *tempView = [[UIView alloc] initWithFrame:rect];
          
            tempView.backgroundColor = CHTopBarBackgroundColor;
            
            tempView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            topButtonsContainerView = tempView;
        }
        topButtonsContainerView;
    })];
    
	rect.origin.y = CHTopBarHeight;
	rect.size.height = self.view.bounds.size.height - CHTopBarHeight;
	contentContainerView = [[UIView alloc] initWithFrame:rect];
	contentContainerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:contentContainerView];
    
	indicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topBar_Indicator.png"]];
	[self.view addSubview:indicatorView];
    topButtons = [[NSMutableArray alloc] init];
	[self reloadTopButtons];
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	[self layoutTopButtons];
}

- (void)reloadTopButtons
{
    [topButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [topButtons removeAllObjects];
    
	for (UIViewController *viewController in self.viewControllers)
	{
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        
		[button setTitle:viewController.topBarItem.title forState:UIControlStateNormal];
		[button setImage:viewController.topBarItem.image forState:UIControlStateNormal];
		[button addTarget:self action:@selector(topButtonPressed:) forControlEvents:UIControlEventTouchDown];
		[self deselectTopButton:button];
		[topButtonsContainerView addSubview:button];
        [topButtons addObject:button];
	}
    
	NSUInteger lastIndex = _selectedIndex;
	_selectedIndex = NSNotFound;
	self.selectedIndex = lastIndex;
}


- (void)layoutTopButtons
{
    
	NSUInteger index = 0;
	NSUInteger count = [self.viewControllers count];
    
	CGRect rect = CGRectMake(0.0f, CHTopBarOffset, floorf(self.view.bounds.size.width / count), CHTopBarHeight - CHTopBarOffset);
    
	indicatorView.hidden = YES;

	for (UIButton *button in topButtons)
	{
		if (index == count - 1)
			rect.size.width = self.view.bounds.size.width - rect.origin.x;
        
		button.frame = rect;
		rect.origin.x += rect.size.width;
        
		if (index == self.selectedIndex)
			[self centerIndicatorOnButton:button];
        
		++index;
	}
}

- (void)centerIndicatorOnButton:(UIButton *)button
{
	CGRect rect = indicatorView.frame;
	rect.origin.x = button.center.x - floorf(indicatorView.frame.size.width/2.0f);
	rect.origin.y = CHTopBarHeight - indicatorView.frame.size.height;
	indicatorView.frame = rect;
	indicatorView.hidden = NO;
}

- (void)setViewControllers:(NSArray *)newViewControllers
{
	NSAssert([newViewControllers count] >= 2, @"CHTopBarController requires at least two view controllers");
    
	UIViewController *oldSelectedViewController = self.selectedViewController;
    
	for (UIViewController *viewController in _viewControllers)
	{
		[viewController willMoveToParentViewController:nil];
		[viewController removeFromParentViewController];
	}
    
	_viewControllers = [newViewControllers copy];
    
    NSUInteger newIndex = [_viewControllers indexOfObject:oldSelectedViewController];
	if (newIndex != NSNotFound)
		_selectedIndex = newIndex;
	else if (newIndex < [_viewControllers count])
		_selectedIndex = newIndex;
	else
		_selectedIndex = 0;
    
	for (UIViewController *viewController in _viewControllers)
	{
		[self addChildViewController:viewController];
		[viewController didMoveToParentViewController:self];
	}
    
	if ([self isViewLoaded])
		[self reloadTopButtons];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex
{
	[self setSelectedIndex:newSelectedIndex animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)newSelectedIndex animated:(BOOL)animated
{
	NSAssert(newSelectedIndex < [self.viewControllers count], @"index out of bounds");

    
	if (![self isViewLoaded])
	{
		_selectedIndex = newSelectedIndex;
	}
	else if (_selectedIndex != newSelectedIndex)
	{
		UIViewController *fromViewController;
		UIViewController *toViewController;
        
		if (_selectedIndex != NSNotFound)
		{
			UIButton *fromButton = topButtons[_selectedIndex];
			[self deselectTopButton:fromButton];
			fromViewController = self.selectedViewController;
		}
        
		NSUInteger oldSelectedIndex = _selectedIndex;
		_selectedIndex = newSelectedIndex;
        
		UIButton *toButton;
		if (_selectedIndex != NSNotFound)
		{
			toButton = topButtons[_selectedIndex];
			[self selectTopButton:toButton];
			toViewController = self.selectedViewController;
		}
        
		if (toViewController == nil)
		{
			[fromViewController.view removeFromSuperview];
		}
		else if (fromViewController == nil)
		{
			toViewController.view.frame = contentContainerView.bounds;
			[contentContainerView addSubview:toViewController.view];
			[self centerIndicatorOnButton:toButton];
            
			if ([self.delegate respondsToSelector:@selector(topBarController:didSelectViewController:atIndex:)]) {
                [self.delegate topBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
            }
            
		}
		else if (animated)
		{
			CGRect rect = contentContainerView.bounds;
			if (oldSelectedIndex < newSelectedIndex)
				rect.origin.x = rect.size.width;
			else
				rect.origin.x = -rect.size.width;
            
			toViewController.view.frame = rect;
			topButtonsContainerView.userInteractionEnabled = NO;
            
			[self transitionFromViewController:fromViewController
                              toViewController:toViewController
                                      duration:0.3f
                                       options:UIViewAnimationOptionLayoutSubviews | UIViewAnimationOptionCurveEaseInOut
                                    animations:^
             {
                 CGRect rect = fromViewController.view.frame;
                 if (oldSelectedIndex < newSelectedIndex)
                     rect.origin.x = -rect.size.width;
                 else
                     rect.origin.x = rect.size.width;
                 
                 fromViewController.view.frame = rect;
                 toViewController.view.frame = contentContainerView.bounds;
                 [self centerIndicatorOnButton:toButton];
             }
                                    completion:^(BOOL finished)
             {
                 topButtonsContainerView.userInteractionEnabled = YES;
                 
                 if ([self.delegate respondsToSelector:@selector(topBarController:didSelectViewController:atIndex:)]) {
                     [self.delegate topBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
                 }
             }];
		}
		else
		{
			[fromViewController.view removeFromSuperview];
            
			toViewController.view.frame = contentContainerView.bounds;
			[contentContainerView addSubview:toViewController.view];
			[self centerIndicatorOnButton:toButton];
            
			if ([self.delegate respondsToSelector:@selector(topBarController:didSelectViewController:atIndex:)]) {
                [self.delegate topBarController:self didSelectViewController:toViewController atIndex:newSelectedIndex];
            }
		}
	}
}

- (UIViewController *)selectedViewController
{
	if (self.selectedIndex != NSNotFound)
		return (self.viewControllers)[self.selectedIndex];
	else
		return nil;
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController
{
	[self setSelectedViewController:newSelectedViewController animated:NO];
}

- (void)setSelectedViewController:(UIViewController *)newSelectedViewController animated:(BOOL)animated
{
	NSUInteger index = [self.viewControllers indexOfObject:newSelectedViewController];
	if (index != NSNotFound)
		[self setSelectedIndex:index animated:animated];
}

- (void)topButtonPressed:(UIButton *)sender
{
	[self setSelectedIndex:[topButtons indexOfObject:sender] animated:YES];
}


- (void)selectTopButton:(UIButton *)button
{
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)deselectTopButton:(UIButton *)button
{
	[button setTitleColor:CHTopBarUnSelectedColor forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

static char UITopBarViewController;
static char UITopBarItem;

@implementation UIViewController (CHTopBarController)

- (void)setTopBarController:(CHTopBarController *)controller {
    [self willChangeValueForKey:@"topBarController"];
    objc_setAssociatedObject(self, &UITopBarViewController,
                             controller,
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"topBarController"];
}

- (CHTopBarController *)topBarController {
    return objc_getAssociatedObject(self, &UITopBarViewController);
}


- (void)setTopBarItem:(CHTopBarItem *)item {
    [self willChangeValueForKey:@"topBarItem"];
    objc_setAssociatedObject(self, &UITopBarItem,
                             item,
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"topBarItem"];
}

- (CHTopBarItem *)topBarItem {
    CHTopBarItem *item = objc_getAssociatedObject(self, &UITopBarItem);
    if (!item) {
        item = [[CHTopBarItem alloc] init];
        [self setTopBarItem:item];
    }
    return item;
}


@end


@implementation CHTopBarItem



@end
