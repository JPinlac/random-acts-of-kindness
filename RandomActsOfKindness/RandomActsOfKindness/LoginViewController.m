//
//  LoginViewController.m
//  RandomActsOfKindness
//
//  Created by DetroitLabs on 7/20/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createFbButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Facebook button setup

-(void)createFbButton{
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions = @[@"public_profile", @"user_friends"];
    loginButton.center = self.view.center;
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
}

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    [self getUserInformation];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)getUserInformation{
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":@"id, name, picture.width(720).height(720), friends"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             User *user = [User sharedUser];
             NSURL *url = [NSURL URLWithString:[[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"]];
             NSData *data = [NSData dataWithContentsOfURL:url];
             UIImage *img = [[UIImage alloc] initWithData:data];
             user.profilePicture = img;
             user.uid = [result valueForKey:@"id"];
             user.username = [result valueForKey:@"name"];
             
             NSArray *array = [[NSArray alloc] initWithArray:[[result valueForKey:@"friends"] valueForKey:@"data"]];
             user.friends = array;
             NSLog(@"%@", [User sharedUser].friends);
             NSLog(@"fetched user:%@", result);
         }
     }];
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"bye");
}

@end
