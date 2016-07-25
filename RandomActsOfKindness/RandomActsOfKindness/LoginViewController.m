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
    // Do any additional setup after loading the view.
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions = @[@"public_profile", @"user_friends"];
    loginButton.center = self.view.center;
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
  
    [self getUserInformation];
    //    [FBSDKAccessToken ]
    [User sharedUser].token = result.token;
//    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)getUserInformation{
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields":@"id, name, picture.width(720).height(720)"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSLog(@"fetched user:%@", result);
         }
     }];
}
- (IBAction)getInfo:(id)sender {
    [self getUserInformation];
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"bye");
}

@end
