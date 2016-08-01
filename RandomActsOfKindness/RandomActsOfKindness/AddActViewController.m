//
//  AddActViewController.m
//  RandomActsOfKindness
//
//  Created by DetroitLabs on 7/26/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "AddActViewController.h"
#import "CAGradientLayer+_colors.h"

@interface AddActViewController ()

@end

@implementation AddActViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)customizeView{
    //add gradient background
    CAGradientLayer *backgroundLayer = [CAGradientLayer random];
    backgroundLayer.frame = self.view.frame;
    [self.view.layer insertSublayer:backgroundLayer atIndex:0];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
