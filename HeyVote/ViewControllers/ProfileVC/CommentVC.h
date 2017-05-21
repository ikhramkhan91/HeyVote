//
//  CommentVC.h
//  HeyVote
//
//  Created by Ikhram Khan on 5/19/16.
//  Copyright © 2016 AppCandles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+NVTimeAgo.h"

@interface CommentVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>{
   NSMutableArray *arrayValuee;
     NSMutableArray *hashAdArray;
    NSMutableArray *AdTheRateArray;

}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

- (IBAction)cloaseButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *replyView;
@property (weak, nonatomic) IBOutlet UIView *commentBoxView;
@property (weak, nonatomic) IBOutlet UIView *replyInnerView;
- (IBAction)replyyyButton:(id)sender;
- (IBAction)reporttButton:(id)sender;
- (IBAction)cancelllButton:(id)sender;
- (IBAction)commentSendingButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIView *blurView;
@property (weak, nonatomic) IBOutlet UILabel *writeAcommentLabel;

@property (nonatomic)  NSInteger valueId;

@property (nonatomic)  NSInteger postId;

- (IBAction)viewProfileButton:(id)sender;

@end
