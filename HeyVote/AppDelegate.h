//
//  AppDelegate.h
//  HeyVote
//
//  Created by Ikhram Khan on 4/27/16.
//  Copyright © 2016 AppCandles. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SKSplashView.h"
#import "SKSplashIcon.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


@class SPHViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,SKSplashDelegate>
{
    id currentViewController;
}

@property (strong, nonatomic) SPHViewController *viewController;

@property (nonatomic, assign) id currentViewController;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SKSplashView *splashView;
@property (weak, nonatomic) NSString *stringValss;

//Demo of how to add other UI elements on top of splash view
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@end

