//
//  FaceBookGoogleSignUpVC.h
//  HeyVote
//
//  Created by Ikhram Khan on 5/21/17.
//  Copyright © 2017 AppCandles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
@class GPPSignInButton;
@interface FaceBookGoogleSignUpVC : UIViewController<UINavigationControllerDelegate,GPPSignInDelegate>



@property (strong, nonatomic) IBOutlet UIView *mainView;
- (IBAction)googlePlusSignIn:(id)sender;
- (IBAction)facebookSignIn:(id)sender;

- (IBAction)skipButton:(id)sender;

@end
