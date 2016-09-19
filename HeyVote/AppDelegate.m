//
//  AppDelegate.m
//  HeyVote
//
//  Created by Ikhram Khan on 4/27/16.
//  Copyright © 2016 AppCandles. All rights reserved.
//

#import "AppDelegate.h"
#import "homeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    _stringValss = @"firstTime";
     [self methodForAPNS:application];
    
    // Override point for customization after application launch.
    
 // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Existing"]isEqualToString:@"Existing"]) {

       // self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"homeViewController"];
        
        UINavigationController *navigationController = (UINavigationController *) self.window.rootViewController;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        [navigationController pushViewController:[storyboard instantiateViewControllerWithIdentifier:@"homeViewController"] animated:NO];
        
    }
    

    // PLACE YOUR APP LAUNCH CODE HERE
//    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default"]];
//    [self.window addSubview:imageView];
// 
//    [UIView transitionWithView:self.window
//                      duration:4.00f
//                       options:UIViewAnimationOptionCurveEaseInOut
//                    animations:^(void){
//                        imageView.alpha = 0.0f;
//                    }
//                    completion:^(BOOL finished){
//                        [imageView removeFromSuperview];
//                    }];




//
//    [UIView animateWithDuration:4.0 animations:^{
//        imageView.alpha = 0.0;
//        [imageView removeFromSuperview];
//    }];
//
//    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     _stringValss = @"";
       NSLog(@"%ld", (long)[UIApplication sharedApplication].applicationIconBadgeNumber );
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  //  static int i=1;
    
    NSLog(@"%ld", (long)[UIApplication sharedApplication].applicationIconBadgeNumber );
    
    //   [UIApplication sharedApplication].applicationIconBadgeNumber = i++;
   // [UIApplication sharedApplication].applicationIconBadgeNumber = i++;
    // [[UIApplication sharedApplication] setApplicationIconBadgeNumber: i++];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    
    _stringValss = @"";
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    if ([_stringValss isEqualToString:@"firstTime"]) {
        
        [self pingSplash];
        
    }
    

    
 
    
}




- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
       NSLog(@"%ld", (long)[UIApplication sharedApplication].applicationIconBadgeNumber );
}



//- (void)finishLaunchImageTransitionNow
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:GCOLaunchImageTransitionHideNotification object:self];
//}

#pragma mark- PUSH NOTIFICATIONS

-(void)methodForAPNS:(UIApplication *)application{
    
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
        
    {
        
        // iOS 8 Notifications
        
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        
        
        [application registerForRemoteNotifications];
        
    }
    
    
    
}



- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings

{
    
    [application registerForRemoteNotifications];
    
}

- (void)application:(UIApplication *)application

didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken

{
    NSString *devToken = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    devToken = [devToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    [[NSUserDefaults standardUserDefaults] setObject:devToken forKey:@"NSUserDefault_DeviceToken"];
}



- (void)application:(UIApplication *)application

didFailToRegisterForRemoteNotificationsWithError:(NSError *)error

{
    
    
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo

{
    
    NSLog(@"%d",[[[userInfo objectForKey:@"aps"] objectForKey: @"badgecount"] intValue]);
    [UIApplication sharedApplication].applicationIconBadgeNumber = [[[userInfo objectForKey:@"aps"] objectForKey: @"badgecount"] intValue];
    
}


#pragma mark - Custom Load Example

- (void) customLoadSplash
{
    //Adding splash view
    UIColor *customColor = [UIColor colorWithRed:168.0f/255.0f green:36.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    _splashView = [[SKSplashView alloc] initWithBackgroundColor:customColor animationType:SKSplashAnimationTypeZoom];
    _splashView.animationDuration = 5.0f;
    _splashView.delegate = self;
    //Adding activity indicator view on splash view
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _indicatorView.frame = self.window.frame;
    [self.window addSubview:_splashView];
    [self.window addSubview:_indicatorView];
    [_splashView startAnimation];
}

#pragma mark - Twitter Example

- (void) twitterSplash
{
    //Setting the background
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.window.frame];
    imageView.image = [UIImage imageNamed:@"twitter background.png"];
    [self.window addSubview:imageView];
    //Twitter style splash
    SKSplashIcon *twitterSplashIcon = [[SKSplashIcon alloc] initWithImage:[UIImage imageNamed:@"ic_launcher.png"] animationType:SKIconAnimationTypeBounce];
     twitterSplashIcon.iconSize = CGSizeMake(75, 75);
    UIColor *twitterColor = [UIColor whiteColor];
    _splashView = [[SKSplashView alloc] initWithSplashIcon:twitterSplashIcon backgroundColor:twitterColor animationType:SKSplashAnimationTypeNone];
    _splashView.delegate = self; //Optional -> if you want to receive updates on animation beginning/end
    _splashView.animationDuration = 2.2; //Optional -> set animation duration. Default: 1s
    [self.window addSubview:_splashView];
    [_splashView startAnimation];
}

#pragma mark - Ping Example

- (void) pingSplash
{
    //Setting the background
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.window.frame];
    imageView.image = [UIImage imageNamed:@""];
    [self.window addSubview:imageView];
    //Ping style splash
    SKSplashIcon *pingSplashIcon = [[SKSplashIcon alloc] initWithImage:[UIImage imageNamed:@"ic_launcher.png"] animationType:SKIconAnimationTypePing];
    pingSplashIcon.iconSize = CGSizeMake(75, 75);
    _splashView = [[SKSplashView alloc] initWithSplashIcon:pingSplashIcon backgroundColor:[UIColor whiteColor] animationType:SKSplashAnimationTypeNone];
    _splashView.animationDuration = 3.0f;
    [self.window addSubview:_splashView];
    [_splashView startAnimation];
}

#pragma mark - Animation Examples

- (void) fadeExampleSplash
{
    SKSplashIcon *splashIcon = [[SKSplashIcon alloc] initWithImage:[UIImage imageNamed:@"ic_launcher.png"] animationType:SKIconAnimationTypeBlink];
    splashIcon.iconSize = CGSizeMake(75, 75);
    _splashView = [[SKSplashView alloc] initWithSplashIcon:splashIcon backgroundColor:[UIColor whiteColor] animationType:SKSplashAnimationTypeFade];
    _splashView.animationDuration = 5;
    [self.window addSubview:_splashView];
    [_splashView startAnimationWithCompletion:^{
        NSLog(@"Splash animation complete");
    }];
}

#pragma mark - Concurrent Network Animation

- (void) uberAnimation
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uber map screenshot.png"]];
    imageView.frame = self.window.frame;
    [self.window addSubview:imageView]; //add background
    SKSplashIcon *splashIcon = [[SKSplashIcon alloc] initWithImage:[UIImage imageNamed:@"ic_launcher.png"] animationType:SKIconAnimationTypePing];
    SKSplashView *splashView = [[SKSplashView alloc] initWithSplashIcon:splashIcon backgroundImage:[UIImage imageNamed:@"uber screen.png"] animationType:SKSplashAnimationTypeNone];
    [self.window addSubview:splashView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.usda.gov/data.json"]]; //replace with url you want to download data for launch from
    [splashView startAnimationWhileExecuting:request withCompletion:^(NSData *data, NSURLResponse *response, NSError *error)
     {
         if(!error) {
             //got data from request, parsing it
             NSError *jsonError = nil;
             NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
             NSLog(@"Got everything I needed while splash animation was running 👍 %@", responseDict);
         }
     }];
}

#pragma mark - Delegate methods (Optional)

- (void) splashView:(SKSplashView *)splashView didBeginAnimatingWithDuration:(float)duration
{
    NSLog(@"Started animating from delegate");
    //To start activity animation when splash animation starts
    [_indicatorView startAnimating];
}

- (void) splashViewDidEndAnimating:(SKSplashView *)splashView
{
    NSLog(@"Stopped animating from delegate");
    //To stop activity animation when splash animation ends
    [_indicatorView stopAnimating];
}



@end
