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

@end

@implementation CHTopBarController
{
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

static char UITopBarViewController;
static char UITopBarItem;

@implementation UIViewController (CHTopBarController)

- (void)setTopBarController:(CHTopBarViewController *)controller {
    [self willChangeValueForKey:@"topBarController"];
    objc_setAssociatedObject(self, &UITopBarViewController,
                             controller,
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"topBarController"];
}

- (CHTopBarViewController *)topBarController {
    return objc_getAssociatedObject(self, &UITopBarViewController);
}


- (void)setTopBarItem:(UIBarItem *)item {
    [self willChangeValueForKey:@"topBarItem"];
    objc_setAssociatedObject(self, &UITopBarItem,
                             item,
                             OBJC_ASSOCIATION_RETAIN);
    [self didChangeValueForKey:@"topBarItem"];
}

- (UIBarItem *)topBarItem {
    return objc_getAssociatedObject(self, &UITopBarItem);
}

//UIBarItem *topBarItem;

@end