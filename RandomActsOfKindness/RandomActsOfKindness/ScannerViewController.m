//
//  ScannerViewController.m
//  RandomActsOfKindness
//
//  Created by DetroitLabs on 7/21/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "ScannerViewController.h"
#import "MTBBarcodeScanner.h"
#import "AddActViewController.h"
#import "User.h"
#import "CAGradientLayer+_colors.h"
#import "NetworkCalls.h"
#import "CheckIn.h"
#import <AFNetworking/AFNetworking.h>

@interface ScannerViewController ()
@property (weak, nonatomic) IBOutlet UIView *scannerView;
@property (weak, nonatomic) IBOutlet UIImageView *profileButton;
@property (weak, nonatomic) NSString *cardNumber;
@property (strong, nonatomic) NSArray *checkIns;
@end

@implementation ScannerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeView];
    [self profileButtonSetup];
    [self startScanner];
    [self displayCheckIns];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear{
    [self customizeView];
}

#pragma mark - UI customization

-(void)customizeView{
    //add gradient background
    CAGradientLayer *backgroundLayer = [CAGradientLayer sunshine];
    backgroundLayer.frame = self.view.frame;
    [self.view.layer insertSublayer:backgroundLayer atIndex:0];
    
    //Customize profile button
    _profileButton.layer.cornerRadius = 30;
    _profileButton.layer.borderWidth = 1.0;
    _profileButton.layer.backgroundColor=[[UIColor clearColor] CGColor];
    _profileButton.layer.borderColor=[[UIColor blackColor] CGColor];
    _profileButton.clipsToBounds = YES;
    for(float x = 0; x<2; x = x +.1){
        [self performSelector:@selector(assignPicture) withObject:nil afterDelay:x];
        NSLog(@"HI");
    }
    //implement delegate for this load
}

-(void)assignPicture{
    _profileButton.image = [User sharedUser].profilePicture;
}

-(void)profileButtonSetup{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileTapped:)];
    [_profileButton addGestureRecognizer:tap];
}

-(void)profileTapped:(UIGestureRecognizer *)tap{
    [self performSegueWithIdentifier:@"profileSegue" sender:self];
}

#pragma mark = Barcode scanner

-(void)startScanner{
    //initialize barcode scanner and segues to add act view on successful scan
    MTBBarcodeScanner *scanner = [[MTBBarcodeScanner alloc]initWithPreviewView:_scannerView];
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {
        if (success) {
            [scanner startScanningWithResultBlock:^(NSArray *codes) {
                AVMetadataMachineReadableCodeObject *code = [codes firstObject];
                NSLog(@"Found code: %@", code.stringValue);
                _cardNumber = code.stringValue;
                [scanner stopScanning];
                [self performSegueWithIdentifier:@"scanSegue" sender:self];
            }];
        } else {
            // The user denied access to the camera
            [self showAlert:@"I can't see!" message:@"Access to camera denied"];
        }
    }];
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"scanSegue"]){
        AddActViewController *vc = [segue destinationViewController];
        vc.cardNumberLabel.text = [NSString stringWithFormat:@"Card number: %@", vc.cardNumberLabel];
    }
}

#pragma mark - Helpers

- (void)showAlert:(NSString *)title message:(NSString *)message {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action)
     {
         [alert dismissViewControllerAnimated:YES completion:nil];
     }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - Network calls

//Grabs all check ins to display in map
-(void)displayCheckIns{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://api.pinlac.net/checkins"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            
            //maps response to CheckIn model
            
            //number and dateformatter to convert strings to nsnumber and nsdate
            NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
            f.numberStyle = NSNumberFormatterDecimalStyle;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"EDT"]];
//            [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSz"];
            
            for(id checkIn in [responseObject objectForKey:@"data"]){
                CheckIn *newCheckIn = [[CheckIn alloc] init];
                newCheckIn.id = [[NSString stringWithFormat:@"%@", [checkIn objectForKey:@"id"]] integerValue];
                newCheckIn.userId = [[NSString stringWithFormat:@"%@", [checkIn objectForKey:@"userid"]] integerValue];
                newCheckIn.descriptionProperty = [NSString stringWithFormat:@"%@", [checkIn objectForKey:@"descriptionproperty"]];
                NSString *latitudeString = [NSString stringWithFormat:@"%@",[[checkIn objectForKey:@"location"] objectAtIndex:0]];
                NSString *longitudeString = [NSString stringWithFormat:@"%@",[[checkIn objectForKey:@"location"] objectAtIndex:1]];
                newCheckIn.location =[[NSArray alloc] initWithObjects:
                                      [f numberFromString:latitudeString],
                                      [f numberFromString:longitudeString],
                                      nil];
                NSString *dateString =[NSString stringWithFormat:@"%@",[checkIn objectForKey:@"time"]];
                newCheckIn.time = [dateFormatter dateFromString:dateString];
            }
        }
    }];
    [dataTask resume];
}

@end
