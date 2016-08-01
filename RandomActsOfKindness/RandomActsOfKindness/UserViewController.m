//
//  UserViewController.m
//  RandomActsOfKindness
//
//  Created by DetroitLabs on 7/22/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "UserViewController.h"
#import "User.h"
#import <QuartzCore/QuartzCore.h>
#import "CAGradientLayer+_colors.h"

@interface UserViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userPicture;
@property (weak, nonatomic) User *user;
@end


@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI customization

-(void)customizeView{
    _user = [User sharedUser];
    _userPicture.image = _user.profilePicture;
//    _userPicture.layer.cornerRadius = 120;
//    _userPicture.layer.borderWidth = 2.0;
//    _userPicture.layer.backgroundColor=[[UIColor clearColor] CGColor];
//    _userPicture.layer.borderColor=[[UIColor blackColor] CGColor];
//    _userPicture.clipsToBounds = YES;
//    self.title = [User sharedUser].username;
    self.title = @"Profile";
    _nameLabel.text = _user.username;
    
    CAGradientLayer *backgroundLayer = [CAGradientLayer random];
    backgroundLayer.frame = self.view.frame;
    [self.view.layer insertSublayer:backgroundLayer atIndex:0];
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _user.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"friendCell" forIndexPath:indexPath];
    for(id friend in _user.friends){
        cell.textLabel.text = [friend valueForKey:@"name"];
    }
    return cell;
}

#pragma mark - Navigation

- (IBAction)goHome:(id)sender {
    [[self presentingViewController]dismissViewControllerAnimated:YES completion:nil];
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
