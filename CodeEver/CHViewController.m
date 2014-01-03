//
//  CHViewController.m
//  CodeEver
//
//  Created by hangchen on 1/3/14.
//  Copyright (c) 2014 hangchen. All rights reserved.
//

#import "CHViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "CHAuthenticationViewController.h"

@interface CHViewController ()<CHAuthenticationViewControllerDelegate>
- (void)signInAction:(UIButton*)sender;
@end

@implementation CHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[[UIImage imageNamed:@"SignInButton.png"] stretchableImageByCenter] forState:UIControlStateNormal];
        [button setBackgroundImage:[[UIImage imageNamed:@"SigningInButton.png"] stretchableImageByCenter] forState:UIControlStateHighlighted];
        button.frame = CGRectMake((self.view.bounds.size.width - 100)/2, 200, 100, 46);
        [button setTitle:NSLocalizedString(@"Sign in", @"") forState:UIControlStateNormal];
        [button addTarget:self action:@selector(signInAction:) forControlEvents:UIControlEventTouchUpInside];
        button;
    })];
    
    
}

- (void)signInAction:(UIButton*)sender
{
    CHAuthenticationViewController *authViewController = [[CHAuthenticationViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:authViewController];
    [self presentViewController:navController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
