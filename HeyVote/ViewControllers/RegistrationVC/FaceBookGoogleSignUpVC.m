//
//  FaceBookGoogleSignUpVC.m
//  HeyVote
//
//  Created by Ikhram Khan on 5/21/17.
//  Copyright © 2017 AppCandles. All rights reserved.
//

#import "FaceBookGoogleSignUpVC.h"
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import "MobileRegistrationVC.h"
#import "GMDCircleLoader.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface FaceBookGoogleSignUpVC (){
    GPPSignIn *signIn;
    UIView *newView;
    FBSDKLoginButton *loginButton;
}

@end

@implementation FaceBookGoogleSignUpVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
    
    loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
     loginButton.hidden = YES;
    
    
  signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    //signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = @"650325777554-hunbnh6qr4k0ac175r48cmr4bgelmhqs.apps.googleusercontent.com";
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    
 //    [signIn authenticate];
}

-(void) finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error
{
    signIn.shouldFetchGoogleUserEmail = YES;
    signIn.delegate = self;
    
    if (error == nil) {
        if(auth.canAuthorize){
            GTLServicePlus *service = [[GTLServicePlus alloc] init];
            [service setRetryEnabled:YES];
            [service setAuthorizer:auth];
            
            GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
            
            
            // 1. Create a |GTLServicePlus| instance to send a request to Google+.
            GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
            plusService.retryEnabled = YES;
            
            // 2. Set a valid |GTMOAuth2Authentication| object as the authorizer.
            [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
            
            // 3. Use the "v1" version of the Google+ API.*
            plusService.apiVersion = @"v1";
            [plusService executeQuery:query
                    completionHandler:^(GTLServiceTicket *ticket,
                                        GTLPlusPerson *person,
                                        NSError *error) {
                        if (error) {
                            //Handle Error
                            
                            [GMDCircleLoader hideFromView:newView animated:YES];
                            [newView removeFromSuperview];
                        } else {
                            
                            
                            [GMDCircleLoader hideFromView:newView animated:YES];
                            [newView removeFromSuperview];
                            
                            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"googleDetails"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                    
                            NSMutableDictionary *yourMutableDictionary = [[NSMutableDictionary alloc] init];
                            [yourMutableDictionary setObject:[GPPSignIn sharedInstance].authentication.userEmail forKey:@"email"];
                            [yourMutableDictionary setObject:person.identifier forKey:@"identifier"];
                            [yourMutableDictionary setObject:[person.name.givenName stringByAppendingFormat:@" %@", person.name.familyName] forKey:@"name"];
                            [yourMutableDictionary setObject:person.gender forKey:@"gender"];
                            [yourMutableDictionary setObject:person.image.url forKey:@"image"];
                            
                            
                            
                            
                                                   
                             [[NSUserDefaults standardUserDefaults] setObject:yourMutableDictionary forKey:@"googleDetails"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                            
                            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                            MobileRegistrationVC *myVC = (MobileRegistrationVC *)[storyboard instantiateViewControllerWithIdentifier:@"MobileRegistrationVC"];
                            
                            [self.navigationController pushViewController:myVC animated:YES];

                            
                            
                            NSLog(@"\nEmail= %@", [GPPSignIn sharedInstance].authentication.userEmail);
                            NSLog(@"\nGoogleID=%@", person.identifier);
                            NSLog(@"\nUser Name=%@", [person.name.givenName stringByAppendingFormat:@" %@", person.name.familyName]);
                            NSLog(@"\nGender=%@", person.gender);
                            NSLog(@"\nImage=%@", person.image.url);
                        }
                    }];
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)googlePlusSignIn:(id)sender {
    
   newView = [[UIView alloc]init];
    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-60, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:newView];
    
      [GMDCircleLoader setOnView:newView withTitle:@"Signing in..." animated:YES];
    
    [signIn authenticate];
}

- (IBAction)facebookSignIn:(id)sender {
  //  [loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self loginButtonClicked];
    
}

-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in : %@",result);
             
             if ([FBSDKAccessToken currentAccessToken]) {
                 [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"email,name,first_name,gender,picture.width(100).height(100)"}]
                  startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                      if (!error) {
                          NSLog(@"fetched user:%@", result);
                          NSLog(@"%@",result[@"email"]);
                          
                          [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"googleDetails"];
                          [[NSUserDefaults standardUserDefaults] synchronize];
                          
                          
                          NSMutableDictionary *yourMutableDictionary = [[NSMutableDictionary alloc] init];
                          [yourMutableDictionary setObject:[result valueForKey:@"email"] forKey:@"email"];
                          [yourMutableDictionary setObject:[result valueForKey:@"id"] forKey:@"identifier"];
                          [yourMutableDictionary setObject:[result valueForKey:@"name"] forKey:@"name"];
                          [yourMutableDictionary setObject:[result valueForKey:@"gender"] forKey:@"gender"];
                         [yourMutableDictionary setObject:[[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"] forKey:@"image"];
                          
                          
                          
                          
                          
                          [[NSUserDefaults standardUserDefaults] setObject:yourMutableDictionary forKey:@"googleDetails"];
                          [[NSUserDefaults standardUserDefaults] synchronize];
                          
                          
                          UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                          MobileRegistrationVC *myVC = (MobileRegistrationVC *)[storyboard instantiateViewControllerWithIdentifier:@"MobileRegistrationVC"];
                          
                          [self.navigationController pushViewController:myVC animated:YES];
                          
                          
                          
                          
                      }
                  }];
                 
                 
             }
            
         }
     }];
}



- (IBAction)skipButton:(id)sender {
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MobileRegistrationVC *myVC = (MobileRegistrationVC *)[storyboard instantiateViewControllerWithIdentifier:@"MobileRegistrationVC"];
    
    [self.navigationController pushViewController:myVC animated:YES];

}
@end
