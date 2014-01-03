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
    authViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:authViewController];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)authenticationFinished:(CHAuthenticationViewController*)viewController withCode:(NSString*)str
{
    [viewController dismissViewControllerAnimated:YES completion:^{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];

        NSDictionary *parameters = @{@"client_id": appKey,@"client_secret": secretKey, @"code": str, @"redirect_uri": redirectURL};
        [manager POST:exchangeURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *accessToken = responseObject[@"access_token"];
            NSLog(@"Token:%@", accessToken);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"") message:@"Error occured, please try again" delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
            [alertView show];
        }];
    }];
}

- (void)authenticationFailed:(CHAuthenticationViewController*)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:^{
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"") message:@"Error occured, please try again" delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:nil];
        [alertView show];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
