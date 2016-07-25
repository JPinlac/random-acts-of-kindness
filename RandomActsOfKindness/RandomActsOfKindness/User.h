//
//  User.h
//  RandomActsOfKindness
//
//  Created by DetroitLabs on 7/21/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface User : NSObject

@property NSString *username;
@property FBSDKAccessToken *token;
@property UIImage *profilePicture;
+ (instancetype)sharedUser;

@end
