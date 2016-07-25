//
//  LoginViewController.h
//  RandomActsOfKindness
//
//  Created by DetroitLabs on 7/20/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : UIViewController <FBSDKLoginButtonDelegate>
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
-(void)getUserInformation;
@end
