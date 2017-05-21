//
//  notificationsViewController.h
//  HeyVote
//
//  Created by Ikhram Khan on 6/5/16.
//  Copyright © 2016 AppCandles. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AssetsLibrary/AssetsLibrary.h>




@interface notificationsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)backButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) ALAssetsLibrary *library;




@end
