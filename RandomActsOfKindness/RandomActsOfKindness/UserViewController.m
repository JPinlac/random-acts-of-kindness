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

@interface UserViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userPicture;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userPicture.image = [User sharedUser].profilePicture;
    _userPicture.layer.cornerRadius = 20;
    _userPicture.layer.borderWidth = 2.0;
    _userPicture.layer.backgroundColor=[[UIColor clearColor] CGColor];
    _userPicture.layer.borderColor=[[UIColor blackColor] CGColor];
    _userPicture.clipsToBounds = YES;
    self.title = [User sharedUser].username;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [User sharedUser].friends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"establishmentCell" forIndexPath:indexPath];
    User *user = [User sharedUser];
    for(id friend in user.friends)
        cell.textLabel.text = [friend name];
    return cell;
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
