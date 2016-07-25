//
//  User.m
//  RandomActsOfKindness
//
//  Created by DetroitLabs on 7/21/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)sharedUser {
    static User *curentUser = nil;
    static dispatch_once_t onePredicate;
    
    dispatch_once(&onePredicate, ^ {
        curentUser = [[User alloc]init];
    });
    
    return curentUser;
}
@end
