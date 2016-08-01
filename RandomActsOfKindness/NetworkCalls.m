//
//  NetworkCalls.m
//  RandomActsOfKindness
//
//  Created by DetroitLabs on 7/30/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "NetworkCalls.h"
#import "CheckIn.h"
#import <AFNetworking/AFNetworking.h>

@implementation NetworkCalls

+(NSMutableDictionary *)getAllCheckIns{
    __block NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://api.pinlac.net/checkins"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            dict = responseObject;
//            if([responseObject isKindOfClass:[NSArray class]]){
//                NSLog(@"NSArray");
//            }
//            else if ([responseObject isKindOfClass:[NSDictionary class]]){
//                NSLog(@"Dictionary");
//            }
//            else{
//                NSLog(@"Neither");
//            }
        }
    }];
    [dataTask resume];
    return dict;
}
@end
