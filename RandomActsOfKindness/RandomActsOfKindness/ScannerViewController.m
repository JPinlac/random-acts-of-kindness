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

@interface ScannerViewController ()
@property (weak, nonatomic) IBOutlet UIView *scannerView;
@property (weak, nonatomic) NSString *cardNumber;
@end

@implementation ScannerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startScanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
@end
