//
//  CheckIn.h
//  RandomActsOfKindness
//
//  Created by DetroitLabs on 7/30/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CheckIn : NSObject <MKAnnotation>
@property NSInteger id;
@property NSDate *time;
@property (nonatomic) CLLocationCoordinate2D coordinate;
//@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property NSInteger userId;
@property NSString *descriptionProperty;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@end
