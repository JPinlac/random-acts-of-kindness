//
//  CAGradientLayer+_colors.m
//  RandomActsOfKindness
//
//  Created by DetroitLabs on 7/28/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CAGradientLayer+_colors.h"

@implementation CAGradientLayer (_colors)

+ (CAGradientLayer *)peach{
    UIColor *topColor = [UIColor colorWithRed:0.87 green:0.38 blue:0.38 alpha:1.0];
    UIColor *bottomColor = [UIColor colorWithRed:1.00 green:0.72 blue:0.55 alpha:1.0];
    
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    NSArray *gradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithInt:0.0],[NSNumber numberWithInt:1.0], nil];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = gradientLocations;
//    gradientLayer.startPoint = CGPointMake(.25,0);
//    gradientLayer.endPoint = CGPointMake(.75,1);
    return gradientLayer;
}

+ (CAGradientLayer *)sunshine{
    UIColor *bottomColor = [UIColor colorWithRed:0.24 green:0.49 blue:0.67 alpha:1.0];
    UIColor *topColor = [UIColor colorWithRed:1.00 green:0.89 blue:0.48 alpha:1.0];
    
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    NSArray *gradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithInt:0.0],[NSNumber numberWithInt:1.0], nil];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = gradientLocations;
//    gradientLayer.startPoint = CGPointMake(.25,0);
//    gradientLayer.endPoint = CGPointMake(.75,1);
    return gradientLayer;
}

+ (CAGradientLayer *)redVBlue{
    UIColor *bottomColor = [UIColor colorWithRed:0.99 green:0.21 blue:0.30 alpha:1.0];
    UIColor *topColor = [UIColor colorWithRed:0.04 green:0.75 blue:0.74 alpha:1.0];
    
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    NSArray *gradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithInt:0.0],[NSNumber numberWithInt:1.0], nil];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = gradientLocations;
    //    gradientLayer.startPoint = CGPointMake(.25,0);
    //    gradientLayer.endPoint = CGPointMake(.75,1);
    return gradientLayer;
}

+ (CAGradientLayer *)violet{
    UIColor *bottomColor = [UIColor colorWithRed:0.28 green:0.46 blue:0.90 alpha:1.0];
    UIColor *topColor = [UIColor colorWithRed:0.56 green:0.33 blue:0.91 alpha:1.0];
    
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    NSArray *gradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithInt:0.0],[NSNumber numberWithInt:1.0], nil];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = gradientLocations;
    //    gradientLayer.startPoint = CGPointMake(.25,0);
    //    gradientLayer.endPoint = CGPointMake(.75,1);
    return gradientLayer;
}

+ (CAGradientLayer *)orange{
    UIColor *bottomColor = [UIColor colorWithRed:0.97 green:1.00 blue:0.00 alpha:1.0];
    UIColor *topColor = [UIColor colorWithRed:0.86 green:0.21 blue:0.64 alpha:1.0];
    
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    NSArray *gradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithInt:0.0],[NSNumber numberWithInt:1.0], nil];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = gradientLocations;
    //    gradientLayer.startPoint = CGPointMake(.25,0);
    //    gradientLayer.endPoint = CGPointMake(.75,1);
    return gradientLayer;
}

+ (CAGradientLayer *)green{
    UIColor *bottomColor = [UIColor colorWithRed:0.00 green:0.79 blue:1.00 alpha:1.0];
    UIColor *topColor = [UIColor colorWithRed:0.57 green:1.00 blue:0.62 alpha:1.0];
    NSArray *gradientColors = [NSArray arrayWithObjects:(id)topColor.CGColor, (id)bottomColor.CGColor, nil];
    NSArray *gradientLocations = [NSArray arrayWithObjects:[NSNumber numberWithInt:0.0],[NSNumber numberWithInt:1.0], nil];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = gradientColors;
    gradientLayer.locations = gradientLocations;
    //    gradientLayer.startPoint = CGPointMake(.25,0);
    //    gradientLayer.endPoint = CGPointMake(.75,1);
    return gradientLayer;
}

+ (CAGradientLayer *)random{
    int number = arc4random_uniform(5);
    switch (number) {
        case 0:
            return [self peach];
            break;
        case 1:
            return [self sunshine];
            break;
        case 2:
            return [self redVBlue];
            break;
        case 3:
            return [self orange];
            break;
        case 4:
            return [self violet];
            break;
        case 5:
            return [self sunshine];
            break;
        default:
            return [self green];
            break;
    }
}

@end
