//
//  AddActViewController.m
//  RandomActsOfKindness
//
//  Created by DetroitLabs on 7/26/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "AddActViewController.h"
#import "CAGradientLayer+_colors.h"
#import <AFNetworking/AFNetworking.h>
#import "User.h"

@interface AddActViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation AddActViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customizeView];
//    _cardNumberLabel.text = [NSString stringWithFormat:@"Card number: %@", _cardUrl];
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
#pragma mark - Network calls

- (IBAction)postCheckIn:(id)sender {
    
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
////    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    NSDictionary *parameters = [[NSDictionary alloc] initWithObjectsAndKeys:@[[NSNumber numberWithDouble: _coord.latitude], [NSNumber numberWithDouble: _coord.longitude]], @"location", [[User sharedUser] uid], @"userId",_cardNumber, @"card", nil];
//    NSLog(@"%@", parameters.description);
//    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://api.pinlac.net/checkin/" parameters:parameters error:nil];
//    NSLog(@"%@", request.HTTPBody);
////    request.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    NSURLSessionDataTask  *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
////        NSLog(@"%@", response);
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"%@ %@", response, responseObject);
//        }
//    }];
//    [dataTask resume];
    
    NSDictionary *headers = @{ @"cache-control": @"no-cache",
                               @"jon-rulez": @"YEAH YEAH YEAH",
                               @"content-type": @"application/x-www-form-urlencoded" };
    
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[[NSString stringWithFormat:@"&location=%f", _coord.latitude] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&location=%f", _coord.longitude] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&userId=%@", [User sharedUser].uid] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&descriptionProperty=%@", _textView.text] dataUsingEncoding:NSUTF8StringEncoding]];
    [postData appendData:[[NSString stringWithFormat:@"&card=%@", _cardNumber] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api.pinlac.net/checkin/"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        [self showAlert:@"Success" message:@"Thank you for being awesome"];
                                                    }
                                                }];
    [dataTask resume];
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
         _cardNumber = @2;
         [self performSegueWithIdentifier:@"scanSegue" sender:self];
     }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
}


@end
