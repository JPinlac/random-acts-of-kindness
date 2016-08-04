//
//  CheckIn.h
//  RandomActsOfKindness
//
//  Created by DetroitLabs on 7/30/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckIn : NSObject
@property NSInteger id;
@property NSDate *time;
@property NSArray *location;
@property NSInteger userId;
@property NSString *descriptionProperty;
@end
