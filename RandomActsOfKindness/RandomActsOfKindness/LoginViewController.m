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
#import "CAGradientLayer+_colors.h"
#import "ScannerViewController.h"

@interface LoginViewController ()
@end

@implementation LoginViewController

bool loggedIn = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createFbButton];
    [self doBackgroundColorAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View customization

-(void)customizeView{

}


- (void) doBackgroundColorAnimation {
    static NSInteger i = 0;
    NSArray *colors = [NSArray arrayWithObjects:[UIColor colorWithRed:0.87 green:0.38 blue:0.38 alpha:1.0],
                       [UIColor colorWithRed:1.00 green:0.72 blue:0.55 alpha:1.0],
                       [UIColor colorWithRed:0.24 green:0.49 blue:0.67 alpha:1.0],
                       [UIColor colorWithRed:1.00 green:0.89 blue:0.48 alpha:1.0],
                       [UIColor colorWithRed:0.99 green:0.21 blue:0.30 alpha:1.0],
                       [UIColor colorWithRed:0.04 green:0.75 blue:0.74 alpha:1.0],
                       [UIColor colorWithRed:0.28 green:0.46 blue:0.90 alpha:1.0],
                       [UIColor colorWithRed:0.56 green:0.33 blue:0.91 alpha:1.0],
                       [UIColor colorWithRed:0.86 green:0.21 blue:0.64 alpha:1.0],
                       [UIColor colorWithRed:0.00 green:0.79 blue:1.00 alpha:1.0],
                       [UIColor colorWithRed:0.57 green:1.00 blue:0.62 alpha:1.0],
                       nil];
    
    if(i >= [colors count]) {
        i = 0;
    }
    
    [UIView animateWithDuration:2.0f delay: 0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.view.backgroundColor = [colors objectAtIndex:i];
    } completion:^(BOOL finished) {
        ++i;
        if(loggedIn){
            return;
        }
        [self doBackgroundColorAnimation];
    }];
    
}

#pragma mark - Facebook button setup

-(void)createFbButton{
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions = @[@"public_profile", @"user_friends"];
    loginButton.delegate = self;
    CGRect btFrame = loginButton.frame;
    btFrame.origin.x = (self.view.frame.size.width - loginButton.frame.size.width)/2;
    btFrame.origin.y = (self.view.frame.size.height/2) * 1.5;
    loginButton.frame = btFrame;
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
             [self logUser];
         }
     }];
}
-(void)logUser{
    
}
- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"bye");
}

@end
