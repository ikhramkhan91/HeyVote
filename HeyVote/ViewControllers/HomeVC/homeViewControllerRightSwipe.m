//
//  homeViewControllerRightSwipe.m
//  HeyVote
//
//  Created by macbook on 4/4/17.
//  Copyright © 2017 AppCandles. All rights reserved.
//

#import "homeViewControllerRightSwipe.h"
#import "ContactsTabViewController.h"
#import "searchTabViewController.h"
#import "CameraViewController.h"
#import "globalViewCell.h"
#import "CommentVC.h"
#import "heyVoteProfileVC.h"
#import "profileViewController.h"

#import "GetPostDetailsViewController.h"
#import "NSDate+NVTimeAgo.h"
#import "homeViewController.h"


@interface homeViewControllerRightSwipe (){
    // MPMoviePlayerController *controller;
    
    float testVa;
    UILabel *Timer;
    int valText ;
    int valTextForComments ;
    CGSize labelSize;
    NSString * recentVal;
    UIView *footerView;
    NSString * exactTime;
    
    NSString* commentViewVal;
    
    CGRect tabRect;
    CGRect newTabRect;
    
    CGRect screenRectios;
    CGFloat screenWidthios;
    CGRect HeaderRect;
    CGRect SecondHeaderRect;
    
    
    NSMutableArray * activepostArray;
    
    int newVal;
    NSInteger categoryID;
    NSInteger statusID;
    
    
    NSInteger resultButtonWidth;
    NSInteger resultButtonHeight;
    
    
    NSMutableArray *arr;
    
    NSString* topViewVal;
    NSString* followUnfolloww;
    
    NSString* blockUnblockk;
    
    NSString * voteResultVal;
    NSString * voteResultValThreeVersus;
    NSString * voteResultValFourVersus;
    NSString * timerLoad;
    NSString * previewVal;
    NSMutableArray * voteResultAraay;
    
    NSMutableArray * voteResultAraayThreeVersus;
    NSMutableArray * voteResultAraayFourVersus;
    NSMutableArray* nameArr;
}


@end

@implementation homeViewControllerRightSwipe

@synthesize globalArray;
@synthesize heyVoteUpdates;

- (void)viewDidLoad {
    [super viewDidLoad];
    topViewVal = @"one";
    
    
    [_topView setHidden:YES];
    
    
    
    //    nameArr = [NSMutableArray arrayWithObjects: @"Jill Valentine", @"Peter Griffin", @"Meg Griffin", @"Jack Lolwut",
    //                        @"Mike Roflcoptor",
    //                        nil];
    
    
    
    screenRectios = [[UIScreen mainScreen] bounds];
    screenWidthios = screenRectios.size.width;
    
    categoryID = 0;
    statusID = 0;
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showMainMenu:)
                                                 name:@"loginComplete" object:nil];
    
    
    
    
    [heyVoteUpdates setHidden:YES];
    
    
    heyVoteUpdates.layer.shadowColor = [UIColor grayColor].CGColor;
    heyVoteUpdates.layer.shadowOffset = CGSizeMake(0, 1.0);
    heyVoteUpdates.layer.shadowOpacity = 1.0;
    heyVoteUpdates.layer.shadowRadius = 0.0;
    
    //   _timerCalc = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(runScheduledTask:) userInfo:nil repeats:YES];
    
    
    
    //   [NSTimer scheduledTimerWithTimeInterval:120.0 target:self selector:@selector(callNewUpdates:) userInfo:nil repeats:YES];
    
    
    
    
    timerLoad = @"";
    self.myScrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    recentVal = @"";
    voteResultAraay = [[NSMutableArray alloc]init];
    voteResultAraayThreeVersus = [[NSMutableArray alloc]init];
    voteResultAraayFourVersus = [[NSMutableArray alloc]init];
    [_noPostView setHidden:YES];
    [_zoomView setHidden:YES];
    voteResultVal = @"";
    previewVal = @"";
    [_previewView setHidden:YES];
    
   // [self callMainWebService];
    // [self callProfileView];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"basicInformation"] == nil) {
        [self callProfileView];
    }
    
    else{
        
        
        [_qatarButton setTitle:[[[[[NSUserDefaults standardUserDefaults] objectForKey:@"basicInformation"] allObjects] valueForKey:@"Country"] objectAtIndex:0] forState:UIControlStateNormal];
        
        
        
    }
    
    
    globalArray = [[NSMutableArray alloc]init];
    
    
    if (globalArray.count == 0) {
        [_noPostView setHidden:YES];
        
        newVal = 0;
        [self callWebService:newVal];
        
        
    }
    
    
    
    //
    //    tabRect = CGRectMake(_myTableView.frame.origin.x, _myTableView.frame.origin.y, _myTableView.frame.size.width, _myTableView.frame.size.height);
    //
    //    newTabRect = CGRectMake(_myTableView.frame.origin.x, _myTableView.frame.origin.y - _secondHeader.frame.size.height, _myTableView.frame.size.width, _myTableView.frame.size.height + _secondHeader.frame.size.height);
    //
    //
    //     HeaderRect = CGRectMake(_headerView.frame.origin.x, _headerView.frame.origin.y, _headerView.frame.size.width, _headerView.frame.size.height);
    //
    //     SecondHeaderRect = CGRectMake(_secondHeader.frame.origin.x, _secondHeader.frame.origin.y, _secondHeader.frame.size.width, _secondHeader.frame.size.height);
    //
    
    
    
    
    [self.homeSlider setThumbImage:[UIImage imageNamed:@"picker.png"] forState:UIControlStateNormal];
    [self.homeSlider setThumbImage:[UIImage imageNamed:@"picker.png"] forState:UIControlStateHighlighted];
    
    [self.homeSliderTwo setThumbImage:[UIImage imageNamed:@"picker.png"] forState:UIControlStateNormal];
    [self.homeSliderTwo setThumbImage:[UIImage imageNamed:@"picker.png"] forState:UIControlStateHighlighted];
    
    _homeSlider.value = 0;
    _homeSliderTwo.value = 0;
    
    
    
    
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@""]; //to give the attributedTitle
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged ];
    [_refreshControl setTintColor:[UIColor redColor]];
    [_myTableView addSubview:_refreshControl];
    
    
    // border radius
    [_topView.layer setCornerRadius:2.0f];
    
    // border
    [_topView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_topView.layer setBorderWidth:0.1f];
    
    // drop shadow
    [_topView.layer setShadowColor:[UIColor blackColor].CGColor];
    [_topView.layer setShadowOpacity:0.2];
    [_topView.layer setShadowRadius:3.0];
    [_topView.layer setShadowOffset:CGSizeMake(0.5, 0.5)];
    
    
    
    resultButtonWidth = 119;
    resultButtonHeight = 17;
    
    
    
    
    
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(leftSwipe:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.myTableView addGestureRecognizer:recognizer];
    
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                           action:@selector(rightSwipe:)];
    
    [recognizer.delegate self];
    
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.myTableView addGestureRecognizer:recognizer];
    
}






- (void)leftSwipe:(UISwipeGestureRecognizer *)gestureRecognizer
{
    //do you left swipe stuff here.
    
    
    NSLog(@"LEFT SWIPE");
    
    
    
}

- (void)rightSwipe:(UISwipeGestureRecognizer *)gestureRecognizer
{
    //do you right swipe stuff here. Something usually using theindexPath that you get that way
    CGPoint location = [gestureRecognizer locationInView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:location];
    
    NSLog(@"RIGHT SWIPE");
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    homeViewController *myVC = (homeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"homeViewController"];
    
        CATransition *transition = [CATransition animation];
        transition.duration = 0.5;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        transition.type = kCAAnimationCubic;
        transition.subtype = kCAAnimationCubic;
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController popViewControllerAnimated:YES];
    
    
  //  [self PushAnimation];
  //  [self.navigationController pushViewController:myVC animated:kCAAnimationCubic];

}



-(void)callMainWebService{
    
    BOOL interNetCheck=[WebServiceUrl InternetCheck];
    if (interNetCheck==YES ) {
        
        
        //        UIView *newView = [[UIView alloc]init];
        //        newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        //        [self.view addSubview:newView];
        //
        //        [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
        //
        //
        
        
        NSDictionary *jsonDictionary =@{
                                        
                                        @"isWeb":@"false"
                                        
                                        };
        
        
        
        
        
        
        NSError *error;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                            
                                                           options:0
                            
                                                             error:&error];
        
        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        
        NSLog(@"JSON OUTPUT: %@",JSONString);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/Getuserheaderresult"]];
            
            
            
            [requestPost setHTTPMethod:@"POST"];
            
            
            
            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
            
            
            
            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
            
            
            
            [requestPost setHTTPBody: requestData];
            
            
            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
            
            
            
            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if (error) {
                    //do something with error
                } else {
                    
                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (dic==nil) {
                            
                            
                            //                        [GMDCircleLoader hideFromView:newView animated:YES];
                            //                        [newView removeFromSuperview];
                            
                            
                        }
                        else{
                            
                            
                            NSLog(@"hjfshjfhs%@",dic);
                            
                            if ([[dic valueForKey:@"GetUserHeaderResultResult"] isEqual:[NSNull null]]) {
                                
                                _wonText.text = @"";
                                _lostText.text = @"";
                                
                            }
                            
                            else{
                                
                                NSString* v1 = [NSString stringWithFormat:@"%@",[[[dic valueForKey:@"GetUserHeaderResultResult"] allObjects] objectAtIndex:1]];
                                NSString* v2 = [NSString stringWithFormat:@"%@",[[[dic valueForKey:@"GetUserHeaderResultResult"] allObjects] objectAtIndex:0]];
                                NSArray *items1 = [v1 componentsSeparatedByString:@"."];
                                
                                NSArray *items2 = [v2 componentsSeparatedByString:@"."];
                                NSString *percent = @"%";
                                NSString*testOne= [NSString stringWithFormat:@"%@%@ are with you",[items1 objectAtIndex:0],percent];
                                NSString*testTwo= [NSString stringWithFormat:@"%@%@ are against you",[items2 objectAtIndex:0],percent];
                                
                                
                                
                                
                                _wonText.text = testOne;
                                _lostText.text = testTwo;
                                
                            }
                            
                            //                        [GMDCircleLoader hideFromView:newView animated:YES];
                            //                        [newView removeFromSuperview];
                            //
                            //
                            
                            
                        }
                        
                        
                        
                        
                    });
                }
            }];
            
        });
    }
    
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        
    }
    
}




- (void)showMainMenu:(NSNotification *)note {
    [self callWebService:0];}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    commentViewVal = @"";
    
    
}

#pragma mark - TextField Delegates

// This method is called once we click inside the textField
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"Text field did begin editing");
    
    // [textField becomeFirstResponder];
    timerLoad = @"invalid";
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"Text field ended editing");
    timerLoad = @"invalid";
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    timerLoad = @"invalid";
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
    //    videoplayer.muted = YES;
    //    [videoplayer pause];
    
    
    for (globalViewCell *cell in [self.myTableView visibleCells]) {
        //  NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
        
        
        
        [cell stopVideo];
        [cell stopAudio];
    }
    
    
    
    
    voteResultAraay = [[NSMutableArray alloc]init];
    voteResultAraayThreeVersus = [[NSMutableArray alloc]init];
    voteResultAraayFourVersus = [[NSMutableArray alloc]init];
    
    if (  [commentViewVal isEqualToString: @"val"]) {
        
    }
    
    else{
        
        //  [self.mc stop];
        [_myTableView setContentOffset:CGPointZero animated:YES];
        
        
        if (![_topView isHidden]) {
            [_topView setHidden:YES];
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            transition.duration = 0.4;
            [_topView.layer addAnimation:transition forKey:nil];
        }
        
        
        //    if ([_secondHeader alpha] == 0.0f || [_headerView alpha] == 0.0f) {
        //
        //
        //
        //        //fade in
        //        [UIView animateWithDuration:0.5f animations:^{
        //            _secondHeader.alpha = 1.0f;
        //            _headerView.alpha = 1.0f;
        //            _headerView.frame = HeaderRect;
        //            _myTableView.frame = tabRect;
        //
        //
        //        } completion:^(BOOL finished) {
        //
        //        }];
        //
        //    }
        
    }
    
}



- (void)refresh:(UIRefreshControl *)refreshControl
{
    
    [heyVoteUpdates setHidden:YES];
    [_myTableView setUserInteractionEnabled:NO];
    //  [refreshControl endRefreshing];
    [self callWebServiceRefresh:0];
    
    voteResultVal = @"";
    voteResultAraay = [[NSMutableArray alloc]init];
    voteResultAraayThreeVersus = [[NSMutableArray alloc]init];
    voteResultAraayFourVersus = [[NSMutableArray alloc]init];
    
    //    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:2.5];
}
//- (void)stopRefresh
//{
//
//    [ _refreshControl endRefreshing];
//
//}



-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    [self.myScrollView setScrollEnabled:YES];
    self.myScrollView.contentSize=CGSizeMake(self.myScrollView.bounds.size.width,_myScrollView.frame.size.height);
    
    
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"Did end decelerating");
    
    //  [self.mc pause];
    
    
    if (_myTableView.contentOffset.y == 0){
        
        NSLog(@"reached Top");
        
        [heyVoteUpdates setHidden:YES];
        
        
        
        if (![_topView isHidden]) {
            [_topView setHidden:YES];
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            transition.duration = 0.4;
            [_topView.layer addAnimation:transition forKey:nil];
        }
        
        //        if ([_secondHeader alpha] == 0.0f) {
        //
        //
        //            //fade in
        //            [UIView animateWithDuration:0.1f animations:^{
        //                _secondHeader.alpha = 1.0f;
        //                _headerView.alpha = 1.0f;
        //                _myTableView.frame = tabRect;
        //                _headerView.frame = HeaderRect;
        //
        //
        //
        //            } completion:^(BOOL finished) {
        //
        //            }];
        //
        //        }
        
    }
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                 willDecelerate:(BOOL)decelerate{
    NSLog(@"Did end dragging");
    
    
    if (globalArray.count >0) {
        
        if (![_zoomView isHidden]) {
            
        }
        else{
            
            
            
            //            NSIndexPath *topVisibleIndexPath = [[self.myTableView indexPathsForVisibleRows] objectAtIndex:0];
            //            NSLog(@"top visible cell's section: %li, get row: %li", (long)topVisibleIndexPath.section, (long)topVisibleIndexPath.row);
            
            
            CGRect visibleRect = (CGRect){.origin = self.myTableView.contentOffset, .size = self.myTableView.bounds.size};
            CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
            NSIndexPath *visibleIndexPath = [self.myTableView indexPathForRowAtPoint:visiblePoint];
            
            
            //   NSLog(@"visibleeeeeee %@",[globalArray objectAtIndex:visibleIndexPath.section]);
            
            
            globalViewCell *cell = (globalViewCell *)[self.myTableView cellForRowAtIndexPath:visibleIndexPath];
            
            arr = [[NSMutableArray alloc]init];
            // for (NSIndexPath *indexVisible in _myTableView.indexPathsForVisibleRows) {
            //    CGRect cellRect = [_myTableView rectForRowAtIndexPath:indexVisible];
            
            
            [arr addObject:[globalArray objectAtIndex:visibleIndexPath.section]];
            //        BOOL isVisible = CGRectContainsRect(_myTableView.bounds, cellRect );
            //        if (isVisible) {
            //            //you can also add rows if you dont want full indexPath.
            //            //[arr addObject:[NSString stringWithFormat:@"%ld",(long)indexVisible.row]];
            //
            //        }
            //   }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            //
            //
            //
            //
            //    if ([arr count]==0) {
            //
            //    }
            //
            //    else{
            //
            //      //  NSLog(@"dasdasd %@",arr);
            //
            //
            //
            ////        for (int i = 0; i < [arr count] ; i++) {
            ////
            ////             if ([[[arr valueForKey:@"PostType"] objectAtIndex:i] integerValue] == 2) {
            ////
            ////                 NSLog(@"videooooo");
            ////                 [self.mc pause];
            ////             }
            ////
            ////             else{
            ////
            ////                 [self.mc pause];
            ////             }
            ////
            ////
            ////        }
            ////
            //
            //
            ////
            ////
            //
            //
            //
            ////
            ////        NSIndexPath *indexpath = (NSIndexPath*)[arr objectAtIndex:0];
            ////
            ////     //   NSLog(@"arrrrr %@", [globalArray objectAtIndex:indexpath.row]);
            ////
            ////                if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexpath.row] integerValue] == 1) {
            ////
            ////                    NSLog(@"Imageeeeee");
            ////                }
            ////
            ////
            ////       else if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexpath.row] integerValue] == 2) {
            ////
            ////            NSLog(@"videoooo");
            ////        }
            ////
            ////       else if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexpath.row] integerValue] == 3) {
            ////
            ////           NSLog(@"audioooooo");
            ////       }
            ////
            //
            //
            //
            //        if ([[[globalArray objectAtIndex:visibleIndexPath.section] valueForKey:@"PostType"] integerValue] == 2) {
            ////
            ////            NSLog(@"videooooo");
            ////
            ////
            ////            CMTime currentTime = item.currentTime;
            ////            float videoDurationSeconds = CMTimeGetSeconds(currentTime);
            ////            if (videoDurationSeconds > 0 ) {
            ////
            ////                [videoplayer play];
            ////
            ////            }
            ////            else{
            ////
            ////
            ////
            ////            }
            ////
            ////
            //
            //
            //
            //            //      videoplayer.muted = NO;
            //            //            [videoplayer play];
            //
            //        }
            //
            //        else{
            //            // [videoplayer seekToTime:CMTimeMake(0, 1)];
            //            //             videoplayer.muted = YES;
            //
            //            [cell.videoplayer pause];
            //            cell.videoplayer.rate = 0;
            //
            //
            //
            //
            //        }
            //
            //
            //
            //    }
            //
        }
        
    }
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //  NSLog(@"scrollingggggg");
    
    
    if (globalArray.count >0) {
        
        NSIndexPath *centerCellIndexPath =
        [self.myTableView indexPathForRowAtPoint:
         [self.view convertPoint:[self.view center] toView:self.myTableView]];
        
        // Play/Pause Video
        CGRect visibleRect = (CGRect){.origin = self.myTableView.contentOffset, .size = self.myTableView.bounds.size};
        CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
        NSIndexPath *visibleIndexPath = [self.myTableView indexPathForRowAtPoint:visiblePoint];
        NSLog(@"dfdsfsadf %@",centerCellIndexPath);
        
        //    CGPoint visiblePointt = CGPointMake(CGRectGetMinX(visibleRect), CGRectGetMinY(visibleRect));
        //    NSIndexPath *visibleIndexPathh = [self.myTableView indexPathForRowAtPoint:visiblePointt];
        //
        
        globalViewCell *cell = (globalViewCell *)[self.myTableView cellForRowAtIndexPath:visibleIndexPath];
        
        NSIndexPath *firstVisibleIndexPath = [[self.myTableView indexPathsForVisibleRows] objectAtIndex:0];
        
        globalViewCell *cellss = (globalViewCell *)[self.myTableView cellForRowAtIndexPath:firstVisibleIndexPath];
        
        
        
        //HashTags
        
        
        if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:firstVisibleIndexPath.section] valueForKey:@"lstHashTags"] count] == 0) {
            
        }
        
        else{
            
            [cellss.hashCollectionView setHidden:NO];
            
            
            
            //            NSLog(@"%@",[[[[[globalArray valueForKey:@"combo"] objectAtIndex:firstVisibleIndexPath.section] valueForKey:@"lstHashTags"] valueForKey:@"HashTag"] allObjects]);
            nameArr = [[NSMutableArray alloc]init];
            [nameArr addObjectsFromArray:[[[globalArray valueForKey:@"combo"] objectAtIndex:firstVisibleIndexPath.section] valueForKey:@"lstHashTags"]];
            
            [cellss.hashCollectionView reloadData];
            
        }
        
        
        
        
        if (cell) {
            
            
            if ([[[globalArray objectAtIndex:visibleIndexPath.section] valueForKey:@"PostType"] integerValue] == 2){
                
                //  [cell playVideo];
                [cell.videoplayer play];
            }
            
            else{
                // [cell stopVideo];
                [cell.videoplayer pause];
            }
            
            
            
        }
        //
        //    else{
        //        [cell.playerLayer removeFromSuperlayer];
        //        cell.videoplayer = nil ;
        //        cell.item = nil;
        //        [cell stopVideo];
        //
        //    }
        //
        //
        
    }
    
    
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(globalViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [cell stopVideo];
    [cell stopAudio];
    
}


-(void)doSomething{
    
    if ([previewVal isEqualToString:@"yes"]) {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(doSomething)
                                                   object:nil];
        
        
        if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:[[arr firstObject]section]] integerValue]==1) {
            
            
            if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:[[arr firstObject]section]] integerValue] == 1) {
                
                
                
                
                
                if ([[[globalArray valueForKey:@"hasVoted"] objectAtIndex:[[arr firstObject]section]] integerValue] == 1) {
                    
                    
                    NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[globalArray valueForKey:@"Image1Idf"] objectAtIndex:[[arr firstObject]section]],[[globalArray valueForKey:@"PostFolderPath"] objectAtIndex:[[arr firstObject]section]]];
                    
                    
                    [_previewImageView  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
                    
                    [_previewButtonView setHidden:YES];
                    
                    [_previewYouHaveVoted setHidden:NO];
                    
                    
                    if ([[[globalArray valueForKey:@"VoteOption"] objectAtIndex:[[arr firstObject]section]] integerValue] == 0) {
                        
                        
                        NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",[[globalArray valueForKey:@"Caption1"] objectAtIndex:[[arr firstObject]section]]];
                        
                        _previewYouVotedText.text =uVoted;
                    }
                    
                    else{
                        
                        
                        NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",[[globalArray valueForKey:@"Caption2"] objectAtIndex:[[arr firstObject]section]]];
                        _previewYouVotedText.text =uVoted;
                        
                    }
                    
                    
                    [_myTableView setUserInteractionEnabled:NO];
                    
                    
                    [_previewView setHidden:NO];
                    _previewView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                    [UIView animateWithDuration:0.5
                                     animations:^{
                                         _previewView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                                     } completion:^(BOOL finished) {
                                         
                                     }];
                    
                }
                
                else{
                    
                }
                
            }
            
            else
                
            {
                
                
                
                
                NSLog(@"dfsdfsdfdsf%@",[globalArray objectAtIndex:[[arr firstObject]section]]);
                
                NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[globalArray valueForKey:@"Image1Idf"] objectAtIndex:[[arr firstObject]section]],[[globalArray valueForKey:@"PostFolderPath"] objectAtIndex:[[arr firstObject]section]]];
                
                
                [_previewImageView  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
                
                
                if ([[[globalArray valueForKey:@"hasVoted"] objectAtIndex:[[arr firstObject]section]] integerValue] == 0) {
                    
                    
                    [_previewYouHaveVoted setHidden:YES];
                    
                    if ([voteResultAraay containsObject:[globalArray objectAtIndex:[[arr firstObject]section]]]) {
                        
                        if ([voteResultVal isEqualToString:@"leftvoted"] || [voteResultVal isEqualToString:@"rightvoted"]) {
                            [_previewButtonView setHidden:YES];
                            
                            [_previewYouHaveVoted setHidden:NO];
                            
                            
                            if ([voteResultVal isEqualToString:@"leftvoted"]) {
                                
                                
                                
                                NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",[[globalArray valueForKey:@"Caption1"] objectAtIndex:[[arr firstObject]section]]];
                                _previewYouVotedText.text =uVoted;
                            }
                            
                            else{
                                
                                NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",[[globalArray valueForKey:@"Caption2"] objectAtIndex:[[arr firstObject]section]]];
                                
                                _previewYouVotedText.text =uVoted;
                            }
                            
                        }
                        
                    }
                    
                    else{
                        
                        [_previewButtonView setHidden:NO];
                        
                        
                        
                        [_previewLeftButton setTitle:[[globalArray valueForKey:@"Caption1"] objectAtIndex:[[arr firstObject]section]] forState:UIControlStateNormal];
                        
                        
                        [_previewRightButton setTitle:[[globalArray valueForKey:@"Caption2"] objectAtIndex:[[arr firstObject]section]] forState:UIControlStateNormal];
                        
                    }
                }
                
                else{
                    [_previewButtonView setHidden:YES];
                    [_previewYouHaveVoted setHidden:NO];
                    
                    if ([[[globalArray valueForKey:@"VoteOption"] objectAtIndex:[[arr firstObject]section]] integerValue] == 0) {
                        
                        
                        NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",[[globalArray valueForKey:@"Caption1"] objectAtIndex:[[arr firstObject]section]]];
                        
                        _previewYouVotedText.text =uVoted;
                    }
                    
                    else{
                        
                        
                        NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",[[globalArray valueForKey:@"Caption2"] objectAtIndex:[[arr firstObject]section]]];
                        _previewYouVotedText.text =uVoted;
                        
                    }
                    
                    
                    
                    
                }
                [_myTableView setUserInteractionEnabled:NO];
                
                
                [_previewView setHidden:NO];
                _previewView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                [UIView animateWithDuration:0.5
                                 animations:^{
                                     _previewView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                                 } completion:^(BOOL finished) {
                                     
                                 }];
                
            }
        }
        
        
    }
    
    
    
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"Did begin decelerating");
    
    
    if (_lastContentOffset.x < (int)scrollView.contentOffset.x) {
        // moved right
        NSLog(@"right");
    }
    else if (_lastContentOffset.x > (int)scrollView.contentOffset.x) {
        // moved left
        NSLog(@"left");
        
    }else if (_lastContentOffset.y<(int)scrollView.contentOffset.y){
        NSLog(@"up");
        
        
        if (![_topView isHidden]) {
            
            [_topView setHidden:YES];
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            transition.duration = 0.4;
            [_topView.layer addAnimation:transition forKey:nil];
        }
        
        
        //       if ([_secondHeader alpha] == 1.0f || [_headerView alpha] == 1.0f) {
        //
        //        [UIView animateWithDuration:0.1f animations:^{
        //
        //           _secondHeader.alpha = 0.0f;
        //            _headerView.alpha = 0.0f;
        //
        //
        //            _myTableView.frame = CGRectMake(_myScrollView.frame.origin.x, _myScrollView.frame.origin.y - 20 , _myScrollView.frame.size.width, _myScrollView.frame.size.height );
        //
        //
        //           //   _headerView.frame = CGRectMake(_myScrollView.frame.origin.x, _myScrollView.frame.origin.y - 20, _headerView.frame.size.width, _headerView.frame.size.height );
        //
        //
        //        } completion:^(BOOL finished) {
        //
        //
        //
        //
        //
        //        }];
        //
        //       }
        //
        
        
    }else if (_lastContentOffset.y>(int)scrollView.contentOffset.y){
        NSLog(@"down");
        
        if (![_topView isHidden]) {
            
            [_topView setHidden:YES];
            CATransition *transition = [CATransition animation];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            transition.duration = 0.4;
            [_topView.layer addAnimation:transition forKey:nil];
        }
        
        
        
        //        if ([_headerView alpha] == 0.0f) {
        //
        //
        //
        //        //fade in
        //        [UIView animateWithDuration:0.1f animations:^{
        //            _headerView.alpha = 1.0f;
        //            _myTableView.frame = newTabRect;
        //             _headerView.frame = SecondHeaderRect;
        //
        //
        //
        //
        //
        //
        //
        //
        //        } completion:^(BOOL finished) {
        //
        //
        //
        //
        //                }];
        //
        //        }
        //
        //
        
    }
    
    
    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"Did begin dragging");
    timerLoad = @"";
    
    
    
    previewVal = @"";
    
    _lastContentOffset.x = scrollView.contentOffset.x;
    _lastContentOffset.y = scrollView.contentOffset.y;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    NSInteger newValF;
    NSInteger tabHeight = 0;
    
    if (globalArray.count >0) {
        
        
        
        if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 0) {
            
            
            tabHeight = 460;
            
        }
        
        else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 1) {
            
            
            tabHeight = 511;
            
        }
        else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 2) {
            
            
            tabHeight = 572;
            
        }
        
        else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 3 || [[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] > 3) {
            
            
            tabHeight = 621;
            
        }
        
    }
    
    else{
        return 0;
    }
    
    
    if (screenWidth == 320) {
        
        tabHeight = tabHeight;
        
    }
    
    else{
        newValF = screenHeight - 568;
        
        tabHeight = tabHeight + newValF;
    }
    
    
    return tabHeight;
}


#pragma mark - Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"myCell";
    static NSString *cellIdentifierOne = @"oneCommentCell";
    static NSString *cellIdentifierTwo = @"twoCommentCell";
    static NSString *cellIdentifierThree = @"threeCommentCell";
    static NSString *cellIdentifierFour = @"newCell";
    
    
    static NSString *cellIdentifierHeyMood = @"myCellHeyMood";
    static NSString *cellIdentifierOneHeyMood = @"oneCommentCellHeyMood";
    static NSString *cellIdentifierTwoHeyMood = @"twoCommentCellHeyMood";
    static NSString *cellIdentifierThreeHeyMood = @"threeCommentCellHeyMood";
    
    
    
    
    
    static NSString *cellIdentifierThreeVersus = @"threeVersusMyCell";
    static NSString *cellIdentifierOneThreeVersus = @"threeVersusOneCommentCell";
    static NSString *cellIdentifierTwoThreeVersus = @"threeVersusTwoCommentCell";
    static NSString *cellIdentifierThreeThreeVersus = @"threeVersusThreeCommentCell";
    
    static NSString *cellIdentifierFourVersus = @"fourVersusMyCell";
    static NSString *cellIdentifierOneFourVersus = @"fourVersusOneCommentCell";
    static NSString *cellIdentifierTwoFourVersus = @"fourVersusTwoCommentCell";
    static NSString *cellIdentifierThreeFourVersus = @"fourVersusThreeCommentCell";
    
    
    globalViewCell *cell;
    
    
    //    cell.layer.shadowOffset = CGSizeMake(1, 1);
    //    cell.layer.shadowColor = [[UIColor blackColor] CGColor];
    //    cell.layer.shadowRadius = 5;
    //    cell.layer.shadowOpacity = .25;
    
    [cell.showMoreComments setHidden:YES];
    
    

    
    
    if (globalArray.count >0 && [[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0 ) {
        
        
        
        
        
//        
//        if (newVal == 1000) {
//            
//        }
//        
//        else{
//            
//            
//            
//            if (indexPath.section == [globalArray count]-1 ) {
//                
//                
//                int plusVal = newVal+1;
//                newVal = plusVal;
//                timerLoad = @"invalid";
//                
//                
//                [self callWebService:plusVal];
//                
//                
//                
//            }
//        }
//        
//        
        
        nameArr =  [[NSMutableArray alloc] init];
        
        
        if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 0) {
            
            if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1 &&    [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 3) {
                
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierThreeVersus];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierThreeVersus];
                }
                
                
            }
            
            
            else  if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1 &&    [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 4) {
                
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierFourVersus];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierFourVersus];
                }
                
                
            }
            
            
            else  if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1 &&    [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 2) {
                
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierHeyMood];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierHeyMood];
                }
                
                
            }
            
            
            else{
                
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifier];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                
            }
        }
        
        else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 1){
            
            
            if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1 &&    [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 3) {
                
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierOneThreeVersus];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierOneThreeVersus];
                }
                
                
            }
            
            
            else if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1 &&    [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 4) {
                
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierOneFourVersus];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierOneFourVersus];
                }
                
                
            }
            
            else if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1 &&    [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 2) {
                
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierOneHeyMood];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierOneHeyMood];
                }
                
                
            }
            
            else{
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierOne];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierOne];
                }
                
            }
            
            
            
            
            NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"ImageIdf"] objectAtIndex:0],[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"FolderPath"] objectAtIndex:0]];
            
            
            
            
            [cell.firsttImageButton  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"userContacts.png"]];
            
            cell.firsttImageButton.layer.cornerRadius = cell.firsttImageButton.frame.size.height /2;
            cell.firsttImageButton.layer.masksToBounds = YES;
            cell.firsttImageButton.layer.borderWidth = 0;
            
            
        }
        
        else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 2){
            
            
            
            if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1 &&    [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 3) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierTwoThreeVersus];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierTwoThreeVersus];
                }
            }
            
            else if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1 &&    [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 4) {
                
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierTwoFourVersus];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierTwoFourVersus];
                }
                
                
            }
            
            else if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1 &&    [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 2) {
                
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierTwoHeyMood];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierTwoHeyMood];
                }
                
                
            }
            
            
            
            else{
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierTwo];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierTwo];
                }
                
            }
            
            
            
            
            NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"ImageIdf"] objectAtIndex:0],[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"FolderPath"] objectAtIndex:0]];
            
            
            
            [cell.firsttImageButton  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"userContacts.png"]];
            
            cell.firsttImageButton.layer.cornerRadius = cell.firsttImageButton.frame.size.height /2;
            cell.firsttImageButton.layer.masksToBounds = YES;
            cell.firsttImageButton.layer.borderWidth = 0;
            
            
            NSString * imageStringtwo = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"ImageIdf"] objectAtIndex:1],[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"FolderPath"] objectAtIndex:1]];
            
            
            
            
            [cell.secondButtonImage  sd_setImageWithURL:[NSURL URLWithString:imageStringtwo] placeholderImage:[UIImage imageNamed:@"userContacts.png"]];
            cell.secondButtonImage.layer.cornerRadius = cell.secondButtonImage.frame.size.height /2;
            cell.secondButtonImage.layer.masksToBounds = YES;
            cell.secondButtonImage.layer.borderWidth = 0;
        }
        
        else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 3 || [[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] > 3 ){
            
            if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1 &&    [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 3) {
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierThreeThreeVersus];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierThreeThreeVersus];
                }
            }
            
            
            
            else if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1 &&    [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 4) {
                
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierThreeFourVersus];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierThreeFourVersus];
                }
                
                
            }
            
            
            else if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1 &&    [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 2) {
                
                
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierThreeHeyMood];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierThreeHeyMood];
                }
                
                
            }
            
            
            
            else{
                cell = [tableView dequeueReusableCellWithIdentifier:
                        cellIdentifierThree];
                if (cell == nil) {
                    cell = [[globalViewCell alloc]initWithStyle:
                            UITableViewCellStyleDefault reuseIdentifier:cellIdentifierThree];
                }
            }
            
            
            
            
            NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"ImageIdf"] objectAtIndex:0],[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"FolderPath"] objectAtIndex:0]];
            
            
            
            
            [cell.firsttImageButton  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"userContacts.png"]];
            
            cell.firsttImageButton.layer.cornerRadius = cell.firsttImageButton.frame.size.height /2;
            cell.firsttImageButton.layer.masksToBounds = YES;
            cell.firsttImageButton.layer.borderWidth = 0;
            
            NSString * imageStringtwo = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"ImageIdf"] objectAtIndex:1],[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"FolderPath"] objectAtIndex:1]];
            
            
            
            
            [cell.secondButtonImage  sd_setImageWithURL:[NSURL URLWithString:imageStringtwo] placeholderImage:[UIImage imageNamed:@"userContacts.png"]];
            
            cell.secondButtonImage.layer.cornerRadius = cell.secondButtonImage.frame.size.height /2;
            cell.secondButtonImage.layer.masksToBounds = YES;
            cell.secondButtonImage.layer.borderWidth = 0;
            
            NSString * imageStringthree = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"ImageIdf"] objectAtIndex:2],[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"FolderPath"] objectAtIndex:2]];
            
            
            
            
            [cell.thirsButtonImage  sd_setImageWithURL:[NSURL URLWithString:imageStringthree] placeholderImage:[UIImage imageNamed:@"userContacts.png"]];
            cell.thirsButtonImage.layer.cornerRadius = cell.thirsButtonImage.frame.size.height /2;
            cell.thirsButtonImage.layer.masksToBounds = YES;
            cell.thirsButtonImage.layer.borderWidth = 0;
            
            
        }
        
        
        if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] > 3) {
            [cell.showMoreComments setHidden:NO];
            
            
            [cell.showMoreComments setTitle:[NSString stringWithFormat:@"Show all %ld comments",(long)[[[globalArray valueForKey:@"CommentCount"] objectAtIndex:indexPath.section] integerValue]] forState:UIControlStateNormal];
            
            [cell.totalComments setHidden:YES];
        }
        
        else{
            
            [cell.showMoreComments setHidden:YES];
            [cell.totalComments setHidden:NO];
        }
        
        
        
        
        [cell.hashCollectionView setHidden:YES];
        
        
        
        [cell.checkInView setHidden:YES];
        [cell.spamView setHidden:YES];
        [cell.progresssView setHidden:YES];
        [cell.timerCell setHidden:YES];
        [cell.remainingLabel setHidden:YES];
        
        
        
        // timerLoad = @"";
        //        cell.leftResultButton.layer.cornerRadius = 3;
        //        [[cell.leftResultButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        //        cell.leftResultButton.layer.borderWidth = 0.5;
        //
        //        cell.rightResultButton.layer.cornerRadius = 3;
        //         [[cell.rightResultButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        //        cell.rightResultButton.layer.borderWidth = 0.5;
        
        
        cell.leftButton.layer.cornerRadius = 3;
        [[cell.leftButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        cell.leftButton.layer.borderWidth = 0.5;
        
        cell.rightButton.layer.cornerRadius = 3;
        [[cell.rightButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        cell.rightButton.layer.borderWidth = 0.5;
        
        
        
        
        /*  cell.threeVersusFinalLeftButton.layer.cornerRadius = 3;
         [[cell.threeVersusFinalLeftButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
         cell.threeVersusFinalLeftButton.layer.borderWidth = 0.5;
         
         cell.threeVersusFinalRightButton.layer.cornerRadius = 3;
         [[cell.threeVersusFinalRightButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
         cell.threeVersusFinalRightButton.layer.borderWidth = 0.5;
         
         cell.threeVersusRightResultButton.layer.cornerRadius = 3;
         [[cell.threeVersusRightResultButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
         cell.threeVersusRightResultButton.layer.borderWidth = 0.5; */
        
        
        cell.threeVersusFirstSecondLeftButton.layer.cornerRadius = 3;
        [[cell.threeVersusFirstSecondLeftButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        cell.threeVersusFirstSecondLeftButton.layer.borderWidth = 0.5;
        
        cell.threeVersusFirstSecondRightButton.layer.cornerRadius = 3;
        [[cell.threeVersusFirstSecondRightButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        cell.threeVersusFirstSecondRightButton.layer.borderWidth = 0.5;
        
        cell.threeVersusRightButton.layer.cornerRadius = 3;
        [[cell.threeVersusRightButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        cell.threeVersusRightButton.layer.borderWidth = 0.5;
        
        
        
        
        
        
        
        //        cell.fourVersusFinalLeftButton.layer.cornerRadius = 3;
        //        [[cell.fourVersusFinalLeftButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        //        cell.fourVersusFinalLeftButton.layer.borderWidth = 0.5;
        //
        //        cell.fourVersusFinalRightButton.layer.cornerRadius = 3;
        //        [[cell.fourVersusFinalRightButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        //        cell.fourVersusFinalRightButton.layer.borderWidth = 0.5;
        
        cell.fourVersusLeftButton.layer.cornerRadius = 3;
        [[cell.fourVersusLeftButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        cell.fourVersusLeftButton.layer.borderWidth = 0.5;
        
        
        cell.fourVersusRightButton.layer.cornerRadius = 3;
        [[cell.fourVersusRightButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        cell.fourVersusRightButton.layer.borderWidth = 0.5;
        
        cell.fourVersusFirstSecondLeftButton.layer.cornerRadius = 3;
        [[cell.fourVersusFirstSecondLeftButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        cell.fourVersusFirstSecondLeftButton.layer.borderWidth = 0.5;
        
        cell.fourVersusFirstSecondRightButton.layer.cornerRadius = 3;
        [[cell.fourVersusFirstSecondRightButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        cell.fourVersusFirstSecondRightButton.layer.borderWidth = 0.5;
        
        
        //        cell.fourVersusFirstSecondFinalLeftButton.layer.cornerRadius = 3;
        //        [[cell.fourVersusFirstSecondFinalLeftButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        //        cell.fourVersusFirstSecondFinalLeftButton.layer.borderWidth = 0.5;
        //
        //        cell.fourVersusFirstSecondFinalRightButton.layer.cornerRadius = 3;
        //        [[cell.fourVersusFirstSecondFinalRightButton layer] setBorderColor:[UIColor lightGrayColor].CGColor];
        //        cell.fourVersusFirstSecondFinalRightButton.layer.borderWidth = 0.5;
        
        
        
        
        
        
        
        
        
        [cell.timerCell setHidden:YES];
        [cell.remainingLabel setHidden:YES];
        
        [cell.videoPreview setHidden:YES];
        [cell.moreButtonView setHidden:YES];
        [cell.deleteView setHidden:YES];
        cell.commentTextField.text = @"";
        
        
        
        [cell.leftButton setBackgroundColor:[UIColor whiteColor] ];
        
        
        [cell.rightButton setBackgroundColor:[UIColor whiteColor]];
        
        
        [cell.threeVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor] ];
        
        
        [cell.threeVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
        
        [cell.threeVersusRightButton setBackgroundColor:[UIColor whiteColor] ];
        
        
        
        
        [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor] ];
        
        
        [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
        
        [cell.fourVersusLeftButton setBackgroundColor:[UIColor whiteColor] ];
        [cell.fourVersusRightButton setBackgroundColor:[UIColor whiteColor] ];
        
        
        
        
        
        
        // [cell.titleLabel setNumberOfLines:0];
        
        
        
        
        
        
        cell.titleLabel.text = [[globalArray valueForKey:@"Title"] objectAtIndex:indexPath.section];
        //  NSString *textViewText =cell.titleLabel.text;
        
        //        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textViewText];
        //        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        //        paragraphStyle.lineSpacing = 5;
        //
        //        NSDictionary *dict = @{NSParagraphStyleAttributeName : paragraphStyle };
        //        [attributedString addAttributes:dict range:NSMakeRange(0, [textViewText length])];
        //
        //    cell.titleLabel.text = textViewText;
        
        //[cell.titleLabel sizeToFit];
        
        
        
        // More button function (Follow/Block /Report)
        
        if ([[[globalArray valueForKey:@"CanFollow"] objectAtIndex:indexPath.section] integerValue] == 1) {
            
            NSString * moreFollowString = [NSString stringWithFormat:@"Follow %@",[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:indexPath.section]];
            
            [cell.moreFollow setTitle:moreFollowString forState: UIControlStateNormal];
            
        }
        
        if ([[[globalArray valueForKey:@"CanFollow"] objectAtIndex:indexPath.section] integerValue] == 0) {
            NSString * moreFollowString = [NSString stringWithFormat:@"Unfollow %@",[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:indexPath.section]];
            
            [cell.moreFollow setTitle:moreFollowString forState: UIControlStateNormal];
            
            
        }
        
        if ( [[[globalArray valueForKey:@"CanBlock"] objectAtIndex:indexPath.section] integerValue] == 1) {
            
            NSString * moreFollowString = [NSString stringWithFormat:@"Block %@",[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:indexPath.section]];
            
            [cell.moreBlock setTitle:moreFollowString forState: UIControlStateNormal];
            
        }
        
        else if ( [[[globalArray valueForKey:@"CanBlock"] objectAtIndex:indexPath.section] integerValue] == 0){
            
            
            NSString * moreFollowString = [NSString stringWithFormat:@"Unblock %@",[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:indexPath.section]];
            
            [cell.moreBlock setTitle:moreFollowString forState: UIControlStateNormal];
            
            
        }
        
        [cell.moreReport setTitle:@"Report this post" forState: UIControlStateNormal];
        
        
        //CEll for Image Post
        
        
        if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1) {
            
            
            
            if ([[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 0 || [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 1 || [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 2) {
                
                
                
                
                
                
                //[self.mc pause];
                //             videoplayer.muted = YES;
                //            [videoplayer pause];
                
                
                NSString * locationName = [[globalArray valueForKey:@"LocationName"] objectAtIndex:indexPath.section];
                if ([locationName length] > 0) {
                    [cell.checkInView setHidden:NO];
                    [cell.checkinButton setTitle:locationName forState: UIControlStateNormal];
                }
                
                
                
                
                [cell.proImageView setHidden:NO];
                [cell.buttonOverImage setHidden:NO];
                [cell.voiceView setHidden:YES];
                
                
                
                //Post Image
                
                NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[globalArray valueForKey:@"Image1Idf"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"PostFolderPath"] objectAtIndex:indexPath.section]];
                
                
                
                
                
                //            cell.proImageView.layer.shadowColor = [UIColor blackColor].CGColor;
                //            cell.proImageView.layer.shadowOpacity = 0.3f;
                //            cell.proImageView.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
                //            cell.proImageView.layer.shadowRadius = 4.0f;
                //            cell.proImageView.layer.masksToBounds = NO;
                //
                //            UIBezierPath *path = [UIBezierPath bezierPathWithRect:cell.proImageView.bounds];
                //            cell.proImageView.layer.shadowPath = path.CGPath;
                
                [cell.proImageView  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
                //Post Vote percentage
                
                
                
                
                NSString*percent = @"%";
                
                NSString*vote1 = [NSString stringWithFormat:@"%@ Votes (%@%@)",[[globalArray valueForKey:@"VoteCount1"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section],percent];
                
                
                NSString*vote2 = [NSString stringWithFormat:@"%@ Votes (%@%@)",[[globalArray valueForKey:@"VoteCount2"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section],percent];
                
                
                CGRect buttonFrameNew = CGRectMake(3, 2, resultButtonWidth, resultButtonHeight);
                buttonFrameNew.size = CGSizeMake(resultButtonWidth, resultButtonHeight);
                cell.leftResultButton.frame = buttonFrameNew;
                
                
                CGRect buttonFrameNew2 = CGRectMake(3, 20, resultButtonWidth, resultButtonHeight);
                buttonFrameNew2.size = CGSizeMake(resultButtonWidth, resultButtonHeight);
                cell.rightResultButton.frame = buttonFrameNew2;
                
                
                
                if ([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue]) {
                    
                    
                    
                    if (screenWidthios == 320) {
                        
                        
                        CGRect buttonFrame = cell.leftResultButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.leftResultButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.rightResultButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.rightResultButton.frame = buttonFrame2;
                        
                        
                        
                    }
                    
                    else if (screenWidthios == 375){
                        
                        
                        
                        CGRect buttonFrame = cell.leftResultButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.leftResultButton.frame = buttonFrame;
                        
                        
                        
                        CGRect buttonFrame2 = cell.rightResultButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.rightResultButton.frame = buttonFrame2;
                        
                        
                    }
                    
                    else{
                        
                        
                        
                        CGRect buttonFrame = cell.leftResultButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.leftResultButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.rightResultButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.rightResultButton.frame = buttonFrame2;
                        
                        
                    }
                    
                    
                    cell.leftResultButton.backgroundColor = [UIColor colorWithRed:95/255.0f green:124/255.0f blue:138/255.0f alpha:1.0f];
                    
                    
                    
                    
                    cell.rightResultButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    //                    cell.voteLabelLeft.textColor = [UIColor whiteColor];
                    //                    cell.voteLabelLeft.backgroundColor = [UIColor colorWithRed:55/255.0f green:194/255.0f blue:4/255.0f alpha:1.0f];
                    //
                    //
                    //
                    //                    cell.votesLabelRight.textColor = [UIColor whiteColor];
                    //                    cell.votesLabelRight.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                    
                    //                    [cell.leftWinnerImage setHidden:NO];
                    //                    [cell.rightWinnerImage setHidden:YES];
                    
                }
                
                else if([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] == [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue]){
                    
                    cell.leftResultButton.backgroundColor = [UIColor colorWithRed:162/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    cell.rightResultButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    //                    cell.voteLabelLeft.textColor = [UIColor whiteColor];
                    //                    cell.voteLabelLeft.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                    //
                    //
                    //
                    //                    cell.votesLabelRight.textColor = [UIColor whiteColor];
                    //                    cell.votesLabelRight.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                    //
                    //                    [cell.leftWinnerImage setHidden:YES];
                    //                    [cell.rightWinnerImage setHidden:YES];
                    //
                    
                    
                }
                
                else{
                    
                    
                    cell.leftResultButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f] ;
                    
                    cell.rightResultButton.backgroundColor = [UIColor colorWithRed:95/255.0f green:124/255.0f blue:138/255.0f alpha:1.0f];
                    
                    
                    if (screenWidthios == 320) {
                        
                        
                        CGRect buttonFrame = cell.leftResultButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.leftResultButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.rightResultButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.rightResultButton.frame = buttonFrame2;
                        
                        
                        
                    }
                    
                    else if (screenWidthios == 375){
                        
                        
                        
                        CGRect buttonFrame = cell.leftResultButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.leftResultButton.frame = buttonFrame;
                        
                        
                        
                        CGRect buttonFrame2 = cell.rightResultButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.rightResultButton.frame = buttonFrame2;
                        
                        
                    }
                    
                    else{
                        
                        
                        
                        CGRect buttonFrame = cell.leftResultButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.leftResultButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.rightResultButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.rightResultButton.frame = buttonFrame2;
                        
                        
                    }
                    
                    
                    
                    
                    //
                    //                    cell.voteLabelLeft.textColor = [UIColor whiteColor];
                    //                    cell.voteLabelLeft.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                    //
                    //
                    //
                    //                    cell.votesLabelRight.textColor = [UIColor whiteColor];
                    //                    cell.votesLabelRight.backgroundColor = [UIColor colorWithRed:55/255.0f green:194/255.0f blue:4/255.0f alpha:1.0f];
                    
                    //                    [cell.leftWinnerImage setHidden:YES];
                    //                    [cell.rightWinnerImage setHidden:NO];
                    
                    
                }
                
                cell.voteLabelLeft.text = vote1;
                cell.votesLabelRight.text = vote2;
                
                
                //Total HeyVote Counts
                
                
                NSString* totalVotes = [NSString stringWithFormat:@"%@ HeyVotes",[[globalArray valueForKey:@"VoteCount"] objectAtIndex:indexPath.section]];
                
                cell.totalVotesLabel.text = totalVotes;
                
                
                //Comments Count
                
                if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count]  >1) {
                    
                    NSString * totalComments = [NSString stringWithFormat:@"%ld comments",(long)[[[globalArray valueForKey:@"CommentCount"] objectAtIndex:indexPath.section] integerValue]];
                    
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:totalComments];
                    [attString addAttribute:NSUnderlineStyleAttributeName
                                      value:[NSNumber numberWithInt:1]
                                      range:(NSRange){0,[attString length]}];
                    cell.totalComments.text =totalComments;
                }
                
                else{
                    
                    NSString * totalComments = [NSString stringWithFormat:@"%ld comments",(long)[[[globalArray valueForKey:@"CommentCount"] objectAtIndex:indexPath.section] integerValue]];
                    
                    
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:totalComments];
                    [attString addAttribute:NSUnderlineStyleAttributeName
                                      value:[NSNumber numberWithInt:1]
                                      range:(NSRange){0,[attString length]}];
                    cell.totalComments.text =totalComments;
                    
                }
                
                
                //Post Title
                
                [cell.titleLabelView setHidden:YES];
                
                
                
                //Comment Attribute Label
                
                if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 1) {
                    
                    
                    
                    
                    NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        NSString* localTime = [tr formattedAsTimeAgo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                        
                        
                        //                [cell.commentAttributedLabel setHidden:NO];
                        //                [cell.showMoreComments setHidden:YES];
                        
                        //
                        //      NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                        
                        cell.commentAttributedLabelFirst.text= [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                        
                        
                        NSString * commetAttrTextTwo = localTime;
                        
                        NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                        
                        NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                        
                        
                        
                        CGFloat boldTextFontSize = 12.0f;
                        
                        CGFloat boldTextFontSizeee = 10.0f;
                        
                        //  cell.commentAttributedLabel.text = combinedText;
                        
                        NSRange range1 = [combinedText rangeOfString:commentAttrText];
                        NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                        
                        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                        
                        
                        NSDictionary *attrDict = @{
                                                   NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                                   NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                   };
                        
                        
                        //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                        [attributedText setAttributes:attrDict  range:range2];
                        
                        
                        [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                                range:range1];
                        
                        
                        cell.commentAttributedLabel.attributedText = attributedText;
                        
                        
                        
                        
                    }
                    
                    
                }
                
                
                else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 2) {
                    
                    
                    
                    
                    NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    NSString* localTime;
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTime = [tr formattedAsTimeAgo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwo = localTime;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                    
                    NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                    
                    
                    
                    CGFloat boldTextFontSize = 12.0f;
                    
                    CGFloat boldTextFontSizeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range1 = [combinedText rangeOfString:commentAttrText];
                    NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                    
                    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                    
                    
                    NSDictionary *attrDict = @{
                                               NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                               NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                               };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedText setAttributes:attrDict  range:range2];
                    
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                            range:range1];
                    
                    
                    cell.commentAttributedLabel.attributedText = attributedText;
                    
                    
                    
                    
                    
                    NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                    
                    
                    NSString *yStringg = [splitStringg objectAtIndex:1];
                    
                    NSString* localTimee;
                    
                    if ([yStringg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimee = [tr formattedAsTimeAgoTwo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwoo = localTimee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellSecond.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                    
                    NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                    
                    NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                    
                    
                    
                    CGFloat boldTextFontSizee = 12.0f;
                    
                    CGFloat boldTextFontSizeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                    NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                    
                    NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                    
                    
                    NSDictionary *attrDictt = @{
                                                NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                                NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTextt setAttributes:attrDictt  range:range22];
                    
                    [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                             range:range11];
                    
                    
                    cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                    
                    
                    
                    
                }
                
                
                else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 3) {
                    
                    
                    
                    
                    
                    
                    NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    NSString* localTime;
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTime = [tr formattedAsTimeAgo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwo = localTime;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedLabelFirst.text =  cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                    
                    NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                    
                    
                    
                    CGFloat boldTextFontSize = 12.0f;
                    
                    CGFloat boldTextFontSizeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range1 = [combinedText rangeOfString:commentAttrText];
                    NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                    
                    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                    
                    
                    NSDictionary *attrDict = @{
                                               NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                               NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                               };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedText setAttributes:attrDict  range:range2];
                    
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                            range:range1];
                    
                    
                    cell.commentAttributedLabel.attributedText = attributedText;
                    
                    
                    
                    
                    
                    NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                    
                    
                    NSString *yStringg = [splitStringg objectAtIndex:1];
                    
                    NSString* localTimee;
                    
                    if ([yStringg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimee = [tr formattedAsTimeAgoTwo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwoo = localTimee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellSecond.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                    
                    NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                    
                    NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                    
                    
                    
                    CGFloat boldTextFontSizee = 12.0f;
                    
                    CGFloat boldTextFontSizeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                    NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                    
                    NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                    
                    
                    NSDictionary *attrDictt = @{
                                                NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                                NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTextt setAttributes:attrDictt  range:range22];
                    
                    [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                             range:range11];
                    
                    
                    cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                    
                    
                    
                    
                    
                    
                    
                    
                    NSString *stringTimerrr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:2];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimitersss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringgg = [stringTimerrr componentsSeparatedByCharactersInSet:delimitersss];
                    
                    
                    NSString *yStringgg = [splitStringgg objectAtIndex:1];
                    
                    NSString* localTimeee;
                    
                    if ([yStringgg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringgg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimeee = [tr formattedAsTimeAgoThree];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimeee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwooo = localTimeee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellThird.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:2];
                    
                    
                    NSString * commentAttrTexttt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:2];
                    
                    NSString * combinedTexttt = [NSString stringWithFormat:@"%@  %@",commentAttrTexttt,commetAttrTextTwooo];
                    
                    
                    
                    CGFloat boldTextFontSizeeeee = 12.0f;
                    
                    CGFloat boldTextFontSizeeeeeeeeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range111 = [combinedTexttt rangeOfString:commentAttrTexttt];
                    NSRange range222 = [combinedTexttt rangeOfString:commetAttrTextTwooo];
                    
                    NSMutableAttributedString *attributedTexttt = [[NSMutableAttributedString alloc] initWithString:combinedTexttt];
                    
                    
                    NSDictionary *attrDicttt = @{
                                                 NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeeeeeeeeee],
                                                 NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                 };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTexttt setAttributes:attrDicttt  range:range222];
                    
                    [attributedTexttt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizeeeee]}
                                              range:range111];
                    
                    
                    cell.commentAttributedLabelThree.attributedText = attributedTexttt;
                    
                    
                    
                    
                }
                
                
                
                else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] > 3) {
                    
                    
                    
                    
                    
                    
                    NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    NSString* localTime;
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTime = [tr formattedAsTimeAgo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwo = localTime;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                    
                    NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                    
                    
                    
                    CGFloat boldTextFontSize = 12.0f;
                    
                    CGFloat boldTextFontSizeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range1 = [combinedText rangeOfString:commentAttrText];
                    NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                    
                    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                    
                    
                    NSDictionary *attrDict = @{
                                               NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                               NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                               };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedText setAttributes:attrDict  range:range2];
                    
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                            range:range1];
                    
                    
                    cell.commentAttributedLabel.attributedText = attributedText;
                    
                    
                    
                    
                    
                    NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                    
                    
                    NSString *yStringg = [splitStringg objectAtIndex:1];
                    
                    NSString* localTimee;
                    
                    if ([yStringg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimee = [tr formattedAsTimeAgoTwo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwoo = localTimee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellSecond.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                    
                    NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                    
                    NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                    
                    
                    
                    CGFloat boldTextFontSizee = 12.0f;
                    
                    CGFloat boldTextFontSizeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                    NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                    
                    NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                    
                    
                    NSDictionary *attrDictt = @{
                                                NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                                NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTextt setAttributes:attrDictt  range:range22];
                    
                    [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                             range:range11];
                    
                    
                    cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                    
                    
                    
                    
                    
                    
                    
                    
                    NSString *stringTimerrr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:2];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimitersss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringgg = [stringTimerrr componentsSeparatedByCharactersInSet:delimitersss];
                    
                    
                    NSString *yStringgg = [splitStringgg objectAtIndex:1];
                    
                    NSString* localTimeee;
                    
                    if ([yStringgg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringgg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimeee = [tr formattedAsTimeAgoThree];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimeee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwooo = localTimeee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellThird.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:2];
                    
                    
                    NSString * commentAttrTexttt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:2];
                    
                    NSString * combinedTexttt = [NSString stringWithFormat:@"%@  %@",commentAttrTexttt,commetAttrTextTwooo];
                    
                    
                    
                    CGFloat boldTextFontSizeeeee = 12.0f;
                    
                    CGFloat boldTextFontSizeeeeeeeeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range111 = [combinedTexttt rangeOfString:commentAttrTexttt];
                    NSRange range222 = [combinedTexttt rangeOfString:commetAttrTextTwooo];
                    
                    NSMutableAttributedString *attributedTexttt = [[NSMutableAttributedString alloc] initWithString:combinedTexttt];
                    
                    
                    NSDictionary *attrDicttt = @{
                                                 NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeeeeeeeeee],
                                                 NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                 };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTexttt setAttributes:attrDicttt  range:range222];
                    
                    [attributedTexttt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizeeeee]}
                                              range:range111];
                    
                    
                    cell.commentAttributedLabelThree.attributedText = attributedTexttt;
                    
                    
                    
                    
                    
                    [cell.showMoreComments setHidden:NO];
                    [cell.totalComments setHidden:YES];
                    
                }
                
                // Post is Live Or Done
                
                if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0 ) {
                    
                    
                    
                    // [cell.timerCell setHidden:NO];
                    // [cell.remainingLabel setHidden:NO];
                    
                    
                    NSString *stringTimer =[[globalArray valueForKey:@"EndDate"] objectAtIndex:indexPath.section];
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    NSString *xString = [splitString objectAtIndex:0];
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        
                        NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTime:%@", localTime);
                        
                        NSDateFormatter *dateFormatterCurrent=[[NSDateFormatter alloc] init];
                        [dateFormatterCurrent setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                        
                        
                        
                        NSString* localCurrentTime = [dateFormatterCurrent stringFromDate:[NSDate date]];
                        //   NSLog(@"current time :%@",localCurrentTime);
                        
                        NSTimeInterval diff = [tr timeIntervalSinceDate:[NSDate date]];
                        
                        //  NSLog(@"difffereeenceee %f",diff*1000 );
                        
                        valText = diff*1000;
                        
                        
                        float seconds = valText / 1000.0;
                        float minutes = seconds / 60.0;
                        
                        
                        testVa = minutes/1440;
                        
                        
                        
                        //                    float percentVal = testVa * 100;
                        //
                        //                    float percentFinalVal = percentVal/100
                        //
                        
                        if ([[self calculateTimer] isEqualToString:@""]) {
                            [cell.timerCell setHidden:YES];
                            [cell.progresssView setHidden:YES];
                        }
                        
                        else{
                            
                            cell.timerCell.text =  [self calculateTimer];
                            
                            
                            
                        }
                        
                        //
                        //                    if (valText >0 && valText <86400000 ) {
                        ////                        _timerCalc = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runScheduledTask:) userInfo:nil repeats:NO];
                        //
                        //
                        //                        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(valText / 1000.0)];
                        //
                        //                        NSString* localTimeee =[NSString stringWithFormat:@"%@",date];
                        //
                        //                        NSArray *seperateVal =  [localTimeee componentsSeparatedByString:@" "];
                        //
                        //                        NSArray *timeSplit = [[seperateVal objectAtIndex:1] componentsSeparatedByString:@":"];
                        //
                        //
                        //                      NSString*  exactTimeee = [NSString stringWithFormat:@"%@h. %@m. %@s.",[timeSplit objectAtIndex:0],[timeSplit objectAtIndex:1],[timeSplit objectAtIndex:2]];
                        //
                        //                        cell.timerCell.text  = exactTimeee;
                        //
                        //                        NSLog(@"timerrrr : %@",cell.timerCell.text);
                        //
                        //
                        //
                        //                    }
                        //
                        //
                        //
                        
                    }
                    
                    
                    
                    /*******/
                    [cell.yesNoMainView setHidden:NO];
                    [cell.yesNoButtonView setHidden:YES];
                    [cell.yesNoNotDoneButtonView setHidden:NO];
                    cell.leftButton.userInteractionEnabled = YES;
                    cell.rightButton.userInteractionEnabled = YES;
                    
                    [cell.leftButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.rightButton setBackgroundColor:[UIColor whiteColor]];
                    
                    [cell.reheyVoteButton setHidden:YES];
                    
                    
                    //Has Voted Or not Button View
                    
                    
                    if ([[[globalArray valueForKey:@"hasVoted"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                        
                        if ([voteResultAraay containsObject:[globalArray objectAtIndex:indexPath.section]]) {
                            
                            
                            
                            if ([voteResultVal isEqualToString:@"leftvoted"] || [voteResultVal isEqualToString:@"rightvoted"]) {
                                
                                
                                [cell.progresssView setHidden:NO];
                                [cell.timerCell setHidden:NO];
                                [cell.remainingLabel setHidden:NO];
                                
                                cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                          green:0.0f/255.0f
                                                                                           blue:20.0f/255.0f
                                                                                          alpha:0.7f];
                                cell.circularProgress.max = 1.0f;
                                cell.circularProgress.fillRadiusPx = 25;
                                cell.circularProgress.step = 0.1f;
                                cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                                cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                                cell.circularProgress.outlineWidth = 1;
                                cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                                cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                                
                                
                                [[HKCircularProgressView appearance] setAnimationDuration:5];
                                
                                cell.circularProgress.alwaysDrawOutline = YES;
                                
                                
                                cell.insideProgress.fillRadius = 1;
                                cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                                cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                                [cell.circularProgress setCurrent:testVa
                                                         animated:YES];
                                [cell.insideProgress setCurrent:1.0f
                                                       animated:YES];
                                
                                
                                
                                NSString*uVoted;
                                
                                // [cell.yesNoMainView setHidden:YES];
                                
                                if ([voteResultVal isEqualToString:@"leftvoted"]) {
                                    
                                    cell.leftButton.userInteractionEnabled = NO;
                                    cell.rightButton.userInteractionEnabled = NO;
                                    
                                    [cell.leftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                        green:200.0f/255.0f
                                                                                         blue:200.0f/255.0f
                                                                                        alpha:1.0f]];
                                    [cell.rightButton setBackgroundColor:[UIColor whiteColor]];
                                    
                                    
                                    
                                }
                                
                                else if([voteResultVal isEqualToString:@"rightvoted"] == 1) {
                                    
                                    
                                    cell.leftButton.userInteractionEnabled = NO;
                                    cell.rightButton.userInteractionEnabled = NO;
                                    
                                    [cell.leftButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.rightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                         green:200.0f/255.0f
                                                                                          blue:200.0f/255.0f
                                                                                         alpha:1.0f]];
                                    
                                    
                                }
                                
                                cell.youHaveVotedLabel.text =uVoted;
                            }
                            
                            else{
                                
                                
                                
                                [cell.yesNoMainView setHidden:NO];
                                [cell.yesNoButtonView setHidden:YES];
                                [cell.yesNoNotDoneButtonView setHidden:NO];
                            }
                            
                        }
                        
                    }
                    
                    else if ([[[globalArray valueForKey:@"hasVoted"] objectAtIndex:indexPath.section] integerValue]  == 1 ) {
                        // [cell.yesNoMainView setHidden:YES];
                        
                        [cell.progresssView setHidden:NO];
                        [cell.timerCell setHidden:NO];
                        [cell.remainingLabel setHidden:NO];
                        
                        cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                  green:0.0f/255.0f
                                                                                   blue:20.0f/255.0f
                                                                                  alpha:0.7f];
                        cell.circularProgress.max = 1.0f;
                        cell.circularProgress.fillRadiusPx = 25;
                        cell.circularProgress.step = 0.1f;
                        cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                        cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        cell.circularProgress.outlineWidth = 1;
                        cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                        cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                        
                        
                        [[HKCircularProgressView appearance] setAnimationDuration:5];
                        
                        cell.circularProgress.alwaysDrawOutline = YES;
                        
                        
                        cell.insideProgress.fillRadius = 1;
                        cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                        cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        [cell.circularProgress setCurrent:testVa
                                                 animated:YES];
                        [cell.insideProgress setCurrent:1.0f
                                               animated:YES];
                        
                        
                        
                        
                        NSString*uVoted;
                        
                        
                        if ([[[globalArray valueForKey:@"VoteOption"] objectAtIndex:indexPath.section] integerValue] == 0) {
                            
                            cell.leftButton.userInteractionEnabled = NO;
                            cell.rightButton.userInteractionEnabled = NO;
                            
                            [cell.leftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                green:200.0f/255.0f
                                                                                 blue:200.0f/255.0f
                                                                                alpha:1.0f]];
                            [cell.rightButton setBackgroundColor:[UIColor whiteColor]];
                            
                            
                        }
                        
                        else if([[[globalArray valueForKey:@"VoteOption"] objectAtIndex:indexPath.section] integerValue] == 1) {
                            
                            cell.leftButton.userInteractionEnabled = NO;
                            cell.rightButton.userInteractionEnabled = NO;
                            
                            
                            
                            [cell.leftButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.rightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                 green:200.0f/255.0f
                                                                                  blue:200.0f/255.0f
                                                                                 alpha:1.0f]];
                            
                            
                        }
                        
                        cell.youHaveVotedLabel.text =uVoted;
                    }
                    
                    
                    
                    
                    
                }
                
                
                
                else if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 1) {
                    [cell.timerCell setHidden:YES];
                    [cell.remainingLabel setHidden:YES];
                    
                    [cell.yesNoMainView setHidden:NO];
                    [cell.yesNoButtonView setHidden:NO];
                    [cell.yesNoNotDoneButtonView setHidden:YES];
                    cell.leftButton.userInteractionEnabled = NO;
                    cell.rightButton.userInteractionEnabled = NO;
                    
                    
                    [cell.reheyVoteButton setHidden:NO];
                    
                }
                
                
                
                //Button Caption (YES/NO)
                [cell.leftButton setTitle:[[globalArray valueForKey:@"Caption1"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                [cell.rightButton setTitle:[[globalArray valueForKey:@"Caption2"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                [cell.leftResultButton setTitle:[[globalArray valueForKey:@"Caption1"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                [cell.rightResultButton setTitle:[[globalArray valueForKey:@"Caption2"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                //   return cell;
                
                
                
                
            }
            
            else if ([[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 3){
                
                
                
                
                
                
                //[self.mc pause];
                //             videoplayer.muted = YES;
                //            [videoplayer pause];
                
                
                NSString * locationName = [[globalArray valueForKey:@"LocationName"] objectAtIndex:indexPath.section];
                if ([locationName length] > 0) {
                    [cell.checkInView setHidden:NO];
                    [cell.checkinButton setTitle:locationName forState: UIControlStateNormal];
                }
                
                
                
                
                [cell.proImageView setHidden:NO];
                //   [cell.buttonOverImage setHidden:NO];
                [cell.voiceView setHidden:YES];
                
                
                
                //Post Image
                
                NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[globalArray valueForKey:@"Image1Idf"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"PostFolderPath"] objectAtIndex:indexPath.section]];
                
                
                
                
                
                //            cell.proImageView.layer.shadowColor = [UIColor blackColor].CGColor;
                //            cell.proImageView.layer.shadowOpacity = 0.3f;
                //            cell.proImageView.layer.shadowOffset = CGSizeMake(10.0f, 10.0f);
                //            cell.proImageView.layer.shadowRadius = 4.0f;
                //            cell.proImageView.layer.masksToBounds = NO;
                //
                //            UIBezierPath *path = [UIBezierPath bezierPathWithRect:cell.proImageView.bounds];
                //            cell.proImageView.layer.shadowPath = path.CGPath;
                
                [cell.proImageView  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
                //Post Vote percentage
                
                
                
                
                NSString*percent = @"%";
                
                NSString*vote1 = [NSString stringWithFormat:@"%@ Votes (%@%@)",[[globalArray valueForKey:@"VoteCount1"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section],percent];
                
                
                NSString*vote2 = [NSString stringWithFormat:@"%@ Votes (%@%@)",[[globalArray valueForKey:@"VoteCount2"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section],percent];
                
                
                NSString*vote3 = [NSString stringWithFormat:@"%@ Votes (%@%@)",[[globalArray valueForKey:@"VoteCount3"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section],percent];
                
                //
                //                if ([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue]) {
                //                    cell.voteLabelLeft.textColor = [UIColor whiteColor];
                //                    cell.voteLabelLeft.backgroundColor = [UIColor colorWithRed:55/255.0f green:194/255.0f blue:4/255.0f alpha:1.0f];
                //
                //
                //
                //                    cell.votesLabelRight.textColor = [UIColor whiteColor];
                //                    cell.votesLabelRight.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                //
                //                    [cell.leftWinnerImage setHidden:NO];
                //                    [cell.rightWinnerImage setHidden:YES];
                //
                //                }
                //
                //                else if([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] == [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue]){
                //
                //                    cell.voteLabelLeft.textColor = [UIColor whiteColor];
                //                    cell.voteLabelLeft.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                //
                //
                //
                //                    cell.votesLabelRight.textColor = [UIColor whiteColor];
                //                    cell.votesLabelRight.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                //
                //                    [cell.leftWinnerImage setHidden:YES];
                //                    [cell.rightWinnerImage setHidden:YES];
                //
                //
                //
                //
                //                }
                //
                //                else{
                //
                //
                //                    cell.voteLabelLeft.textColor = [UIColor whiteColor];
                //                    cell.voteLabelLeft.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                //
                //
                //
                //                    cell.votesLabelRight.textColor = [UIColor whiteColor];
                //                    cell.votesLabelRight.backgroundColor = [UIColor colorWithRed:55/255.0f green:194/255.0f blue:4/255.0f alpha:1.0f];
                //
                //                    [cell.leftWinnerImage setHidden:YES];
                //                    [cell.rightWinnerImage setHidden:NO];
                //
                //                    //
                //                    //                [cell.leftTickImage setHidden:YES];
                //                    //                [cell.rightTickImage setHidden:NO];
                //                }
                //
                
                
                
                
                
                if ([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] && [[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] ) {
                    
                    
                    
                    
                    
                    
                    if (screenWidthios == 320) {
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                        
                    }
                    
                    else if (screenWidthios == 375){
                        
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                        
                    }
                    
                    else{
                        
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                    }
                    
                    
                    
                    
                    //  cell.threeVersusFinalLeftVote.textColor = [UIColor whiteColor];
                    cell.threeVersusFinalLeftButton.backgroundColor = [UIColor colorWithRed:95/255.0f green:124/255.0f blue:138/255.0f alpha:1.0f];
                    
                    
                    
                    // cell.threeVersusFinalRightVote.textColor = [UIColor whiteColor];
                    cell.threeVersusFinalRightButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    //   cell.threeVersusVotesLabelRight.textColor = [UIColor whiteColor];
                    cell.threeVersusRightResultButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    //                [cell.threeVersusFinalWinnerLeft setHidden:NO];
                    //                [cell.threeVersusFinalWinnerRight setHidden:YES];
                    //                  [cell.threeVersusRightWinnerImage setHidden:YES];
                    
                }
                
                else if ([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] && [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue]){
                    
                    
                    
                    
                    
                    if (screenWidthios == 320) {
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                        
                    }
                    
                    else if (screenWidthios == 375){
                        
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                        
                    }
                    
                    else{
                        
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                    }
                    
                    
                    
                    
                    
                    // cell.threeVersusFinalLeftVote.textColor = [UIColor whiteColor];
                    cell.threeVersusFinalLeftButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    //   cell.threeVersusFinalRightVote.textColor = [UIColor whiteColor];
                    cell.threeVersusFinalRightButton.backgroundColor = [UIColor colorWithRed:95/255.0f green:124/255.0f blue:138/255.0f alpha:1.0f];
                    
                    
                    
                    //  cell.threeVersusVotesLabelRight.textColor = [UIColor whiteColor];
                    cell.threeVersusRightResultButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    //                  [cell.threeVersusFinalWinnerLeft setHidden:YES];
                    //                  [cell.threeVersusFinalWinnerRight setHidden:NO];
                    //                  [cell.threeVersusRightWinnerImage setHidden:YES];
                    
                }
                
                else if ([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] && [[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue]){
                    
                    
                    
                    
                    
                    if (screenWidthios == 320) {
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                        
                    }
                    
                    else if (screenWidthios == 375){
                        
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                        
                    }
                    
                    else{
                        
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                    }
                    
                    
                    
                    //cell.threeVersusFinalLeftVote.textColor = [UIColor whiteColor];
                    cell.threeVersusFinalLeftButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    // cell.threeVersusFinalRightVote.textColor = [UIColor whiteColor];
                    cell.threeVersusFinalRightButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    // cell.threeVersusVotesLabelRight.textColor = [UIColor whiteColor];
                    cell.threeVersusRightResultButton.backgroundColor = [UIColor colorWithRed:95/255.0f green:124/255.0f blue:138/255.0f alpha:1.0f];
                    //
                    //                  [cell.threeVersusFinalWinnerLeft setHidden:YES];
                    //                  [cell.threeVersusFinalWinnerRight setHidden:YES];
                    //                  [cell.threeVersusRightWinnerImage setHidden:NO];
                    
                }
                
                else{
                    //   cell.threeVersusFinalLeftVote.textColor = [UIColor whiteColor];
                    
                    
                    
                    
                    if (screenWidthios == 320) {
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                        
                    }
                    
                    else if (screenWidthios == 375){
                        
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                        
                    }
                    
                    else{
                        
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                    }
                    
                    
                    
                    cell.threeVersusFinalLeftButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    //  cell.threeVersusFinalRightVote.textColor = [UIColor whiteColor];
                    cell.threeVersusFinalRightButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    //  cell.threeVersusVotesLabelRight.textColor = [UIColor whiteColor];
                    cell.threeVersusRightResultButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    //                  [cell.threeVersusFinalWinnerLeft setHidden:YES];
                    //                  [cell.threeVersusFinalWinnerRight setHidden:YES];
                    //                  [cell.threeVersusRightWinnerImage setHidden:YES];
                    
                    
                    
                    
                    
                    if (screenWidthios == 320) {
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                        
                    }
                    
                    else if (screenWidthios == 375){
                        
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                        
                    }
                    
                    else{
                        
                        
                        
                        CGRect buttonFrame = cell.threeVersusFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.threeVersusFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.threeVersusRightResultButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.threeVersusRightResultButton.frame = buttonFrame3;
                        
                        
                    }
                    
                    
                    
                }
                
                
                
                
                
                
                cell.threeVersusFinalLeftVote.text = vote1;
                cell.threeVersusFinalRightVote.text = vote2;
                cell.threeVersusVotesLabelRight.text = vote3;
                
                
                //Total HeyVote Counts
                
                
                NSString* totalVotes = [NSString stringWithFormat:@"%@ HeyVotes",[[globalArray valueForKey:@"VoteCount"] objectAtIndex:indexPath.section]];
                
                cell.totalVotesLabel.text = totalVotes;
                
                
                //Comments Count
                
                if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count]  >1) {
                    
                    NSString * totalComments = [NSString stringWithFormat:@"%ld comments",(long)[[[globalArray valueForKey:@"CommentCount"] objectAtIndex:indexPath.section] integerValue]];
                    
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:totalComments];
                    [attString addAttribute:NSUnderlineStyleAttributeName
                                      value:[NSNumber numberWithInt:1]
                                      range:(NSRange){0,[attString length]}];
                    cell.totalComments.text =totalComments;
                }
                
                else{
                    
                    NSString * totalComments = [NSString stringWithFormat:@"%ld comments",(long)[[[globalArray valueForKey:@"CommentCount"] objectAtIndex:indexPath.section] integerValue]];
                    
                    
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:totalComments];
                    [attString addAttribute:NSUnderlineStyleAttributeName
                                      value:[NSNumber numberWithInt:1]
                                      range:(NSRange){0,[attString length]}];
                    cell.totalComments.text =totalComments;
                    
                }
                
                
                //Post Title
                
                [cell.titleLabelView setHidden:YES];
                
                
                
                //Comment Attribute Label
                
                if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 1) {
                    
                    
                    
                    
                    NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        NSString* localTime = [tr formattedAsTimeAgo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                        
                        
                        //                [cell.commentAttributedLabel setHidden:NO];
                        //                [cell.showMoreComments setHidden:YES];
                        
                        //
                        //      NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                        
                        cell.commentAttributedLabelFirst.text= [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                        
                        
                        NSString * commetAttrTextTwo = localTime;
                        
                        NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                        
                        NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                        
                        
                        
                        CGFloat boldTextFontSize = 12.0f;
                        
                        CGFloat boldTextFontSizeee = 10.0f;
                        
                        //  cell.commentAttributedLabel.text = combinedText;
                        
                        NSRange range1 = [combinedText rangeOfString:commentAttrText];
                        NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                        
                        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                        
                        
                        NSDictionary *attrDict = @{
                                                   NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                                   NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                   };
                        
                        
                        //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                        [attributedText setAttributes:attrDict  range:range2];
                        
                        
                        [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                                range:range1];
                        
                        
                        cell.commentAttributedLabel.attributedText = attributedText;
                        
                        
                        
                        
                    }
                    
                    
                }
                
                
                else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 2) {
                    
                    
                    
                    
                    NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    NSString* localTime;
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTime = [tr formattedAsTimeAgo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwo = localTime;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                    
                    NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                    
                    
                    
                    CGFloat boldTextFontSize = 12.0f;
                    
                    CGFloat boldTextFontSizeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range1 = [combinedText rangeOfString:commentAttrText];
                    NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                    
                    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                    
                    
                    NSDictionary *attrDict = @{
                                               NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                               NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                               };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedText setAttributes:attrDict  range:range2];
                    
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                            range:range1];
                    
                    
                    cell.commentAttributedLabel.attributedText = attributedText;
                    
                    
                    
                    
                    
                    NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                    
                    
                    NSString *yStringg = [splitStringg objectAtIndex:1];
                    
                    NSString* localTimee;
                    
                    if ([yStringg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimee = [tr formattedAsTimeAgoTwo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwoo = localTimee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellSecond.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                    
                    NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                    
                    NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                    
                    
                    
                    CGFloat boldTextFontSizee = 12.0f;
                    
                    CGFloat boldTextFontSizeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                    NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                    
                    NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                    
                    
                    NSDictionary *attrDictt = @{
                                                NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                                NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTextt setAttributes:attrDictt  range:range22];
                    
                    [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                             range:range11];
                    
                    
                    cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                    
                    
                    
                    
                }
                
                
                else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 3) {
                    
                    
                    
                    
                    
                    
                    NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    NSString* localTime;
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTime = [tr formattedAsTimeAgo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwo = localTime;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedLabelFirst.text =  cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                    
                    NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                    
                    
                    
                    CGFloat boldTextFontSize = 12.0f;
                    
                    CGFloat boldTextFontSizeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range1 = [combinedText rangeOfString:commentAttrText];
                    NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                    
                    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                    
                    
                    NSDictionary *attrDict = @{
                                               NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                               NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                               };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedText setAttributes:attrDict  range:range2];
                    
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                            range:range1];
                    
                    
                    cell.commentAttributedLabel.attributedText = attributedText;
                    
                    
                    
                    
                    
                    NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                    
                    
                    NSString *yStringg = [splitStringg objectAtIndex:1];
                    
                    NSString* localTimee;
                    
                    if ([yStringg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimee = [tr formattedAsTimeAgoTwo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwoo = localTimee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellSecond.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                    
                    NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                    
                    NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                    
                    
                    
                    CGFloat boldTextFontSizee = 12.0f;
                    
                    CGFloat boldTextFontSizeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                    NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                    
                    NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                    
                    
                    NSDictionary *attrDictt = @{
                                                NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                                NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTextt setAttributes:attrDictt  range:range22];
                    
                    [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                             range:range11];
                    
                    
                    cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                    
                    
                    
                    
                    
                    
                    
                    
                    NSString *stringTimerrr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:2];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimitersss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringgg = [stringTimerrr componentsSeparatedByCharactersInSet:delimitersss];
                    
                    
                    NSString *yStringgg = [splitStringgg objectAtIndex:1];
                    
                    NSString* localTimeee;
                    
                    if ([yStringgg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringgg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimeee = [tr formattedAsTimeAgoThree];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimeee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwooo = localTimeee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellThird.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:2];
                    
                    
                    NSString * commentAttrTexttt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:2];
                    
                    NSString * combinedTexttt = [NSString stringWithFormat:@"%@  %@",commentAttrTexttt,commetAttrTextTwooo];
                    
                    
                    
                    CGFloat boldTextFontSizeeeee = 12.0f;
                    
                    CGFloat boldTextFontSizeeeeeeeeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range111 = [combinedTexttt rangeOfString:commentAttrTexttt];
                    NSRange range222 = [combinedTexttt rangeOfString:commetAttrTextTwooo];
                    
                    NSMutableAttributedString *attributedTexttt = [[NSMutableAttributedString alloc] initWithString:combinedTexttt];
                    
                    
                    NSDictionary *attrDicttt = @{
                                                 NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeeeeeeeeee],
                                                 NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                 };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTexttt setAttributes:attrDicttt  range:range222];
                    
                    [attributedTexttt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizeeeee]}
                                              range:range111];
                    
                    
                    cell.commentAttributedLabelThree.attributedText = attributedTexttt;
                    
                    
                    
                    
                }
                
                
                
                else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] > 3) {
                    
                    
                    
                    
                    
                    
                    NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    NSString* localTime;
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTime = [tr formattedAsTimeAgo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwo = localTime;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                    
                    NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                    
                    
                    
                    CGFloat boldTextFontSize = 12.0f;
                    
                    CGFloat boldTextFontSizeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range1 = [combinedText rangeOfString:commentAttrText];
                    NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                    
                    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                    
                    
                    NSDictionary *attrDict = @{
                                               NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                               NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                               };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedText setAttributes:attrDict  range:range2];
                    
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                            range:range1];
                    
                    
                    cell.commentAttributedLabel.attributedText = attributedText;
                    
                    
                    
                    
                    
                    NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                    
                    
                    NSString *yStringg = [splitStringg objectAtIndex:1];
                    
                    NSString* localTimee;
                    
                    if ([yStringg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimee = [tr formattedAsTimeAgoTwo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwoo = localTimee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellSecond.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                    
                    NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                    
                    NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                    
                    
                    
                    CGFloat boldTextFontSizee = 12.0f;
                    
                    CGFloat boldTextFontSizeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                    NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                    
                    NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                    
                    
                    NSDictionary *attrDictt = @{
                                                NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                                NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTextt setAttributes:attrDictt  range:range22];
                    
                    [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                             range:range11];
                    
                    
                    cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                    
                    
                    
                    
                    
                    
                    
                    
                    NSString *stringTimerrr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:2];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimitersss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringgg = [stringTimerrr componentsSeparatedByCharactersInSet:delimitersss];
                    
                    
                    NSString *yStringgg = [splitStringgg objectAtIndex:1];
                    
                    NSString* localTimeee;
                    
                    if ([yStringgg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringgg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimeee = [tr formattedAsTimeAgoThree];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimeee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwooo = localTimeee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellThird.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:2];
                    
                    
                    NSString * commentAttrTexttt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:2];
                    
                    NSString * combinedTexttt = [NSString stringWithFormat:@"%@  %@",commentAttrTexttt,commetAttrTextTwooo];
                    
                    
                    
                    CGFloat boldTextFontSizeeeee = 12.0f;
                    
                    CGFloat boldTextFontSizeeeeeeeeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range111 = [combinedTexttt rangeOfString:commentAttrTexttt];
                    NSRange range222 = [combinedTexttt rangeOfString:commetAttrTextTwooo];
                    
                    NSMutableAttributedString *attributedTexttt = [[NSMutableAttributedString alloc] initWithString:combinedTexttt];
                    
                    
                    NSDictionary *attrDicttt = @{
                                                 NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeeeeeeeeee],
                                                 NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                 };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTexttt setAttributes:attrDicttt  range:range222];
                    
                    [attributedTexttt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizeeeee]}
                                              range:range111];
                    
                    
                    cell.commentAttributedLabelThree.attributedText = attributedTexttt;
                    
                    
                    
                    
                    
                    [cell.showMoreComments setHidden:NO];
                    [cell.totalComments setHidden:YES];
                    
                }
                
                // Post is Live Or Done
                
                if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0 ) {
                    
                    
                    
                    // [cell.timerCell setHidden:NO];
                    // [cell.remainingLabel setHidden:NO];
                    
                    
                    NSString *stringTimer =[[globalArray valueForKey:@"EndDate"] objectAtIndex:indexPath.section];
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    NSString *xString = [splitString objectAtIndex:0];
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        
                        NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTime:%@", localTime);
                        
                        NSDateFormatter *dateFormatterCurrent=[[NSDateFormatter alloc] init];
                        [dateFormatterCurrent setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                        
                        
                        
                        NSString* localCurrentTime = [dateFormatterCurrent stringFromDate:[NSDate date]];
                        //   NSLog(@"current time :%@",localCurrentTime);
                        
                        NSTimeInterval diff = [tr timeIntervalSinceDate:[NSDate date]];
                        
                        //  NSLog(@"difffereeenceee %f",diff*1000 );
                        
                        valText = diff*1000;
                        
                        
                        float seconds = valText / 1000.0;
                        float minutes = seconds / 60.0;
                        
                        
                        testVa = minutes/1440;
                        
                        
                        
                        //                    float percentVal = testVa * 100;
                        //
                        //                    float percentFinalVal = percentVal/100
                        //
                        
                        if ([[self calculateTimer] isEqualToString:@""]) {
                            [cell.timerCell setHidden:YES];
                            [cell.progresssView setHidden:YES];
                        }
                        
                        else{
                            
                            cell.timerCell.text =  [self calculateTimer];
                            
                            
                            
                        }
                        
                        //
                        //                    if (valText >0 && valText <86400000 ) {
                        ////                        _timerCalc = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runScheduledTask:) userInfo:nil repeats:NO];
                        //
                        //
                        //                        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(valText / 1000.0)];
                        //
                        //                        NSString* localTimeee =[NSString stringWithFormat:@"%@",date];
                        //
                        //                        NSArray *seperateVal =  [localTimeee componentsSeparatedByString:@" "];
                        //
                        //                        NSArray *timeSplit = [[seperateVal objectAtIndex:1] componentsSeparatedByString:@":"];
                        //
                        //
                        //                      NSString*  exactTimeee = [NSString stringWithFormat:@"%@h. %@m. %@s.",[timeSplit objectAtIndex:0],[timeSplit objectAtIndex:1],[timeSplit objectAtIndex:2]];
                        //
                        //                        cell.timerCell.text  = exactTimeee;
                        //
                        //                        NSLog(@"timerrrr : %@",cell.timerCell.text);
                        //
                        //
                        //
                        //                    }
                        //
                        //
                        //
                        
                    }
                    
                    
                    
                    /*******/
                    [cell.threeVersusYesNoMainView setHidden:NO];
                    [cell.threeVersusFirstSecondYesNoMainView setHidden:NO];
                    [cell.threeVersusYesNoButtonView setHidden:YES];
                    [cell.threeVersusFirstSecondYesNoView setHidden:YES];
                    [cell.threeVersusYesNoNotDoneButton setHidden:NO];
                    
                    [cell.threeVersusZeroComment setHidden:NO];
                    
                    
                    [cell.threeVersusFirstSecondNotDoneView setHidden:NO];
                    
                    
                    
                    
                    //  cell.threeVersusFinalLeftButton.userInteractionEnabled = YES;
                    //  cell.threeVersusFinalRightButton.userInteractionEnabled = YES;
                    
                    // [cell.threeVersusFinalLeftButton setBackgroundColor:[UIColor whiteColor]];
                    //  [cell.threeVersusFinalRightButton setBackgroundColor:[UIColor whiteColor]];
                    
                    
                    cell.threeVersusFirstSecondLeftButton.userInteractionEnabled = YES;
                    cell.threeVersusFirstSecondRightButton.userInteractionEnabled = YES;
                    
                    [cell.threeVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.threeVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                    
                    
                    cell.threeVersusRightButton.userInteractionEnabled = YES;
                    //  cell.threeVersusRightResultButton.userInteractionEnabled = YES;
                    
                    [cell.threeVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                    //    [cell.threeVersusRightResultButton setBackgroundColor:[UIColor whiteColor]];
                    
                    
                    [cell.reheyVoteButton setHidden:YES];
                    
                    
                    //Has Voted Or not Button View
                    
                    
                    if ([[[globalArray valueForKey:@"hasVoted"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                        
                        if ([voteResultAraayThreeVersus containsObject:[globalArray objectAtIndex:indexPath.section]]) {
                            
                            
                            
                            if ([voteResultValThreeVersus isEqualToString:@"leftvoted"] || [voteResultValThreeVersus isEqualToString:@"rightvoted"] || [voteResultValThreeVersus isEqualToString:@"downvoted"] ) {
                                
                                
                                
                                
                                [cell.progresssView setHidden:NO];
                                [cell.timerCell setHidden:NO];
                                [cell.remainingLabel setHidden:NO];
                                
                                cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                          green:0.0f/255.0f
                                                                                           blue:20.0f/255.0f
                                                                                          alpha:0.7f];
                                cell.circularProgress.max = 1.0f;
                                cell.circularProgress.fillRadiusPx = 25;
                                cell.circularProgress.step = 0.1f;
                                cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                                cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                                cell.circularProgress.outlineWidth = 1;
                                cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                                cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                                
                                
                                [[HKCircularProgressView appearance] setAnimationDuration:5];
                                
                                cell.circularProgress.alwaysDrawOutline = YES;
                                
                                
                                cell.insideProgress.fillRadius = 1;
                                cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                                cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                                [cell.circularProgress setCurrent:testVa
                                                         animated:YES];
                                [cell.insideProgress setCurrent:1.0f
                                                       animated:YES];
                                
                                
                                
                                NSString*uVoted;
                                
                                // [cell.yesNoMainView setHidden:YES];
                                
                                if ([voteResultValThreeVersus isEqualToString:@"leftvoted"]) {
                                    
                                    cell.threeVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                                    cell.threeVersusFirstSecondRightButton.userInteractionEnabled = NO;
                                    cell.threeVersusRightButton.userInteractionEnabled = NO;
                                    
                                    [cell.threeVersusFirstSecondLeftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                                              green:200.0f/255.0f
                                                                                                               blue:200.0f/255.0f
                                                                                                              alpha:1.0f]];
                                    [cell.threeVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.threeVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                                    
                                    
                                    
                                }
                                
                                else if([voteResultValThreeVersus isEqualToString:@"rightvoted"] ) {
                                    
                                    cell.threeVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                                    cell.threeVersusFirstSecondRightButton.userInteractionEnabled = NO;
                                    cell.threeVersusRightButton.userInteractionEnabled = NO;
                                    
                                    [cell.threeVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.threeVersusFirstSecondRightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                                               green:200.0f/255.0f
                                                                                                                blue:200.0f/255.0f
                                                                                                               alpha:1.0f]];
                                    [cell.threeVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                                    
                                    
                                    
                                }
                                
                                
                                
                                else if([voteResultValThreeVersus isEqualToString:@"downvoted"] ) {
                                    
                                    cell.threeVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                                    cell.threeVersusFirstSecondRightButton.userInteractionEnabled = NO;
                                    cell.threeVersusRightButton.userInteractionEnabled = NO;
                                    
                                    [cell.threeVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.threeVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.threeVersusRightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                                    green:200.0f/255.0f
                                                                                                     blue:200.0f/255.0f
                                                                                                    alpha:1.0f]];
                                    
                                    
                                    
                                }
                                
                                cell.youHaveVotedLabel.text =uVoted;
                            }
                            
                            
                            
                            else{
                                
                                
                                
                                [cell.threeVersusYesNoMainView setHidden:NO];
                                [cell.threeVersusYesNoButtonView setHidden:YES];
                                [cell.threeVersusYesNoNotDoneButton setHidden:NO];
                                
                                [cell.threeVersusZeroComment setHidden:NO];
                                [cell.threeVersusFirstSecondYesNoMainView setHidden:NO];
                                [cell.threeVersusFirstSecondYesNoView setHidden:YES];
                                [cell.threeVersusFirstSecondNotDoneView setHidden:NO];
                                
                            }
                            
                        }
                        
                    }
                    
                    else if ([[[globalArray valueForKey:@"hasVoted"] objectAtIndex:indexPath.section] integerValue]  == 1 ) {
                        // [cell.yesNoMainView setHidden:YES];
                        
                        [cell.progresssView setHidden:NO];
                        [cell.timerCell setHidden:NO];
                        [cell.remainingLabel setHidden:NO];
                        
                        cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                  green:0.0f/255.0f
                                                                                   blue:20.0f/255.0f
                                                                                  alpha:0.7f];
                        cell.circularProgress.max = 1.0f;
                        cell.circularProgress.fillRadiusPx = 25;
                        cell.circularProgress.step = 0.1f;
                        cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                        cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        cell.circularProgress.outlineWidth = 1;
                        cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                        cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                        
                        
                        [[HKCircularProgressView appearance] setAnimationDuration:5];
                        
                        cell.circularProgress.alwaysDrawOutline = YES;
                        
                        
                        cell.insideProgress.fillRadius = 1;
                        cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                        cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        [cell.circularProgress setCurrent:testVa
                                                 animated:YES];
                        [cell.insideProgress setCurrent:1.0f
                                               animated:YES];
                        
                        
                        
                        
                        NSString*uVoted;
                        
                        
                        
                        if ([[[globalArray valueForKey:@"VotedFor"] objectAtIndex:indexPath.section] integerValue] == 0) {
                            
                            cell.threeVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                            cell.threeVersusFirstSecondRightButton.userInteractionEnabled = NO;
                            cell.threeVersusRightButton.userInteractionEnabled = NO;
                            
                            [cell.threeVersusFirstSecondLeftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                                      green:200.0f/255.0f
                                                                                                       blue:200.0f/255.0f
                                                                                                      alpha:1.0f]];
                            [cell.threeVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.threeVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                            
                            
                            
                            
                        }
                        
                        else if([[[globalArray valueForKey:@"VotedFor"] objectAtIndex:indexPath.section] integerValue] == 1) {
                            
                            
                            cell.threeVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                            cell.threeVersusFirstSecondRightButton.userInteractionEnabled = NO;
                            cell.threeVersusRightButton.userInteractionEnabled = NO;
                            
                            [cell.threeVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.threeVersusFirstSecondRightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                                       green:200.0f/255.0f
                                                                                                        blue:200.0f/255.0f
                                                                                                       alpha:1.0f]];
                            [cell.threeVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                            
                        }
                        
                        
                        
                        else if([[[globalArray valueForKey:@"VotedFor"] objectAtIndex:indexPath.section] integerValue] == 2) {
                            
                            
                            cell.threeVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                            cell.threeVersusFirstSecondRightButton.userInteractionEnabled = NO;
                            cell.threeVersusRightButton.userInteractionEnabled = NO;
                            
                            [cell.threeVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.threeVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.threeVersusRightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                            green:200.0f/255.0f
                                                                                             blue:200.0f/255.0f
                                                                                            alpha:1.0f]];
                            
                            
                            
                            
                        }
                        
                    }
                    
                    
                }
                
                
                
                else if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 1) {
                    [cell.timerCell setHidden:YES];
                    [cell.remainingLabel setHidden:YES];
                    
                    [cell.threeVersusYesNoMainView setHidden:NO];
                    [cell.threeVersusYesNoButtonView setHidden:NO];
                    [cell.threeVersusYesNoNotDoneButton setHidden:YES];
                    
                    [cell.threeVersusZeroComment setHidden:YES];
                    cell.threeVersusRightButton.userInteractionEnabled = NO;
                    
                    
                    [cell.threeVersusFirstSecondYesNoMainView setHidden:NO];
                    [cell.threeVersusFirstSecondYesNoView setHidden:NO];
                    [cell.threeVersusFirstSecondNotDoneView setHidden:YES];
                    cell.threeVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                    cell.threeVersusFirstSecondRightButton.userInteractionEnabled = NO;
                    
                    
                    [cell.reheyVoteButton setHidden:NO];
                    
                }
                
                
                
                //Button Caption (YES/NO)
                [cell.threeVersusFirstSecondLeftButton setTitle:[[globalArray valueForKey:@"Caption1"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                [cell.threeVersusFirstSecondRightButton setTitle:[[globalArray valueForKey:@"Caption2"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                [cell.threeVersusRightButton setTitle:[[globalArray valueForKey:@"Caption3"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                [cell.threeVersusFinalLeftButton setTitle:[[globalArray valueForKey:@"Caption1"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                [cell.threeVersusFinalRightButton setTitle:[[globalArray valueForKey:@"Caption2"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                
                [cell.threeVersusRightResultButton setTitle:[[globalArray valueForKey:@"Caption3"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                
                //   return cell;
                
                
                
                
            }
            else if ([[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section]integerValue] == 4){
                
                
                
                NSString * locationName = [[globalArray valueForKey:@"LocationName"] objectAtIndex:indexPath.section];
                if ([locationName length] > 0) {
                    [cell.checkInView setHidden:NO];
                    [cell.checkinButton setTitle:locationName forState: UIControlStateNormal];
                }
                
                [cell.proImageView setHidden:NO];
                //   [cell.buttonOverImage setHidden:NO];
                [cell.voiceView setHidden:YES];
                
                
                
                //Post Image
                
                NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[globalArray valueForKey:@"Image1Idf"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"PostFolderPath"] objectAtIndex:indexPath.section]];
                
                
                [cell.proImageView  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
                //Post Vote percentage
                
                
                
                
                NSString*percent = @"%";
                
                NSString*vote1 = [NSString stringWithFormat:@"%@ Votes (%@%@)",[[globalArray valueForKey:@"VoteCount1"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section],percent];
                
                
                NSString*vote2 = [NSString stringWithFormat:@"%@ Votes (%@%@)",[[globalArray valueForKey:@"VoteCount2"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section],percent];
                
                
                NSString*vote3 = [NSString stringWithFormat:@"%@ Votes (%@%@)",[[globalArray valueForKey:@"VoteCount3"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section],percent];
                
                NSString*vote4 = [NSString stringWithFormat:@"%@ Votes (%@%@)",[[globalArray valueForKey:@"VoteCount4"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section],percent];
                
                
                
                if ([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] && [[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] && [[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue]) {
                    
                    
                    
                    
                    
                    
                    
                    if (screenWidthios == 320) {
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                        
                    }
                    
                    else if (screenWidthios == 375){
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                        
                    }
                    
                    else{
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    
                    // cell.fourVersusFirstSecondLeftVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFirstSecondFinalLeftButton.backgroundColor = [UIColor colorWithRed:95/255.0f green:124/255.0f blue:138/255.0f alpha:1.0f];
                    
                    
                    
                    // cell.fourVersusFirstSecondRightVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFirstSecondFinalRightButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    //  cell.fourVersusFinalLeftVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFinalLeftButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    //  cell.fourVersusFinalRightVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFinalRightButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    //
                    //                    [cell.fourVersusFirstSecondLeftWinnerImage setHidden:NO];
                    //                    [cell.fourVersusFirstSecondRightWinnerImage setHidden:YES];
                    //                    [cell.fourVersusLeftWinnerImage setHidden:YES];
                    //                    [cell.fourVersusRightWinnerImage setHidden:YES];
                    
                }
                
                else if ([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] && [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] && [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue]){
                    
                    
                    
                    
                    if (screenWidthios == 320) {
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                        
                    }
                    
                    else if (screenWidthios == 375){
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                        
                    }
                    
                    else{
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                    }
                    
                    
                    // cell.fourVersusFirstSecondLeftVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFirstSecondFinalLeftButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    // cell.fourVersusFirstSecondRightVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFirstSecondFinalRightButton.backgroundColor = [UIColor colorWithRed:95/255.0f green:124/255.0f blue:138/255.0f alpha:1.0f];
                    
                    
                    
                    // cell.fourVersusFinalLeftVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFinalLeftButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    // cell.fourVersusFinalRightVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFinalRightButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    //                    [cell.fourVersusFirstSecondLeftWinnerImage setHidden:YES];
                    //                    [cell.fourVersusFirstSecondRightWinnerImage setHidden:NO];
                    //                    [cell.fourVersusLeftWinnerImage setHidden:YES];
                    //                    [cell.fourVersusRightWinnerImage setHidden:YES];
                    
                }
                
                else if ([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] && [[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] && [[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue]){
                    
                    
                    
                    if (screenWidthios == 320) {
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                        
                    }
                    
                    else if (screenWidthios == 375){
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                        
                    }
                    
                    else{
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                    }
                    
                    
                    //  cell.fourVersusFirstSecondLeftVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFirstSecondFinalLeftButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    //  cell.fourVersusFirstSecondRightVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFirstSecondFinalRightButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    //  cell.fourVersusFinalLeftVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFinalLeftButton.backgroundColor = [UIColor colorWithRed:95/255.0f green:124/255.0f blue:138/255.0f alpha:1.0f];
                    
                    
                    //  cell.fourVersusFinalRightVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFinalRightButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    //
                    //                    [cell.fourVersusFirstSecondLeftWinnerImage setHidden:YES];
                    //                    [cell.fourVersusFirstSecondRightWinnerImage setHidden:YES];
                    //                    [cell.fourVersusLeftWinnerImage setHidden:NO];
                    //                    [cell.fourVersusRightWinnerImage setHidden:YES];
                    
                }
                
                
                else if ([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] && [[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] && [[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue]){
                    
                    
                    
                    if (screenWidthios == 320) {
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                        
                    }
                    
                    else if (screenWidthios == 375){
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                        
                    }
                    
                    else{
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                    }
                    
                    
                    //  cell.fourVersusFirstSecondLeftVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFirstSecondFinalLeftButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    // cell.fourVersusFirstSecondRightVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFirstSecondFinalRightButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    // cell.fourVersusFinalLeftVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFinalLeftButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    // cell.fourVersusFinalRightVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFinalRightButton.backgroundColor = [UIColor colorWithRed:95/255.0f green:124/255.0f blue:138/255.0f alpha:1.0f];
                    
                    
                    //                    [cell.fourVersusFirstSecondLeftWinnerImage setHidden:YES];
                    //                    [cell.fourVersusFirstSecondRightWinnerImage setHidden:YES];
                    //                    [cell.fourVersusLeftWinnerImage setHidden:YES];
                    //                    [cell.fourVersusRightWinnerImage setHidden:NO];
                    
                }
                
                else{
                    
                    
                    
                    if (screenWidthios == 320) {
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                        
                    }
                    
                    else if (screenWidthios == 375){
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                        
                    }
                    
                    else{
                        
                        
                        CGRect buttonFrame = cell.fourVersusFirstSecondFinalLeftButton.frame;
                        buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFirstSecondFinalLeftButton.frame = buttonFrame;
                        
                        
                        
                        
                        CGRect buttonFrame2 = cell.fourVersusFirstSecondFinalRightButton.frame;
                        buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFirstSecondFinalRightButton.frame = buttonFrame2;
                        
                        
                        CGRect buttonFrame3 = cell.fourVersusFinalLeftButton.frame;
                        buttonFrame3.size = CGSizeMake([[[globalArray valueForKey:@"Vote3Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFinalLeftButton.frame = buttonFrame3;
                        
                        CGRect buttonFrame4 = cell.fourVersusFinalRightButton.frame;
                        buttonFrame4.size = CGSizeMake([[[globalArray valueForKey:@"Vote4Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                        cell.fourVersusFinalRightButton.frame = buttonFrame4;
                        
                        
                    }
                    
                    
                    
                    // cell.fourVersusFirstSecondLeftVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFirstSecondFinalLeftButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    //  cell.fourVersusFirstSecondRightVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFirstSecondFinalRightButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    
                    //  cell.fourVersusFinalLeftVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFinalLeftButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    //  cell.fourVersusFinalRightVote.textColor = [UIColor whiteColor];
                    cell.fourVersusFinalRightButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                    
                    
                    //                    [cell.fourVersusFirstSecondLeftWinnerImage setHidden:YES];
                    //                    [cell.fourVersusFirstSecondRightWinnerImage setHidden:YES];
                    //                    [cell.fourVersusLeftWinnerImage setHidden:YES];
                    //                    [cell.fourVersusRightWinnerImage setHidden:YES];
                    
                    
                }
                
                
                
                
                
                
                cell.fourVersusFirstSecondLeftVote.text = vote1;
                cell.fourVersusFirstSecondRightVote.text = vote2;
                cell.fourVersusFinalLeftVote.text = vote3;
                cell.fourVersusFinalRightVote.text = vote4;
                
                //Total HeyVote Counts
                
                
                NSString* totalVotes = [NSString stringWithFormat:@"%@ HeyVotes",[[globalArray valueForKey:@"VoteCount"] objectAtIndex:indexPath.section]];
                
                cell.totalVotesLabel.text = totalVotes;
                
                
                //Comments Count
                
                if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count]  >1) {
                    
                    NSString * totalComments = [NSString stringWithFormat:@"%ld comments",(long)[[[globalArray valueForKey:@"CommentCount"] objectAtIndex:indexPath.section] integerValue]];
                    
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:totalComments];
                    [attString addAttribute:NSUnderlineStyleAttributeName
                                      value:[NSNumber numberWithInt:1]
                                      range:(NSRange){0,[attString length]}];
                    cell.totalComments.text =totalComments;
                }
                
                else{
                    
                    NSString * totalComments = [NSString stringWithFormat:@"%ld comments",(long)[[[globalArray valueForKey:@"CommentCount"] objectAtIndex:indexPath.section] integerValue]];
                    
                    
                    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:totalComments];
                    [attString addAttribute:NSUnderlineStyleAttributeName
                                      value:[NSNumber numberWithInt:1]
                                      range:(NSRange){0,[attString length]}];
                    cell.totalComments.text =totalComments;
                    
                }
                
                
                //Post Title
                
                [cell.titleLabelView setHidden:YES];
                
                
                
                //Comment Attribute Label
                
                if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 1) {
                    
                    
                    
                    
                    NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        NSString* localTime = [tr formattedAsTimeAgo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                        
                        
                        //                [cell.commentAttributedLabel setHidden:NO];
                        //                [cell.showMoreComments setHidden:YES];
                        
                        //
                        //      NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                        
                        cell.commentAttributedLabelFirst.text= [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                        
                        
                        NSString * commetAttrTextTwo = localTime;
                        
                        NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                        
                        NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                        
                        
                        
                        CGFloat boldTextFontSize = 12.0f;
                        
                        CGFloat boldTextFontSizeee = 10.0f;
                        
                        //  cell.commentAttributedLabel.text = combinedText;
                        
                        NSRange range1 = [combinedText rangeOfString:commentAttrText];
                        NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                        
                        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                        
                        
                        NSDictionary *attrDict = @{
                                                   NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                                   NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                   };
                        
                        
                        //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                        [attributedText setAttributes:attrDict  range:range2];
                        
                        
                        [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                                range:range1];
                        
                        
                        cell.commentAttributedLabel.attributedText = attributedText;
                        
                        
                        
                        
                    }
                    
                    
                }
                
                
                else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 2) {
                    
                    
                    
                    
                    NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    NSString* localTime;
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTime = [tr formattedAsTimeAgo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwo = localTime;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                    
                    NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                    
                    
                    
                    CGFloat boldTextFontSize = 12.0f;
                    
                    CGFloat boldTextFontSizeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range1 = [combinedText rangeOfString:commentAttrText];
                    NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                    
                    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                    
                    
                    NSDictionary *attrDict = @{
                                               NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                               NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                               };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedText setAttributes:attrDict  range:range2];
                    
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                            range:range1];
                    
                    
                    cell.commentAttributedLabel.attributedText = attributedText;
                    
                    
                    
                    
                    
                    NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                    
                    
                    NSString *yStringg = [splitStringg objectAtIndex:1];
                    
                    NSString* localTimee;
                    
                    if ([yStringg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimee = [tr formattedAsTimeAgoTwo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwoo = localTimee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellSecond.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                    
                    NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                    
                    NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                    
                    
                    
                    CGFloat boldTextFontSizee = 12.0f;
                    
                    CGFloat boldTextFontSizeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                    NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                    
                    NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                    
                    
                    NSDictionary *attrDictt = @{
                                                NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                                NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTextt setAttributes:attrDictt  range:range22];
                    
                    [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                             range:range11];
                    
                    
                    cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                    
                    
                    
                    
                }
                
                
                else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 3) {
                    
                    
                    
                    
                    
                    
                    NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    NSString* localTime;
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTime = [tr formattedAsTimeAgo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwo = localTime;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedLabelFirst.text =  cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                    
                    NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                    
                    
                    
                    CGFloat boldTextFontSize = 12.0f;
                    
                    CGFloat boldTextFontSizeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range1 = [combinedText rangeOfString:commentAttrText];
                    NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                    
                    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                    
                    
                    NSDictionary *attrDict = @{
                                               NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                               NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                               };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedText setAttributes:attrDict  range:range2];
                    
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                            range:range1];
                    
                    
                    cell.commentAttributedLabel.attributedText = attributedText;
                    
                    
                    
                    
                    
                    NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                    
                    
                    NSString *yStringg = [splitStringg objectAtIndex:1];
                    
                    NSString* localTimee;
                    
                    if ([yStringg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimee = [tr formattedAsTimeAgoTwo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwoo = localTimee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellSecond.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                    
                    NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                    
                    NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                    
                    
                    
                    CGFloat boldTextFontSizee = 12.0f;
                    
                    CGFloat boldTextFontSizeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                    NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                    
                    NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                    
                    
                    NSDictionary *attrDictt = @{
                                                NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                                NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTextt setAttributes:attrDictt  range:range22];
                    
                    [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                             range:range11];
                    
                    
                    cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                    
                    
                    
                    
                    
                    
                    
                    
                    NSString *stringTimerrr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:2];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimitersss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringgg = [stringTimerrr componentsSeparatedByCharactersInSet:delimitersss];
                    
                    
                    NSString *yStringgg = [splitStringgg objectAtIndex:1];
                    
                    NSString* localTimeee;
                    
                    if ([yStringgg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringgg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimeee = [tr formattedAsTimeAgoThree];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimeee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwooo = localTimeee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellThird.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:2];
                    
                    
                    NSString * commentAttrTexttt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:2];
                    
                    NSString * combinedTexttt = [NSString stringWithFormat:@"%@  %@",commentAttrTexttt,commetAttrTextTwooo];
                    
                    
                    
                    CGFloat boldTextFontSizeeeee = 12.0f;
                    
                    CGFloat boldTextFontSizeeeeeeeeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range111 = [combinedTexttt rangeOfString:commentAttrTexttt];
                    NSRange range222 = [combinedTexttt rangeOfString:commetAttrTextTwooo];
                    
                    NSMutableAttributedString *attributedTexttt = [[NSMutableAttributedString alloc] initWithString:combinedTexttt];
                    
                    
                    NSDictionary *attrDicttt = @{
                                                 NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeeeeeeeeee],
                                                 NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                 };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTexttt setAttributes:attrDicttt  range:range222];
                    
                    [attributedTexttt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizeeeee]}
                                              range:range111];
                    
                    
                    cell.commentAttributedLabelThree.attributedText = attributedTexttt;
                    
                    
                    
                    
                }
                
                
                
                else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] > 3) {
                    
                    
                    
                    
                    
                    
                    NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    NSString* localTime;
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTime = [tr formattedAsTimeAgo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwo = localTime;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                    
                    NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                    
                    
                    
                    CGFloat boldTextFontSize = 12.0f;
                    
                    CGFloat boldTextFontSizeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range1 = [combinedText rangeOfString:commentAttrText];
                    NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                    
                    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                    
                    
                    NSDictionary *attrDict = @{
                                               NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                               NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                               };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedText setAttributes:attrDict  range:range2];
                    
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                            range:range1];
                    
                    
                    cell.commentAttributedLabel.attributedText = attributedText;
                    
                    
                    
                    
                    
                    NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                    
                    
                    NSString *yStringg = [splitStringg objectAtIndex:1];
                    
                    NSString* localTimee;
                    
                    if ([yStringg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimee = [tr formattedAsTimeAgoTwo];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwoo = localTimee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellSecond.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                    
                    NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                    
                    NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                    
                    
                    
                    CGFloat boldTextFontSizee = 12.0f;
                    
                    CGFloat boldTextFontSizeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                    NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                    
                    NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                    
                    
                    NSDictionary *attrDictt = @{
                                                NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                                NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTextt setAttributes:attrDictt  range:range22];
                    
                    [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                             range:range11];
                    
                    
                    cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                    
                    
                    
                    
                    
                    
                    
                    
                    NSString *stringTimerrr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:2];
                    
                    
                    
                    
                    
                    
                    NSCharacterSet *delimitersss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitStringgg = [stringTimerrr componentsSeparatedByCharactersInSet:delimitersss];
                    
                    
                    NSString *yStringgg = [splitStringgg objectAtIndex:1];
                    
                    NSString* localTimeee;
                    
                    if ([yStringgg containsString:@"-"]) {
                        
                        NSArray *arrrr = [yStringgg componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        localTimeee = [tr formattedAsTimeAgoThree];
                        //   NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimeee);
                        
                    }
                    
                    
                    NSString * commetAttrTextTwooo = localTimeee;
                    
                    //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    cell.commentAttributedCellThird.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:2];
                    
                    
                    NSString * commentAttrTexttt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:2];
                    
                    NSString * combinedTexttt = [NSString stringWithFormat:@"%@  %@",commentAttrTexttt,commetAttrTextTwooo];
                    
                    
                    
                    CGFloat boldTextFontSizeeeee = 12.0f;
                    
                    CGFloat boldTextFontSizeeeeeeeeeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range111 = [combinedTexttt rangeOfString:commentAttrTexttt];
                    NSRange range222 = [combinedTexttt rangeOfString:commetAttrTextTwooo];
                    
                    NSMutableAttributedString *attributedTexttt = [[NSMutableAttributedString alloc] initWithString:combinedTexttt];
                    
                    
                    NSDictionary *attrDicttt = @{
                                                 NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeeeeeeeeee],
                                                 NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                                 };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedTexttt setAttributes:attrDicttt  range:range222];
                    
                    [attributedTexttt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizeeeee]}
                                              range:range111];
                    
                    
                    cell.commentAttributedLabelThree.attributedText = attributedTexttt;
                    
                    
                    
                    
                    
                    [cell.showMoreComments setHidden:NO];
                    [cell.totalComments setHidden:YES];
                    
                }
                
                // Post is Live Or Done
                
                if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0 ) {
                    
                    
                    
                    // [cell.timerCell setHidden:NO];
                    // [cell.remainingLabel setHidden:NO];
                    
                    
                    NSString *stringTimer =[[globalArray valueForKey:@"EndDate"] objectAtIndex:indexPath.section];
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    NSString *xString = [splitString objectAtIndex:0];
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        
                        NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTime:%@", localTime);
                        
                        NSDateFormatter *dateFormatterCurrent=[[NSDateFormatter alloc] init];
                        [dateFormatterCurrent setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                        
                        
                        
                        NSString* localCurrentTime = [dateFormatterCurrent stringFromDate:[NSDate date]];
                        //   NSLog(@"current time :%@",localCurrentTime);
                        
                        NSTimeInterval diff = [tr timeIntervalSinceDate:[NSDate date]];
                        
                        //  NSLog(@"difffereeenceee %f",diff*1000 );
                        
                        valText = diff*1000;
                        
                        
                        float seconds = valText / 1000.0;
                        float minutes = seconds / 60.0;
                        
                        
                        testVa = minutes/1440;
                        
                        
                        
                        //                    float percentVal = testVa * 100;
                        //
                        //                    float percentFinalVal = percentVal/100
                        //
                        
                        if ([[self calculateTimer] isEqualToString:@""]) {
                            [cell.timerCell setHidden:YES];
                            [cell.progresssView setHidden:YES];
                        }
                        
                        else{
                            
                            cell.timerCell.text =  [self calculateTimer];
                            
                            
                            
                        }
                        
                        //
                        //                    if (valText >0 && valText <86400000 ) {
                        ////                        _timerCalc = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runScheduledTask:) userInfo:nil repeats:NO];
                        //
                        //
                        //                        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(valText / 1000.0)];
                        //
                        //                        NSString* localTimeee =[NSString stringWithFormat:@"%@",date];
                        //
                        //                        NSArray *seperateVal =  [localTimeee componentsSeparatedByString:@" "];
                        //
                        //                        NSArray *timeSplit = [[seperateVal objectAtIndex:1] componentsSeparatedByString:@":"];
                        //
                        //
                        //                      NSString*  exactTimeee = [NSString stringWithFormat:@"%@h. %@m. %@s.",[timeSplit objectAtIndex:0],[timeSplit objectAtIndex:1],[timeSplit objectAtIndex:2]];
                        //
                        //                        cell.timerCell.text  = exactTimeee;
                        //
                        //                        NSLog(@"timerrrr : %@",cell.timerCell.text);
                        //
                        //
                        //
                        //                    }
                        //
                        //
                        //
                        
                    }
                    
                    
                    
                    /*******/
                    [cell.fourVersusFirstSecondMainView setHidden:NO];
                    [cell.fourVersusMainView setHidden:NO];
                    [cell.fourVersusFirstSecondButtonView setHidden:YES];
                    [cell.fourVersusButtonView setHidden:YES];
                    [cell.fourVersusZeroComment setHidden:NO];
                    
                    
                    [cell.fourVersusFirstSecondNotDoneView setHidden:NO];
                    [cell.fourVersusNotDoneView setHidden:NO];
                    
                    
                    cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = YES;
                    cell.fourVersusFirstSecondRightButton.userInteractionEnabled = YES;
                    
                    [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                    
                    
                    cell.fourVersusFirstSecondFinalLeftButton.userInteractionEnabled = YES;
                    cell.fourVersusFirstSecondFinalRightButton.userInteractionEnabled = YES;
                    
                    //                    [cell.fourVersusFirstSecondFinalLeftButton setBackgroundColor:[UIColor whiteColor]];
                    //                    [cell.fourVersusFirstSecondFinalRightButton setBackgroundColor:[UIColor whiteColor]];
                    
                    
                    cell.fourVersusLeftButton.userInteractionEnabled = YES;
                    cell.fourVersusRightButton.userInteractionEnabled = YES;
                    
                    [cell.fourVersusLeftButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.fourVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                    
                    cell.fourVersusFinalLeftButton.userInteractionEnabled = YES;
                    cell.fourVersusFinalRightButton.userInteractionEnabled = YES;
                    
                    //                    [cell.fourVersusFinalLeftButton setBackgroundColor:[UIColor whiteColor]];
                    //                    [cell.fourVersusFinalRightButton setBackgroundColor:[UIColor whiteColor]];
                    
                    
                    [cell.reheyVoteButton setHidden:YES];
                    
                    
                    //Has Voted Or not Button View
                    
                    
                    if ([[[globalArray valueForKey:@"hasVoted"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                        
                        if ([voteResultAraayFourVersus containsObject:[globalArray objectAtIndex:indexPath.section]]) {
                            
                            
                            
                            if ([voteResultValFourVersus isEqualToString:@"leftvoted"] || [voteResultValFourVersus isEqualToString:@"rightvoted"] || [voteResultValFourVersus isEqualToString:@"downleftvoted"] || [voteResultValFourVersus isEqualToString:@"downrightvoted"]) {
                                
                                
                                
                                
                                [cell.progresssView setHidden:NO];
                                [cell.timerCell setHidden:NO];
                                [cell.remainingLabel setHidden:NO];
                                
                                cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                          green:0.0f/255.0f
                                                                                           blue:20.0f/255.0f
                                                                                          alpha:0.7f];
                                cell.circularProgress.max = 1.0f;
                                cell.circularProgress.fillRadiusPx = 25;
                                cell.circularProgress.step = 0.1f;
                                cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                                cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                                cell.circularProgress.outlineWidth = 1;
                                cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                                cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                                
                                
                                [[HKCircularProgressView appearance] setAnimationDuration:5];
                                
                                cell.circularProgress.alwaysDrawOutline = YES;
                                
                                
                                cell.insideProgress.fillRadius = 1;
                                cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                                cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                                [cell.circularProgress setCurrent:testVa
                                                         animated:YES];
                                [cell.insideProgress setCurrent:1.0f
                                                       animated:YES];
                                
                                
                                
                                NSString*uVoted;
                                
                                // [cell.yesNoMainView setHidden:YES];
                                
                                if ([voteResultValThreeVersus isEqualToString:@"leftvoted"]) {
                                    
                                    cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                                    cell.fourVersusFirstSecondRightButton.userInteractionEnabled = NO;
                                    cell.fourVersusLeftButton.userInteractionEnabled = NO;
                                    cell.fourVersusRightButton.userInteractionEnabled = NO;
                                    
                                    [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                                             green:200.0f/255.0f
                                                                                                              blue:200.0f/255.0f
                                                                                                             alpha:1.0f]];
                                    [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.fourVersusLeftButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.fourVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                                    
                                    
                                    
                                }
                                
                                else if([voteResultValThreeVersus isEqualToString:@"rightvoted"] ) {
                                    
                                    cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                                    cell.fourVersusFirstSecondRightButton.userInteractionEnabled = NO;
                                    cell.fourVersusLeftButton.userInteractionEnabled = NO;
                                    cell.fourVersusRightButton.userInteractionEnabled = NO;
                                    
                                    [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                                              green:200.0f/255.0f
                                                                                                               blue:200.0f/255.0f
                                                                                                              alpha:1.0f]];
                                    [cell.fourVersusLeftButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.fourVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                                    
                                    
                                    
                                }
                                
                                
                                
                                else if([voteResultValThreeVersus isEqualToString:@"downleftvoted"] ) {
                                    
                                    cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                                    cell.fourVersusFirstSecondRightButton.userInteractionEnabled = NO;
                                    cell.fourVersusLeftButton.userInteractionEnabled = NO;
                                    cell.fourVersusRightButton.userInteractionEnabled = NO;
                                    
                                    [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.fourVersusLeftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                                  green:200.0f/255.0f
                                                                                                   blue:200.0f/255.0f
                                                                                                  alpha:1.0f]];
                                    [cell.fourVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                                    
                                    
                                    
                                }
                                
                                else if([voteResultValThreeVersus isEqualToString:@"downrightvoted"] ) {
                                    
                                    cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                                    cell.fourVersusFirstSecondRightButton.userInteractionEnabled = NO;
                                    cell.fourVersusLeftButton.userInteractionEnabled = NO;
                                    cell.fourVersusRightButton.userInteractionEnabled = NO;
                                    
                                    [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.fourVersusLeftButton setBackgroundColor:[UIColor whiteColor]];
                                    [cell.fourVersusRightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                                   green:200.0f/255.0f
                                                                                                    blue:200.0f/255.0f
                                                                                                   alpha:1.0f]];
                                    
                                    
                                    
                                }
                                
                                
                                
                                cell.youHaveVotedLabel.text =uVoted;
                            }
                            
                            
                            
                            else{
                                
                                
                                
                                [cell.fourVersusMainView setHidden:NO];
                                [cell.fourVersusButtonView setHidden:YES];
                                [cell.fourVersusNotDoneView setHidden:NO];
                                [cell.fourVersusZeroComment setHidden:NO];
                                
                                [cell.fourVersusFirstSecondMainView setHidden:NO];
                                [cell.fourVersusFirstSecondButtonView setHidden:YES];
                                [cell.fourVersusFirstSecondNotDoneView setHidden:NO];
                                
                            }
                            
                        }
                        
                    }
                    
                    else if ([[[globalArray valueForKey:@"hasVoted"] objectAtIndex:indexPath.section] integerValue]  == 1 ) {
                        // [cell.yesNoMainView setHidden:YES];
                        
                        [cell.progresssView setHidden:NO];
                        [cell.timerCell setHidden:NO];
                        [cell.remainingLabel setHidden:NO];
                        
                        cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                  green:0.0f/255.0f
                                                                                   blue:20.0f/255.0f
                                                                                  alpha:0.7f];
                        cell.circularProgress.max = 1.0f;
                        cell.circularProgress.fillRadiusPx = 25;
                        cell.circularProgress.step = 0.1f;
                        cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                        cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        cell.circularProgress.outlineWidth = 1;
                        cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                        cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                        
                        
                        [[HKCircularProgressView appearance] setAnimationDuration:5];
                        
                        cell.circularProgress.alwaysDrawOutline = YES;
                        
                        
                        cell.insideProgress.fillRadius = 1;
                        cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                        cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        [cell.circularProgress setCurrent:testVa
                                                 animated:YES];
                        [cell.insideProgress setCurrent:1.0f
                                               animated:YES];
                        
                        
                        
                        
                        NSString*uVoted;
                        
                        
                        
                        if ([[[globalArray valueForKey:@"VotedFor"] objectAtIndex:indexPath.section] integerValue] == 0) {
                            
                            cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                            cell.fourVersusFirstSecondRightButton.userInteractionEnabled = NO;
                            cell.fourVersusLeftButton.userInteractionEnabled = NO;
                            cell.fourVersusRightButton.userInteractionEnabled = NO;
                            
                            [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                                     green:200.0f/255.0f
                                                                                                      blue:200.0f/255.0f
                                                                                                     alpha:1.0f]];
                            [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.fourVersusLeftButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.fourVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                            
                            
                            
                            
                            
                            
                        }
                        
                        else if([[[globalArray valueForKey:@"VotedFor"] objectAtIndex:indexPath.section] integerValue] == 1) {
                            
                            cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                            cell.fourVersusFirstSecondRightButton.userInteractionEnabled = NO;
                            cell.fourVersusLeftButton.userInteractionEnabled = NO;
                            cell.fourVersusRightButton.userInteractionEnabled = NO;
                            
                            [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                                      green:200.0f/255.0f
                                                                                                       blue:200.0f/255.0f
                                                                                                      alpha:1.0f]];
                            [cell.fourVersusLeftButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.fourVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                            
                            
                        }
                        
                        
                        
                        else if([[[globalArray valueForKey:@"VotedFor"] objectAtIndex:indexPath.section] integerValue] == 2) {
                            
                            
                            
                            cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                            cell.fourVersusFirstSecondRightButton.userInteractionEnabled = NO;
                            cell.fourVersusLeftButton.userInteractionEnabled = NO;
                            cell.fourVersusRightButton.userInteractionEnabled = NO;
                            
                            [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.fourVersusLeftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                          green:200.0f/255.0f
                                                                                           blue:200.0f/255.0f
                                                                                          alpha:1.0f]];
                            [cell.fourVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                        
                        else if([[[globalArray valueForKey:@"VotedFor"] objectAtIndex:indexPath.section] integerValue] == 3) {
                            
                            
                            
                            cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                            cell.fourVersusFirstSecondRightButton.userInteractionEnabled = NO;
                            cell.fourVersusLeftButton.userInteractionEnabled = NO;
                            cell.fourVersusRightButton.userInteractionEnabled = NO;
                            
                            [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.fourVersusLeftButton setBackgroundColor:[UIColor whiteColor]];
                            [cell.fourVersusRightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                           green:200.0f/255.0f
                                                                                            blue:200.0f/255.0f
                                                                                           alpha:1.0f]];
                            
                            
                            
                            
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                
                
                else if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 1) {
                    [cell.timerCell setHidden:YES];
                    [cell.remainingLabel setHidden:YES];
                    
                    [cell.fourVersusMainView setHidden:NO];
                    [cell.fourVersusButtonView setHidden:NO];
                    
                    [cell.fourVersusZeroComment setHidden:YES];
                    [cell.fourVersusNotDoneView setHidden:YES];
                    cell.fourVersusLeftButton.userInteractionEnabled = NO;
                    cell.fourVersusRightButton.userInteractionEnabled = NO;
                    
                    
                    [cell.fourVersusFirstSecondMainView setHidden:NO];
                    [cell.fourVersusFirstSecondButtonView setHidden:NO];
                    [cell.fourVersusFirstSecondNotDoneView setHidden:YES];
                    cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                    cell.fourVersusFirstSecondRightButton.userInteractionEnabled = NO;
                    
                    
                    [cell.reheyVoteButton setHidden:NO];
                    
                }
                
                
                
                //Button Caption (YES/NO)
                [cell.fourVersusFirstSecondLeftButton setTitle:[[globalArray valueForKey:@"Caption1"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                [cell.fourVersusFirstSecondRightButton setTitle:[[globalArray valueForKey:@"Caption2"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                [cell.fourVersusLeftButton setTitle:[[globalArray valueForKey:@"Caption3"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                [cell.fourVersusRightButton setTitle:[[globalArray valueForKey:@"Caption4"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                
                [cell.fourVersusFirstSecondFinalLeftButton setTitle:[[globalArray valueForKey:@"Caption1"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                [cell.fourVersusFirstSecondFinalRightButton setTitle:[[globalArray valueForKey:@"Caption2"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                
                [cell.fourVersusFinalLeftButton setTitle:[[globalArray valueForKey:@"Caption3"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                [cell.fourVersusFinalRightButton setTitle:[[globalArray valueForKey:@"Caption4"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
                
                
                //   return cell;
                
                
                
                
            }
            
        }
        
        
        //CEll for Audio Post
        
        
        else  if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 3) {
            //             videoplayer.muted = YES;
            //            [videoplayer pause];
            
            
            // [self.mc pause];
            NSString * locationName = [[globalArray valueForKey:@"LocationName"] objectAtIndex:indexPath.section];
            if ([locationName length] > 0) {
                [cell.checkInView setHidden:NO];
                [cell.checkinButton setTitle:locationName forState: UIControlStateNormal];
            }
            
            
            
            [cell.progresssView setHidden:YES];
            [cell.timerCell setHidden:YES];
            [cell.remainingLabel setHidden:YES];
            
            //Post Image
            
            
            
            [cell.proImageView setHidden:YES];
            [cell.buttonOverImage setHidden:NO];
            [cell.voiceView setHidden:NO];
            
            if ([[globalArray valueForKey:@"Image2Idf"] objectAtIndex:indexPath.section] == [NSNull null]) {
                [cell.doubleVoiceView setHidden:YES];
                
                cell.audioplayer = nil ;
                cell.itemAudio = nil;
                [cell stopAudio];
                
                
                NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/api/media/playaudio/%@/%@",[[globalArray valueForKey:@"Image1Idf"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"PostFolderPath"] objectAtIndex:indexPath.section]];
                
                //
                NSURL *url = [NSURL URLWithString:imageString];
                
                [cell createPlayerWithURLForAudio:url];
                
                
                
                
            }
            
            else{
                
                [cell.doubleVoiceView setHidden:NO];
            }
            
            
            //Post Vote percentage
            
            NSString*percent = @"%";
            
            NSString*vote1 = [NSString stringWithFormat:@"%@ Votes (%@%@)",[[globalArray valueForKey:@"VoteCount1"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section],percent];
            
            
            NSString*vote2 = [NSString stringWithFormat:@"%@ Votes (%@%@)",[[globalArray valueForKey:@"VoteCount2"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section],percent];
            
            
            CGRect buttonFrameNew = CGRectMake(3, 2, resultButtonWidth, resultButtonHeight);
            buttonFrameNew.size = CGSizeMake(resultButtonWidth, resultButtonHeight);
            cell.leftResultButton.frame = buttonFrameNew;
            
            
            CGRect buttonFrameNew2 = CGRectMake(3, 20, resultButtonWidth, resultButtonHeight);
            buttonFrameNew2.size = CGSizeMake(resultButtonWidth, resultButtonHeight);
            cell.rightResultButton.frame = buttonFrameNew2;
            
            
            
            if ([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue]) {
                
                
                
                
                if (screenWidthios == 320) {
                    
                    
                    CGRect buttonFrame = cell.leftResultButton.frame;
                    buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                    cell.leftResultButton.frame = buttonFrame;
                    
                    
                    
                    
                    CGRect buttonFrame2 = cell.rightResultButton.frame;
                    buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                    cell.rightResultButton.frame = buttonFrame2;
                    
                    
                    
                }
                
                else if (screenWidthios == 375){
                    
                    
                    
                    CGRect buttonFrame = cell.leftResultButton.frame;
                    buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                    cell.leftResultButton.frame = buttonFrame;
                    
                    
                    
                    CGRect buttonFrame2 = cell.rightResultButton.frame;
                    buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                    cell.rightResultButton.frame = buttonFrame2;
                    
                    
                }
                
                else{
                    
                    
                    
                    CGRect buttonFrame = cell.leftResultButton.frame;
                    buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                    cell.leftResultButton.frame = buttonFrame;
                    
                    
                    
                    
                    CGRect buttonFrame2 = cell.rightResultButton.frame;
                    buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                    cell.rightResultButton.frame = buttonFrame2;
                    
                    
                }
                
                
                
                cell.leftResultButton.backgroundColor =  [UIColor colorWithRed:95/255.0f green:124/255.0f blue:138/255.0f alpha:1.0f];
                
                
                
                
                cell.rightResultButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                
                
                
                //                cell.voteLabelLeft.textColor = [UIColor whiteColor];
                //                cell.voteLabelLeft.backgroundColor = [UIColor colorWithRed:55/255.0f green:194/255.0f blue:4/255.0f alpha:1.0f];
                //
                //
                //
                //                cell.votesLabelRight.textColor = [UIColor whiteColor];
                //                cell.votesLabelRight.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                
                //                [cell.leftWinnerImage setHidden:NO];
                //                [cell.rightWinnerImage setHidden:YES];
                
            }
            
            else if([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] == [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue]){
                
                cell.leftResultButton.backgroundColor =  [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                
                cell.rightResultButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                
                //                cell.voteLabelLeft.textColor = [UIColor whiteColor];
                //
                //                cell.votesLabelRight.textColor = [UIColor whiteColor];
                //
                //
                //
                //                cell.voteLabelLeft.textColor = [UIColor whiteColor];
                //                cell.voteLabelLeft.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                //
                //
                //
                //                cell.votesLabelRight.textColor = [UIColor whiteColor];
                //                cell.votesLabelRight.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                
                //                [cell.leftWinnerImage setHidden:YES];
                //                [cell.rightWinnerImage setHidden:YES];
                
                
            }
            
            else{
                
                
                cell.leftResultButton.backgroundColor =  [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                
                cell.rightResultButton.backgroundColor = [UIColor colorWithRed:95/255.0f green:124/255.0f blue:138/255.0f alpha:1.0f];
                
                
                
                
                if (screenWidthios == 320) {
                    
                    
                    CGRect buttonFrame = cell.leftResultButton.frame;
                    buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                    cell.leftResultButton.frame = buttonFrame;
                    
                    
                    
                    
                    CGRect buttonFrame2 = cell.rightResultButton.frame;
                    buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                    cell.rightResultButton.frame = buttonFrame2;
                    
                    
                    
                }
                
                else if (screenWidthios == 375){
                    
                    
                    
                    CGRect buttonFrame = cell.leftResultButton.frame;
                    buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                    cell.leftResultButton.frame = buttonFrame;
                    
                    
                    
                    CGRect buttonFrame2 = cell.rightResultButton.frame;
                    buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                    cell.rightResultButton.frame = buttonFrame2;
                    
                    
                }
                
                else{
                    
                    
                    
                    CGRect buttonFrame = cell.leftResultButton.frame;
                    buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                    cell.leftResultButton.frame = buttonFrame;
                    
                    
                    
                    
                    CGRect buttonFrame2 = cell.rightResultButton.frame;
                    buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                    cell.rightResultButton.frame = buttonFrame2;
                    
                    
                }
                
                
                
                //
                //                cell.voteLabelLeft.textColor = [UIColor whiteColor];
                //                cell.voteLabelLeft.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                //
                //
                //
                //                cell.votesLabelRight.textColor = [UIColor whiteColor];
                //                cell.votesLabelRight.backgroundColor = [UIColor colorWithRed:55/255.0f green:194/255.0f blue:4/255.0f alpha:1.0f];
                
                //                [cell.leftWinnerImage setHidden:YES];
                //                [cell.rightWinnerImage setHidden:NO];
                
                
                //                [cell.leftTickImage setHidden:YES];
                //                [cell.rightTickImage setHidden:NO];
            }
            
            cell.voteLabelLeft.text = vote1;
            cell.votesLabelRight.text = vote2;
            
            
            //Total HeyVote Counts
            
            NSString* totalVotes = [NSString stringWithFormat:@"%@ HeyVotes",[[globalArray valueForKey:@"VoteCount"] objectAtIndex:indexPath.section]];
            
            cell.totalVotesLabel.text = totalVotes;
            
            
            
            //Comments Count
            
            if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count]  >1) {
                
                
                NSString * totalComments = [NSString stringWithFormat:@"%ld comments",(long)[[[globalArray valueForKey:@"CommentCount"] objectAtIndex:indexPath.section] integerValue]];
                
                
                NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:totalComments];
                
                [attString addAttribute:NSUnderlineStyleAttributeName
                                  value:[NSNumber numberWithInt:1]
                                  range:(NSRange){0,[attString length]}];
                cell.totalComments.text =totalComments;
            }
            
            else{
                
                NSString * totalComments = [NSString stringWithFormat:@"%ld comments",(long)[[[globalArray valueForKey:@"CommentCount"] objectAtIndex:indexPath.section] integerValue]];
                
                
                NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:totalComments];
                
                [attString addAttribute:NSUnderlineStyleAttributeName
                                  value:[NSNumber numberWithInt:1]
                                  range:(NSRange){0,[attString length]}];
                cell.totalComments.text =totalComments;
            }
            
            
            
            //Post Title
            
            [cell.titleLabelView setHidden:NO];
            
            cell.titleLabel.text = [[globalArray valueForKey:@"Title"] objectAtIndex:indexPath.section];
            
            
            //Comment Attribute Label
            
            if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 1) {
                
                
                
                
                NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                
                
                
                
                
                
                NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                
                
                NSString *yString = [splitString objectAtIndex:1];
                
                
                
                if ([yString containsString:@"-"]) {
                    
                    NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    NSString* localTime = [tr formattedAsTimeAgo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                    
                    
                    //                [cell.commentAttributedLabel setHidden:NO];
                    //                [cell.showMoreComments setHidden:YES];
                    
                    //
                    //      NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    cell.commentAttributedLabelFirst.text= [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    NSString * commetAttrTextTwo = localTime;
                    
                    NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                    
                    NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                    
                    
                    
                    CGFloat boldTextFontSize = 12.0f;
                    
                    CGFloat boldTextFontSizeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range1 = [combinedText rangeOfString:commentAttrText];
                    NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                    
                    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                    
                    
                    NSDictionary *attrDict = @{
                                               NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                               NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                               };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedText setAttributes:attrDict  range:range2];
                    
                    
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                            range:range1];
                    
                    
                    cell.commentAttributedLabel.attributedText = attributedText;
                    
                    
                    
                    
                }
                
                
            }
            
            
            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 2) {
                
                
                
                
                NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                
                
                
                
                
                
                NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                
                
                NSString *yString = [splitString objectAtIndex:1];
                
                NSString* localTime;
                
                if ([yString containsString:@"-"]) {
                    
                    NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTime = [tr formattedAsTimeAgo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                    
                }
                
                
                NSString * commetAttrTextTwo = localTime;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                
                NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                
                
                
                CGFloat boldTextFontSize = 12.0f;
                
                CGFloat boldTextFontSizeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range1 = [combinedText rangeOfString:commentAttrText];
                NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                
                NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                
                
                NSDictionary *attrDict = @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                           NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                           };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedText setAttributes:attrDict  range:range2];
                
                [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                        range:range1];
                
                
                cell.commentAttributedLabel.attributedText = attributedText;
                
                
                
                
                
                NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                
                
                
                
                
                
                NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                
                
                NSString *yStringg = [splitStringg objectAtIndex:1];
                
                NSString* localTimee;
                
                if ([yStringg containsString:@"-"]) {
                    
                    NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTimee = [tr formattedAsTimeAgoTwo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                    
                }
                
                
                NSString * commetAttrTextTwoo = localTimee;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedCellSecond.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                
                NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                
                NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                
                
                
                CGFloat boldTextFontSizee = 12.0f;
                
                CGFloat boldTextFontSizeeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                
                NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                
                
                NSDictionary *attrDictt = @{
                                            NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                            NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                            };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedTextt setAttributes:attrDictt  range:range22];
                
                [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                         range:range11];
                
                
                cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                
                
                
                
            }
            
            
            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 3) {
                
                
                
                
                
                
                NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                
                
                
                
                
                
                NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                
                
                NSString *yString = [splitString objectAtIndex:1];
                
                NSString* localTime;
                
                if ([yString containsString:@"-"]) {
                    
                    NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTime = [tr formattedAsTimeAgo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                    
                }
                
                
                NSString * commetAttrTextTwo = localTime;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedLabelFirst.text =  cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                
                NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                
                
                
                CGFloat boldTextFontSize = 12.0f;
                
                CGFloat boldTextFontSizeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range1 = [combinedText rangeOfString:commentAttrText];
                NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                
                NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                
                
                NSDictionary *attrDict = @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                           NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                           };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedText setAttributes:attrDict  range:range2];
                
                [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                        range:range1];
                
                
                cell.commentAttributedLabel.attributedText = attributedText;
                
                
                
                
                
                NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                
                
                
                
                
                
                NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                
                
                NSString *yStringg = [splitStringg objectAtIndex:1];
                
                NSString* localTimee;
                
                if ([yStringg containsString:@"-"]) {
                    
                    NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTimee = [tr formattedAsTimeAgoTwo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                    
                }
                
                
                NSString * commetAttrTextTwoo = localTimee;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedCellSecond.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                
                NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                
                NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                
                
                
                CGFloat boldTextFontSizee = 12.0f;
                
                CGFloat boldTextFontSizeeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                
                NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                
                
                NSDictionary *attrDictt = @{
                                            NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                            NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                            };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedTextt setAttributes:attrDictt  range:range22];
                
                [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                         range:range11];
                
                
                cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                
                
                
                
                
                
                
                
                NSString *stringTimerrr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:2];
                
                
                
                
                
                
                NSCharacterSet *delimitersss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitStringgg = [stringTimerrr componentsSeparatedByCharactersInSet:delimitersss];
                
                
                NSString *yStringgg = [splitStringgg objectAtIndex:1];
                
                NSString* localTimeee;
                
                if ([yStringgg containsString:@"-"]) {
                    
                    NSArray *arrrr = [yStringgg componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTimeee = [tr formattedAsTimeAgoThree];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimeee);
                    
                }
                
                
                NSString * commetAttrTextTwooo = localTimeee;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedCellThird.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:2];
                
                
                NSString * commentAttrTexttt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:2];
                
                NSString * combinedTexttt = [NSString stringWithFormat:@"%@  %@",commentAttrTexttt,commetAttrTextTwooo];
                
                
                
                CGFloat boldTextFontSizeeeee = 12.0f;
                
                CGFloat boldTextFontSizeeeeeeeeeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range111 = [combinedTexttt rangeOfString:commentAttrTexttt];
                NSRange range222 = [combinedTexttt rangeOfString:commetAttrTextTwooo];
                
                NSMutableAttributedString *attributedTexttt = [[NSMutableAttributedString alloc] initWithString:combinedTexttt];
                
                
                NSDictionary *attrDicttt = @{
                                             NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeeeeeeeeee],
                                             NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                             };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedTexttt setAttributes:attrDicttt  range:range222];
                
                [attributedTexttt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizeeeee]}
                                          range:range111];
                
                
                cell.commentAttributedLabelThree.attributedText = attributedTexttt;
                
                
                
                
            }
            
            
            
            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] > 3) {
                
                
                
                
                
                
                NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                
                
                
                
                
                
                NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                
                
                NSString *yString = [splitString objectAtIndex:1];
                
                NSString* localTime;
                
                if ([yString containsString:@"-"]) {
                    
                    NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTime = [tr formattedAsTimeAgo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                    
                }
                
                
                NSString * commetAttrTextTwo = localTime;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                
                NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                
                
                
                CGFloat boldTextFontSize = 12.0f;
                
                CGFloat boldTextFontSizeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range1 = [combinedText rangeOfString:commentAttrText];
                NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                
                NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                
                
                NSDictionary *attrDict = @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                           NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                           };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedText setAttributes:attrDict  range:range2];
                
                [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                        range:range1];
                
                
                cell.commentAttributedLabel.attributedText = attributedText;
                
                
                
                
                
                NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                
                
                
                
                
                
                NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                
                
                NSString *yStringg = [splitStringg objectAtIndex:1];
                
                NSString* localTimee;
                
                if ([yStringg containsString:@"-"]) {
                    
                    NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTimee = [tr formattedAsTimeAgoTwo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                    
                }
                
                
                NSString * commetAttrTextTwoo = localTimee;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedCellSecond.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                
                NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                
                NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                
                
                
                CGFloat boldTextFontSizee = 12.0f;
                
                CGFloat boldTextFontSizeeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                
                NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                
                
                NSDictionary *attrDictt = @{
                                            NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                            NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                            };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedTextt setAttributes:attrDictt  range:range22];
                
                [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                         range:range11];
                
                
                cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                
                
                
                
                
                
                
                
                NSString *stringTimerrr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:2];
                
                
                
                
                
                
                NSCharacterSet *delimitersss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitStringgg = [stringTimerrr componentsSeparatedByCharactersInSet:delimitersss];
                
                
                NSString *yStringgg = [splitStringgg objectAtIndex:1];
                
                NSString* localTimeee;
                
                if ([yStringgg containsString:@"-"]) {
                    
                    NSArray *arrrr = [yStringgg componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTimeee = [tr formattedAsTimeAgoThree];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimeee);
                    
                }
                
                
                NSString * commetAttrTextTwooo = localTimeee;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedCellThird.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:2];
                
                
                NSString * commentAttrTexttt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:2];
                
                NSString * combinedTexttt = [NSString stringWithFormat:@"%@  %@",commentAttrTexttt,commetAttrTextTwooo];
                
                
                
                CGFloat boldTextFontSizeeeee = 12.0f;
                
                CGFloat boldTextFontSizeeeeeeeeeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range111 = [combinedTexttt rangeOfString:commentAttrTexttt];
                NSRange range222 = [combinedTexttt rangeOfString:commetAttrTextTwooo];
                
                NSMutableAttributedString *attributedTexttt = [[NSMutableAttributedString alloc] initWithString:combinedTexttt];
                
                
                NSDictionary *attrDicttt = @{
                                             NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeeeeeeeeee],
                                             NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                             };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedTexttt setAttributes:attrDicttt  range:range222];
                
                [attributedTexttt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizeeeee]}
                                          range:range111];
                
                
                cell.commentAttributedLabelThree.attributedText = attributedTexttt;
                
                
                
                
                
                [cell.showMoreComments setHidden:NO];
                [cell.totalComments setHidden:YES];
                
            }
            // Post is Live Or Done
            
            if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0 ) {
                
                
                
                //  [cell.timerCell setHidden:NO];
                // [cell.remainingLabel setHidden:NO];
                
                
                NSString *stringTimer =[[globalArray valueForKey:@"EndDate"] objectAtIndex:indexPath.section];
                
                
                NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                
                NSString *xString = [splitString objectAtIndex:0];
                NSString *yString = [splitString objectAtIndex:1];
                
                
                
                if ([yString containsString:@"-"]) {
                    
                    NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    
                    NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    //  NSLog(@"localTime:%@", localTime);
                    
                    NSDateFormatter *dateFormatterCurrent=[[NSDateFormatter alloc] init];
                    [dateFormatterCurrent setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                    
                    
                    
                    NSString* localCurrentTime = [dateFormatterCurrent stringFromDate:[NSDate date]];
                    NSLog(@"current time :%@",localCurrentTime);
                    
                    NSTimeInterval diff = [tr timeIntervalSinceDate:[NSDate date]];
                    
                    NSLog(@"difffereeenceee %f",diff*1000 );
                    
                    valText = diff*1000;
                    
                    
                    float seconds = valText / 1000.0;
                    float minutes = seconds / 60.0;
                    
                    
                    testVa = minutes/1440;
                    
                    
                    
                    //                    float percentVal = testVa * 100;
                    //
                    //                    float percentFinalVal = percentVal/100
                    //
                    
                    if ([[self calculateTimer] isEqualToString:@""]) {
                        [cell.timerCell setHidden:YES];
                        [cell.progresssView setHidden:YES];
                    }
                    
                    else{
                        //  [cell.timerCell setHidden:NO];
                        // [cell.remainingLabel setHidden:NO];
                        cell.timerCell.text =  [self calculateTimer];
                        
                        
                        
                    }
                    
                    //
                    //                    if (valText >0 && valText <86400000 ) {
                    ////                        _timerCalc = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runScheduledTask:) userInfo:nil repeats:NO];
                    //
                    //
                    //                        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(valText / 1000.0)];
                    //
                    //                        NSString* localTimeee =[NSString stringWithFormat:@"%@",date];
                    //
                    //                        NSArray *seperateVal =  [localTimeee componentsSeparatedByString:@" "];
                    //
                    //                        NSArray *timeSplit = [[seperateVal objectAtIndex:1] componentsSeparatedByString:@":"];
                    //
                    //
                    //                      NSString*  exactTimeee = [NSString stringWithFormat:@"%@h. %@m. %@s.",[timeSplit objectAtIndex:0],[timeSplit objectAtIndex:1],[timeSplit objectAtIndex:2]];
                    //
                    //                        cell.timerCell.text  = exactTimeee;
                    //
                    //                        NSLog(@"timerrrr : %@",cell.timerCell.text);
                    //
                    //
                    //
                    //                    }
                    //
                    //
                    //
                    
                }
                
                
                
                
                
                
                
                /*******/
                [cell.yesNoMainView setHidden:NO];
                [cell.yesNoButtonView setHidden:YES];
                [cell.yesNoNotDoneButtonView setHidden:NO];
                cell.leftButton.userInteractionEnabled = YES;
                cell.rightButton.userInteractionEnabled = YES;
                
                [cell.leftButton setBackgroundColor:[UIColor whiteColor]];
                [cell.rightButton setBackgroundColor:[UIColor whiteColor]];
                
                [cell.reheyVoteButton setHidden:YES];
                
                
                //Has Voted Or not Button View
                
                
                if ([[[globalArray valueForKey:@"hasVoted"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                    
                    if ([voteResultAraay containsObject:[globalArray objectAtIndex:indexPath.section]]) {
                        
                        
                        
                        if ([voteResultVal isEqualToString:@"leftvoted"] || [voteResultVal isEqualToString:@"rightvoted"]) {
                            
                            
                            
                            
                            [cell.progresssView setHidden:YES];
                            
                            cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                      green:0.0f/255.0f
                                                                                       blue:20.0f/255.0f
                                                                                      alpha:0.7f];
                            cell.circularProgress.max = 1.0f;
                            cell.circularProgress.fillRadiusPx = 25;
                            cell.circularProgress.step = 0.1f;
                            cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                            cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                            cell.circularProgress.outlineWidth = 1;
                            cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                            cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                            
                            
                            [[HKCircularProgressView appearance] setAnimationDuration:5];
                            
                            cell.circularProgress.alwaysDrawOutline = YES;
                            
                            
                            cell.insideProgress.fillRadius = 1;
                            cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                            cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                            [cell.circularProgress setCurrent:testVa
                                                     animated:YES];
                            [cell.insideProgress setCurrent:1.0f
                                                   animated:YES];
                            
                            
                            
                            NSString*uVoted;
                            
                            // [cell.yesNoMainView setHidden:YES];
                            
                            if ([voteResultVal isEqualToString:@"leftvoted"]) {
                                
                                cell.leftButton.userInteractionEnabled = NO;
                                cell.rightButton.userInteractionEnabled = NO;
                                
                                [cell.leftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                    green:200.0f/255.0f
                                                                                     blue:200.0f/255.0f
                                                                                    alpha:1.0f]];
                                [cell.rightButton setBackgroundColor:[UIColor whiteColor]];
                                
                                
                                
                            }
                            
                            else if([voteResultVal isEqualToString:@"rightvoted"] == 1) {
                                
                                
                                cell.leftButton.userInteractionEnabled = NO;
                                cell.rightButton.userInteractionEnabled = NO;
                                
                                [cell.leftButton setBackgroundColor:[UIColor whiteColor]];
                                [cell.rightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                     green:200.0f/255.0f
                                                                                      blue:200.0f/255.0f
                                                                                     alpha:1.0f]];
                                
                                
                            }
                            
                            cell.youHaveVotedLabel.text =uVoted;
                        }
                        
                        else{
                            
                            
                            
                            [cell.yesNoMainView setHidden:NO];
                            [cell.yesNoButtonView setHidden:YES];
                            [cell.yesNoNotDoneButtonView setHidden:NO];
                        }
                        
                    }
                    
                }
                
                else if ([[[globalArray valueForKey:@"hasVoted"] objectAtIndex:indexPath.section] integerValue]  == 1 ) {
                    // [cell.yesNoMainView setHidden:YES];
                    
                    [cell.progresssView setHidden:YES];
                    
                    cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                              green:0.0f/255.0f
                                                                               blue:20.0f/255.0f
                                                                              alpha:0.7f];
                    cell.circularProgress.max = 1.0f;
                    cell.circularProgress.fillRadiusPx = 25;
                    cell.circularProgress.step = 0.1f;
                    cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                    cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                    cell.circularProgress.outlineWidth = 1;
                    cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                    cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                    
                    
                    [[HKCircularProgressView appearance] setAnimationDuration:5];
                    
                    cell.circularProgress.alwaysDrawOutline = YES;
                    
                    
                    cell.insideProgress.fillRadius = 1;
                    cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                    cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                    [cell.circularProgress setCurrent:testVa
                                             animated:YES];
                    [cell.insideProgress setCurrent:1.0f
                                           animated:YES];
                    
                    
                    
                    
                    NSString*uVoted;
                    
                    
                    if ([[[globalArray valueForKey:@"VoteOption"] objectAtIndex:indexPath.section] integerValue] == 0) {
                        
                        cell.leftButton.userInteractionEnabled = NO;
                        cell.rightButton.userInteractionEnabled = NO;
                        
                        [cell.leftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                            green:200.0f/255.0f
                                                                             blue:200.0f/255.0f
                                                                            alpha:1.0f]];
                        [cell.rightButton setBackgroundColor:[UIColor whiteColor]];
                        
                        
                    }
                    
                    else if([[[globalArray valueForKey:@"VoteOption"] objectAtIndex:indexPath.section] integerValue] == 1) {
                        
                        cell.leftButton.userInteractionEnabled = NO;
                        cell.rightButton.userInteractionEnabled = NO;
                        
                        
                        
                        [cell.leftButton setBackgroundColor:[UIColor whiteColor]];
                        [cell.rightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                             green:200.0f/255.0f
                                                                              blue:200.0f/255.0f
                                                                             alpha:1.0f]];
                        
                        
                    }
                    
                    cell.youHaveVotedLabel.text =uVoted;
                }
                
                
                
                
                
            }
            
            
            
            else if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 1) {
                [cell.timerCell setHidden:YES];
                [cell.remainingLabel setHidden:YES];
                
                [cell.yesNoMainView setHidden:NO];
                [cell.yesNoButtonView setHidden:NO];
                [cell.yesNoNotDoneButtonView setHidden:YES];
                cell.leftButton.userInteractionEnabled = NO;
                cell.rightButton.userInteractionEnabled = NO;
                
                
                [cell.reheyVoteButton setHidden:NO];
                
            }
            
            
            
            //Button Caption (YES/NO)
            [cell.leftButton setTitle:[[globalArray valueForKey:@"Caption1"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
            
            [cell.rightButton setTitle:[[globalArray valueForKey:@"Caption2"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
            
            [cell.leftResultButton setTitle:[[globalArray valueForKey:@"Caption1"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
            
            [cell.rightResultButton setTitle:[[globalArray valueForKey:@"Caption2"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
            
            
            
            
            
            //  return cell;
            
            
        }
        
        
        
        //CEll for video Post
        
        
        else  if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 2) {
            
            
            
            
            
            
            
            //  [self.mc pause];
            
            NSString * locationName = [[globalArray valueForKey:@"LocationName"] objectAtIndex:indexPath.section];
            if ([locationName length] > 0) {
                [cell.checkInView setHidden:NO];
                [cell.checkinButton setTitle:locationName forState: UIControlStateNormal];
                //                cell.videoPreview.frame = CGRectMake(cell.videoPreview.frame.origin.x, cell.videoPreview.frame.origin.y - cell.checkInView.frame.size.height, cell.videoPreview.frame.size.width, cell.videoPreview.frame.size.height);
                
            }
            
            
            
            
            [cell.videoPreview setHidden:NO];
            
            [cell.progresssView setHidden:YES];
            [cell.timerCell setHidden:YES];
            [cell.remainingLabel setHidden:YES];
            
            //Post Image
            
            //  [[MPMusicPlayerController applicationMusicPlayer] setVolume:0.0f];
            
            
            
            [cell.playerLayer removeFromSuperlayer];
            cell.videoplayer = nil ;
            cell.item = nil;
            [cell stopVideo];
            
            
            NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/api/media/play/%@/%@",[[globalArray valueForKey:@"Image1Idf"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"PostFolderPath"] objectAtIndex:indexPath.section] ];
            
            NSURL *url = [NSURL URLWithString:imageString];
            
            
            [cell createPlayerWithURL:url];
            
            
            
            
            
            
            
            
            
            
            cell.proImageView.image = [UIImage imageNamed:@"video-placeholder.png"];
            [cell.proImageView setHidden:NO];
            [cell.buttonOverImage setHidden:NO];
            [cell.voiceView setHidden:YES];
            
            
            
            
            
            
            NSString*percent = @"%";
            
            NSString*vote1 = [NSString stringWithFormat:@"%@ Votes (%@%@)",[[globalArray valueForKey:@"VoteCount1"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section],percent];
            
            
            NSString*vote2 = [NSString stringWithFormat:@"%@ Votes (%@%@)",[[globalArray valueForKey:@"VoteCount2"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section],percent];
            
            
            CGRect buttonFrameNew = CGRectMake(3, 2, resultButtonWidth, resultButtonHeight);
            buttonFrameNew.size = CGSizeMake(resultButtonWidth, resultButtonHeight);
            cell.leftResultButton.frame = buttonFrameNew;
            
            
            CGRect buttonFrameNew2 = CGRectMake(3, 20, resultButtonWidth, resultButtonHeight);
            buttonFrameNew2.size = CGSizeMake(resultButtonWidth, resultButtonHeight);
            cell.rightResultButton.frame = buttonFrameNew2;
            
            
            if ([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] > [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue]) {
                
                
                
                if (screenWidthios == 320) {
                    
                    
                    CGRect buttonFrame = cell.leftResultButton.frame;
                    buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                    cell.leftResultButton.frame = buttonFrame;
                    
                    
                    
                    
                    CGRect buttonFrame2 = cell.rightResultButton.frame;
                    buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                    cell.rightResultButton.frame = buttonFrame2;
                    
                    
                    
                }
                
                else if (screenWidthios == 375){
                    
                    
                    
                    CGRect buttonFrame = cell.leftResultButton.frame;
                    buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                    cell.leftResultButton.frame = buttonFrame;
                    
                    
                    
                    CGRect buttonFrame2 = cell.rightResultButton.frame;
                    buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                    cell.rightResultButton.frame = buttonFrame2;
                    
                    
                }
                
                else{
                    
                    
                    
                    CGRect buttonFrame = cell.leftResultButton.frame;
                    buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                    cell.leftResultButton.frame = buttonFrame;
                    
                    
                    
                    
                    CGRect buttonFrame2 = cell.rightResultButton.frame;
                    buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                    cell.rightResultButton.frame = buttonFrame2;
                    
                    
                }
                
                
                
                
                cell.leftResultButton.backgroundColor =  [UIColor colorWithRed:95/255.0f green:124/255.0f blue:138/255.0f alpha:1.0f];
                
                cell.rightResultButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                
                
                
                
                //                cell.voteLabelLeft.textColor = [UIColor whiteColor];
                //                cell.voteLabelLeft.backgroundColor = [UIColor colorWithRed:55/255.0f green:194/255.0f blue:4/255.0f alpha:1.0f];
                //
                //
                //
                //                cell.votesLabelRight.textColor = [UIColor whiteColor];
                //                cell.votesLabelRight.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                
                //                [cell.leftWinnerImage setHidden:NO];
                //                [cell.rightWinnerImage setHidden:YES];
                
            }
            
            else if([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] == [[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue]){
                
                
                cell.leftResultButton.backgroundColor =  [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                
                cell.rightResultButton.backgroundColor = [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                
                
                //
                //                cell.voteLabelLeft.textColor = [UIColor whiteColor];
                //
                //                cell.votesLabelRight.textColor = [UIColor whiteColor];
                //
                //
                //
                //                cell.voteLabelLeft.textColor = [UIColor whiteColor];
                //                cell.voteLabelLeft.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                //
                //
                //
                //                cell.votesLabelRight.textColor = [UIColor whiteColor];
                //                cell.votesLabelRight.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                
                //                [cell.leftWinnerImage setHidden:YES];
                //                [cell.rightWinnerImage setHidden:YES];
                
                
            }
            
            else{
                
                
                if (screenWidthios == 320) {
                    
                    
                    CGRect buttonFrame = cell.leftResultButton.frame;
                    buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                    cell.leftResultButton.frame = buttonFrame;
                    
                    
                    
                    
                    CGRect buttonFrame2 = cell.rightResultButton.frame;
                    buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 215, 17);
                    cell.rightResultButton.frame = buttonFrame2;
                    
                    
                    
                }
                
                else if (screenWidthios == 375){
                    
                    
                    
                    CGRect buttonFrame = cell.leftResultButton.frame;
                    buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                    cell.leftResultButton.frame = buttonFrame;
                    
                    
                    
                    CGRect buttonFrame2 = cell.rightResultButton.frame;
                    buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 270, 17);
                    cell.rightResultButton.frame = buttonFrame2;
                    
                    
                }
                
                else{
                    
                    
                    
                    CGRect buttonFrame = cell.leftResultButton.frame;
                    buttonFrame.size = CGSizeMake([[[globalArray valueForKey:@"Vote1Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                    cell.leftResultButton.frame = buttonFrame;
                    
                    
                    
                    
                    CGRect buttonFrame2 = cell.rightResultButton.frame;
                    buttonFrame2.size = CGSizeMake([[[globalArray valueForKey:@"Vote2Result"] objectAtIndex:indexPath.section] integerValue] + 309, 17);
                    cell.rightResultButton.frame = buttonFrame2;
                    
                    
                }
                
                cell.leftResultButton.backgroundColor =  [UIColor colorWithRed:163/255.0f green:188/255.0f blue:201/255.0f alpha:1.0f];
                
                cell.rightResultButton.backgroundColor = [UIColor colorWithRed:95/255.0f green:124/255.0f blue:138/255.0f alpha:1.0f];
                //
                
                
                //                cell.voteLabelLeft.textColor = [UIColor whiteColor];
                //                cell.voteLabelLeft.backgroundColor = [UIColor colorWithRed:218/255.0f green:34/255.0f blue:30/255.0f alpha:1.0f];
                //
                //
                //
                //                cell.votesLabelRight.textColor = [UIColor whiteColor];
                //                cell.votesLabelRight.backgroundColor = [UIColor colorWithRed:55/255.0f green:194/255.0f blue:4/255.0f alpha:1.0f];
                
                //                [cell.leftWinnerImage setHidden:YES];
                //                [cell.rightWinnerImage setHidden:NO];
                
                
            }
            
            cell.voteLabelLeft.text = vote1;
            cell.votesLabelRight.text = vote2;
            
            
            //Total HeyVote Counts
            
            
            NSString* totalVotes = [NSString stringWithFormat:@"%@ HeyVotes",[[globalArray valueForKey:@"VoteCount"] objectAtIndex:indexPath.section]];
            
            cell.totalVotesLabel.text = totalVotes;
            
            
            //Comments Count
            
            if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count]  >1) {
                
                NSString * totalComments = [NSString stringWithFormat:@"%ld comments",(long)[[[globalArray valueForKey:@"CommentCount"] objectAtIndex:indexPath.section] integerValue]];
                
                NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:totalComments];
                [attString addAttribute:NSUnderlineStyleAttributeName
                                  value:[NSNumber numberWithInt:1]
                                  range:(NSRange){0,[attString length]}];
                cell.totalComments.text =totalComments;
            }
            
            else{
                
                NSString * totalComments = [NSString stringWithFormat:@"%ld comments",(long)[[[globalArray valueForKey:@"CommentCount"] objectAtIndex:indexPath.section] integerValue]];
                
                
                NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:totalComments];
                [attString addAttribute:NSUnderlineStyleAttributeName
                                  value:[NSNumber numberWithInt:1]
                                  range:(NSRange){0,[attString length]}];
                cell.totalComments.text =totalComments;
                
                
            }
            
            
            
            
            //Post Title
            
            [cell.titleLabelView setHidden:NO];
            
            cell.titleLabel.text = [[globalArray valueForKey:@"Title"] objectAtIndex:indexPath.section];
            
            
            //Comment Attribute Label
            
            if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 1) {
                
                
                
                
                NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                
                
                
                
                
                
                NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                
                
                NSString *yString = [splitString objectAtIndex:1];
                
                
                
                if ([yString containsString:@"-"]) {
                    
                    NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    NSString* localTime = [tr formattedAsTimeAgo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                    
                    
                    //                [cell.commentAttributedLabel setHidden:NO];
                    //                [cell.showMoreComments setHidden:YES];
                    
                    //
                    //      NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    cell.commentAttributedLabelFirst.text= [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                    
                    
                    NSString * commetAttrTextTwo = localTime;
                    
                    NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                    
                    NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                    
                    
                    
                    CGFloat boldTextFontSize = 12.0f;
                    
                    CGFloat boldTextFontSizeee = 10.0f;
                    
                    //  cell.commentAttributedLabel.text = combinedText;
                    
                    NSRange range1 = [combinedText rangeOfString:commentAttrText];
                    NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                    
                    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                    
                    
                    NSDictionary *attrDict = @{
                                               NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                               NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                               };
                    
                    
                    //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                    [attributedText setAttributes:attrDict  range:range2];
                    
                    
                    [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                            range:range1];
                    
                    
                    cell.commentAttributedLabel.attributedText = attributedText;
                    
                    
                    
                    
                }
                
                
            }
            
            
            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 2) {
                
                
                
                
                NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                
                
                
                
                
                
                NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                
                
                NSString *yString = [splitString objectAtIndex:1];
                
                NSString* localTime;
                
                if ([yString containsString:@"-"]) {
                    
                    NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTime = [tr formattedAsTimeAgo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                    
                }
                
                
                NSString * commetAttrTextTwo = localTime;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                
                NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                
                
                
                CGFloat boldTextFontSize = 12.0f;
                
                CGFloat boldTextFontSizeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range1 = [combinedText rangeOfString:commentAttrText];
                NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                
                NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                
                
                NSDictionary *attrDict = @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                           NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                           };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedText setAttributes:attrDict  range:range2];
                
                [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                        range:range1];
                
                
                cell.commentAttributedLabel.attributedText = attributedText;
                
                
                
                
                
                NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                
                
                
                
                
                
                NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                
                
                NSString *yStringg = [splitStringg objectAtIndex:1];
                
                NSString* localTimee;
                
                if ([yStringg containsString:@"-"]) {
                    
                    NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTimee = [tr formattedAsTimeAgoTwo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                    
                }
                
                
                NSString * commetAttrTextTwoo = localTimee;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedCellSecond.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                
                NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                
                NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                
                
                
                CGFloat boldTextFontSizee = 12.0f;
                
                CGFloat boldTextFontSizeeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                
                NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                
                
                NSDictionary *attrDictt = @{
                                            NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                            NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                            };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedTextt setAttributes:attrDictt  range:range22];
                
                [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                         range:range11];
                
                
                cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                
                
                
                
            }
            
            
            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 3) {
                
                
                
                
                NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                
                
                
                NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                
                
                NSString *yString = [splitString objectAtIndex:1];
                
                NSString* localTime;
                
                if ([yString containsString:@"-"]) {
                    
                    NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTime = [tr formattedAsTimeAgo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                    
                }
                
                
                NSString * commetAttrTextTwo = localTime;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedLabelFirst.text =  cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                
                NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                
                
                
                CGFloat boldTextFontSize = 12.0f;
                
                CGFloat boldTextFontSizeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range1 = [combinedText rangeOfString:commentAttrText];
                NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                
                NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                
                
                NSDictionary *attrDict = @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                           NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                           };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedText setAttributes:attrDict  range:range2];
                
                [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                        range:range1];
                
                
                cell.commentAttributedLabel.attributedText = attributedText;
                
                
                
                NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                
                
                NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                
                
                NSString *yStringg = [splitStringg objectAtIndex:1];
                
                NSString* localTimee;
                
                if ([yStringg containsString:@"-"]) {
                    
                    NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTimee = [tr formattedAsTimeAgoTwo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                    
                }
                
                
                NSString * commetAttrTextTwoo = localTimee;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedCellSecond.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                
                NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                
                NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                
                
                
                CGFloat boldTextFontSizee = 12.0f;
                
                CGFloat boldTextFontSizeeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                
                NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                
                
                NSDictionary *attrDictt = @{
                                            NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                            NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                            };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedTextt setAttributes:attrDictt  range:range22];
                
                [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                         range:range11];
                
                
                cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                
                
                
                
                
                
                
                
                NSString *stringTimerrr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:2];
                
                
                
                
                
                
                NSCharacterSet *delimitersss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitStringgg = [stringTimerrr componentsSeparatedByCharactersInSet:delimitersss];
                
                
                NSString *yStringgg = [splitStringgg objectAtIndex:1];
                
                NSString* localTimeee;
                
                if ([yStringgg containsString:@"-"]) {
                    
                    NSArray *arrrr = [yStringgg componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTimeee = [tr formattedAsTimeAgoThree];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimeee);
                    
                }
                
                
                NSString * commetAttrTextTwooo = localTimeee;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedCellThird.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:2];
                
                
                NSString * commentAttrTexttt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:2];
                
                NSString * combinedTexttt = [NSString stringWithFormat:@"%@  %@",commentAttrTexttt,commetAttrTextTwooo];
                
                
                
                CGFloat boldTextFontSizeeeee = 12.0f;
                
                CGFloat boldTextFontSizeeeeeeeeeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range111 = [combinedTexttt rangeOfString:commentAttrTexttt];
                NSRange range222 = [combinedTexttt rangeOfString:commetAttrTextTwooo];
                
                NSMutableAttributedString *attributedTexttt = [[NSMutableAttributedString alloc] initWithString:combinedTexttt];
                
                
                NSDictionary *attrDicttt = @{
                                             NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeeeeeeeeee],
                                             NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                             };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedTexttt setAttributes:attrDicttt  range:range222];
                
                [attributedTexttt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizeeeee]}
                                          range:range111];
                
                
                cell.commentAttributedLabelThree.attributedText = attributedTexttt;
                
                
                
                
            }
            
            
            
            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] > 3) {
                
                
                
                
                
                
                NSString *stringTimer =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:0];
                
                
                
                
                
                
                NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                
                
                NSString *yString = [splitString objectAtIndex:1];
                
                NSString* localTime;
                
                if ([yString containsString:@"-"]) {
                    
                    NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTime = [tr formattedAsTimeAgo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTime);
                    
                }
                
                
                NSString * commetAttrTextTwo = localTime;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedLabelFirst.text = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                NSString * commentAttrText = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:0];
                
                NSString * combinedText = [NSString stringWithFormat:@"%@  %@",commentAttrText,commetAttrTextTwo];
                
                
                
                CGFloat boldTextFontSize = 12.0f;
                
                CGFloat boldTextFontSizeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range1 = [combinedText rangeOfString:commentAttrText];
                NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                
                NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                
                
                NSDictionary *attrDict = @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                           NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                           };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedText setAttributes:attrDict  range:range2];
                
                [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                        range:range1];
                
                
                cell.commentAttributedLabel.attributedText = attributedText;
                
                
                
                
                
                NSString *stringTimerr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:1];
                
                
                
                
                
                
                NSCharacterSet *delimiterss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitStringg = [stringTimerr componentsSeparatedByCharactersInSet:delimiterss];
                
                
                NSString *yStringg = [splitStringg objectAtIndex:1];
                
                NSString* localTimee;
                
                if ([yStringg containsString:@"-"]) {
                    
                    NSArray *arrrr = [yStringg componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTimee = [tr formattedAsTimeAgoTwo];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimee);
                    
                }
                
                
                NSString * commetAttrTextTwoo = localTimee;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedCellSecond.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:1];
                
                NSString * commentAttrTextt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:1];
                
                NSString * combinedTextt = [NSString stringWithFormat:@"%@  %@",commentAttrTextt,commetAttrTextTwoo];
                
                
                
                CGFloat boldTextFontSizee = 12.0f;
                
                CGFloat boldTextFontSizeeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range11 = [combinedTextt rangeOfString:commentAttrTextt];
                NSRange range22 = [combinedTextt rangeOfString:commetAttrTextTwoo];
                
                NSMutableAttributedString *attributedTextt = [[NSMutableAttributedString alloc] initWithString:combinedTextt];
                
                
                NSDictionary *attrDictt = @{
                                            NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeee],
                                            NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                            };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedTextt setAttributes:attrDictt  range:range22];
                
                [attributedTextt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizee]}
                                         range:range11];
                
                
                cell.commentAttributedLabelTwo.attributedText = attributedTextt;
                
                
                
                
                
                
                
                
                NSString *stringTimerrr =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"CreatedOn"] objectAtIndex:2];
                
                
                
                
                
                
                NSCharacterSet *delimitersss = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitStringgg = [stringTimerrr componentsSeparatedByCharactersInSet:delimitersss];
                
                
                NSString *yStringgg = [splitStringgg objectAtIndex:1];
                
                NSString* localTimeee;
                
                if ([yStringgg containsString:@"-"]) {
                    
                    NSArray *arrrr = [yStringgg componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    localTimeee = [tr formattedAsTimeAgoThree];
                    //   NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTimedfsdfsdfsdfsd:%@", localTimeee);
                    
                }
                
                
                NSString * commetAttrTextTwooo = localTimeee;
                
                //  NSString * commetAttrTextTwo = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:0];
                
                
                cell.commentAttributedCellThird.text =[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Comment"] objectAtIndex:2];
                
                
                NSString * commentAttrTexttt = [[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"DisplayName"] objectAtIndex:2];
                
                NSString * combinedTexttt = [NSString stringWithFormat:@"%@  %@",commentAttrTexttt,commetAttrTextTwooo];
                
                
                
                CGFloat boldTextFontSizeeeee = 12.0f;
                
                CGFloat boldTextFontSizeeeeeeeeeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range111 = [combinedTexttt rangeOfString:commentAttrTexttt];
                NSRange range222 = [combinedTexttt rangeOfString:commetAttrTextTwooo];
                
                NSMutableAttributedString *attributedTexttt = [[NSMutableAttributedString alloc] initWithString:combinedTexttt];
                
                
                NSDictionary *attrDicttt = @{
                                             NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeeeeeeeeeee],
                                             NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                             };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedTexttt setAttributes:attrDicttt  range:range222];
                
                [attributedTexttt setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSizeeeee]}
                                          range:range111];
                
                
                cell.commentAttributedLabelThree.attributedText = attributedTexttt;
                
                
                [cell.showMoreComments setHidden:NO];
                [cell.totalComments setHidden:YES];
                
            }
            
            // Post is Live Or Done
            
            if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0 ) {
                
                
                
                //  [cell.timerCell setHidden:NO];
                // [cell.remainingLabel setHidden:NO];
                
                
                NSString *stringTimer =[[globalArray valueForKey:@"EndDate"] objectAtIndex:indexPath.section];
                
                
                NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                
                NSString *xString = [splitString objectAtIndex:0];
                NSString *yString = [splitString objectAtIndex:1];
                
                
                
                if ([yString containsString:@"-"]) {
                    
                    NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                    
                    
                    NSString* testOne = [arrrr objectAtIndex:0];
                    
                    
                    NSString* beforeConvert =[arrrr objectAtIndex:1];
                    
                    NSString*mystr=[beforeConvert substringToIndex:2];
                    
                    NSInteger multipliedVal = [mystr integerValue] * 3600000;
                    
                    NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                    
                    
                    NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                    
                    
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    
                    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    
                    
                    NSString* localTime = [dateFormatter stringFromDate:tr];
                    
                    NSLog(@"localTime:%@", localTime);
                    
                    NSDateFormatter *dateFormatterCurrent=[[NSDateFormatter alloc] init];
                    [dateFormatterCurrent setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                    
                    
                    
                    NSString* localCurrentTime = [dateFormatterCurrent stringFromDate:[NSDate date]];
                    NSLog(@"current time :%@",localCurrentTime);
                    
                    NSTimeInterval diff = [tr timeIntervalSinceDate:[NSDate date]];
                    
                    NSLog(@"difffereeenceee %f",diff*1000 );
                    
                    valText = diff*1000;
                    
                    
                    float seconds = valText / 1000.0;
                    float minutes = seconds / 60.0;
                    
                    
                    testVa = minutes/1440;
                    
                    
                    
                    //                    float percentVal = testVa * 100;
                    //
                    //                    float percentFinalVal = percentVal/100
                    //
                    
                    if ([[self calculateTimer] isEqualToString:@""]) {
                        [cell.timerCell setHidden:YES];
                        [cell.progresssView setHidden:YES];
                    }
                    
                    else{
                        //  [cell.timerCell setHidden:NO];
                        //  [cell.remainingLabel setHidden:NO];
                        cell.timerCell.text =  [self calculateTimer];
                        
                        
                        
                    }
                    
                    //
                    //                    if (valText >0 && valText <86400000 ) {
                    ////                        _timerCalc = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runScheduledTask:) userInfo:nil repeats:NO];
                    //
                    //
                    //                        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(valText / 1000.0)];
                    //
                    //                        NSString* localTimeee =[NSString stringWithFormat:@"%@",date];
                    //
                    //                        NSArray *seperateVal =  [localTimeee componentsSeparatedByString:@" "];
                    //
                    //                        NSArray *timeSplit = [[seperateVal objectAtIndex:1] componentsSeparatedByString:@":"];
                    //
                    //
                    //                      NSString*  exactTimeee = [NSString stringWithFormat:@"%@h. %@m. %@s.",[timeSplit objectAtIndex:0],[timeSplit objectAtIndex:1],[timeSplit objectAtIndex:2]];
                    //
                    //                        cell.timerCell.text  = exactTimeee;
                    //
                    //                        NSLog(@"timerrrr : %@",cell.timerCell.text);
                    //
                    //
                    //
                    //                    }
                    //
                    //
                    //
                    
                }
                
                
                
                /*******/
                [cell.yesNoMainView setHidden:NO];
                [cell.yesNoButtonView setHidden:YES];
                [cell.yesNoNotDoneButtonView setHidden:NO];
                cell.leftButton.userInteractionEnabled = YES;
                cell.rightButton.userInteractionEnabled = YES;
                
                [cell.leftButton setBackgroundColor:[UIColor whiteColor]];
                [cell.rightButton setBackgroundColor:[UIColor whiteColor]];
                
                [cell.reheyVoteButton setHidden:YES];
                
                
                //Has Voted Or not Button View
                
                
                if ([[[globalArray valueForKey:@"hasVoted"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                    
                    if ([voteResultAraay containsObject:[globalArray objectAtIndex:indexPath.section]]) {
                        
                        
                        
                        if ([voteResultVal isEqualToString:@"leftvoted"] || [voteResultVal isEqualToString:@"rightvoted"]) {
                            
                            
                            
                            
                            [cell.progresssView setHidden:YES];
                            
                            cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                      green:0.0f/255.0f
                                                                                       blue:20.0f/255.0f
                                                                                      alpha:0.7f];
                            cell.circularProgress.max = 1.0f;
                            cell.circularProgress.fillRadiusPx = 25;
                            cell.circularProgress.step = 0.1f;
                            cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                            cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                            cell.circularProgress.outlineWidth = 1;
                            cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                            cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                            
                            
                            [[HKCircularProgressView appearance] setAnimationDuration:5];
                            
                            cell.circularProgress.alwaysDrawOutline = YES;
                            
                            
                            cell.insideProgress.fillRadius = 1;
                            cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                            cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                            [cell.circularProgress setCurrent:testVa
                                                     animated:YES];
                            [cell.insideProgress setCurrent:1.0f
                                                   animated:YES];
                            
                            
                            
                            NSString*uVoted;
                            
                            // [cell.yesNoMainView setHidden:YES];
                            
                            if ([voteResultVal isEqualToString:@"leftvoted"]) {
                                
                                cell.leftButton.userInteractionEnabled = NO;
                                cell.rightButton.userInteractionEnabled = NO;
                                
                                [cell.leftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                    green:200.0f/255.0f
                                                                                     blue:200.0f/255.0f
                                                                                    alpha:1.0f]];
                                [cell.rightButton setBackgroundColor:[UIColor whiteColor]];
                                
                                
                                
                            }
                            
                            else if([voteResultVal isEqualToString:@"rightvoted"] == 1) {
                                
                                
                                cell.leftButton.userInteractionEnabled = NO;
                                cell.rightButton.userInteractionEnabled = NO;
                                
                                [cell.leftButton setBackgroundColor:[UIColor whiteColor]];
                                [cell.rightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                     green:200.0f/255.0f
                                                                                      blue:200.0f/255.0f
                                                                                     alpha:1.0f]];
                                
                                
                            }
                            
                            cell.youHaveVotedLabel.text =uVoted;
                        }
                        
                        else{
                            
                            
                            
                            [cell.yesNoMainView setHidden:NO];
                            [cell.yesNoButtonView setHidden:YES];
                            [cell.yesNoNotDoneButtonView setHidden:NO];
                        }
                        
                    }
                    
                }
                
                else if ([[[globalArray valueForKey:@"hasVoted"] objectAtIndex:indexPath.section] integerValue]  == 1 ) {
                    // [cell.yesNoMainView setHidden:YES];
                    
                    //                    [cell.progresssView setHidden:YES];
                    //                    [cell.timerCell setHidden:NO];
                    //                    [cell.remainingLabel setHidden:NO];
                    //
                    cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                              green:0.0f/255.0f
                                                                               blue:20.0f/255.0f
                                                                              alpha:0.7f];
                    cell.circularProgress.max = 1.0f;
                    cell.circularProgress.fillRadiusPx = 25;
                    cell.circularProgress.step = 0.1f;
                    cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                    cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                    cell.circularProgress.outlineWidth = 1;
                    cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                    cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                    
                    
                    [[HKCircularProgressView appearance] setAnimationDuration:5];
                    
                    cell.circularProgress.alwaysDrawOutline = YES;
                    
                    
                    cell.insideProgress.fillRadius = 1;
                    cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                    cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                    [cell.circularProgress setCurrent:testVa
                                             animated:YES];
                    [cell.insideProgress setCurrent:1.0f
                                           animated:YES];
                    
                    
                    
                    
                    NSString*uVoted;
                    
                    
                    if ([[[globalArray valueForKey:@"VoteOption"] objectAtIndex:indexPath.section] integerValue] == 0) {
                        
                        cell.leftButton.userInteractionEnabled = NO;
                        cell.rightButton.userInteractionEnabled = NO;
                        
                        [cell.leftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                            green:200.0f/255.0f
                                                                             blue:200.0f/255.0f
                                                                            alpha:1.0f]];
                        [cell.rightButton setBackgroundColor:[UIColor whiteColor]];
                        
                        
                    }
                    
                    else if([[[globalArray valueForKey:@"VoteOption"] objectAtIndex:indexPath.section] integerValue] == 1) {
                        
                        cell.leftButton.userInteractionEnabled = NO;
                        cell.rightButton.userInteractionEnabled = NO;
                        
                        
                        
                        [cell.leftButton setBackgroundColor:[UIColor whiteColor]];
                        [cell.rightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                             green:200.0f/255.0f
                                                                              blue:200.0f/255.0f
                                                                             alpha:1.0f]];
                        
                        
                    }
                    
                    cell.youHaveVotedLabel.text =uVoted;
                }
                
                
                
                
                
            }
            
            
            
            else if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 1) {
                [cell.timerCell setHidden:YES];
                [cell.remainingLabel setHidden:YES];
                
                [cell.yesNoMainView setHidden:NO];
                [cell.yesNoButtonView setHidden:NO];
                [cell.yesNoNotDoneButtonView setHidden:YES];
                cell.leftButton.userInteractionEnabled = NO;
                cell.rightButton.userInteractionEnabled = NO;
                
                
                [cell.reheyVoteButton setHidden:NO];
                
            }
            
            
            //Button Caption (YES/NO)
            [cell.leftButton setTitle:[[globalArray valueForKey:@"Caption1"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
            
            [cell.rightButton setTitle:[[globalArray valueForKey:@"Caption2"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
            
            [cell.leftResultButton setTitle:[[globalArray valueForKey:@"Caption1"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
            
            [cell.rightResultButton setTitle:[[globalArray valueForKey:@"Caption2"] objectAtIndex:indexPath.section] forState: UIControlStateNormal];
            
            //   return cell;
            
            
        }
        
        
        
        
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:
                cellIdentifierFour];
        if (cell == nil) {
            cell = [[globalViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifierFour];
        }
    }
    
    return cell;
    
}




// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (globalArray.count == 0) {
        return 1;
    }
    else{
     
        
        return [globalArray count];
        
    }
}



#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //    NSArray *collectionViewArray = self.colorArray[[(AFIndexedCollectionView *)collectionView indexPath].row];
    //    return collectionViewArray.count;
    
    
    
    
    return [nameArr count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionIdentifier" forIndexPath:indexPath];
    
    if (nameArr.count == 0) {
        
    }else{
        NSString *  newStr = [[nameArr valueForKey:@"HashTag"] objectAtIndex:indexPath.row];
        if ([newStr hasPrefix:@" "]) {
            newStr = [newStr substringFromIndex:1];
        }
        
        
        cell.hashLabels.text = [NSString stringWithFormat:@"#%@",newStr];
        
        //[cell.hashLabels sizeToFit];
        
        // [cell.hashLabels sizeToFit];
        
        //        //get the width and height of the label (CGSize contains two parameters: width and height)
        labelSize = cell.hashLabels.frame.size;
        //
        //        NSLog(@"\n width  = %f height = %f", labelSize.width,labelSize.height);
        //
        
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //
    //    return [(NSString*)[[nameArr valueForKey:@"HashTag"] objectAtIndex:indexPath.row] sizeWithAttributes:NULL];
    return CGSizeMake([[[nameArr valueForKey:@"HashTag"] objectAtIndex:indexPath.row] length]+ 60, 15);
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",[[nameArr valueForKey:@"HashTagId"] objectAtIndex:indexPath.row]);
    
    
    commentViewVal = @"val";
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    GetPostDetailsViewController *myVC = (GetPostDetailsViewController *)[storyboard instantiateViewControllerWithIdentifier:@"GetPostDetailsViewController"];
    myVC.postIdVal = [[nameArr valueForKey:@"HashTagId"] objectAtIndex:indexPath.row];
    myVC.hashTagName = [[nameArr valueForKey:@"HashTag"] objectAtIndex:indexPath.row];
    myVC.hashTagValString = @"hashTag";
    [self PushAnimation];
    [self.navigationController pushViewController:myVC animated:NO];
    
    
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    side = collectionView.frame.size.width/2-5;
//    height= collectionView.frame.size.height/2+collectionView.frame.size.height/2;
//
//
//    return CGSizeMake(side, height);
//}
////- (NSIndexPath *)indexPathForItemAtPoint:(CGPoint)point
////{
////
////	return
////}
//
//
//
//-(NSIndexPath *) getButtonIndexPath:(UIButton *) button
//{
//    CGRect buttonFrame = [button convertRect:button.bounds toView:_travelFeedTableView];
//    return [_travelFeedTableView indexPathForRowAtPoint:buttonFrame.origin];
//}
//
//





- (NSString *) calculateTimerForComments
{
    // Here count down timer is only for visible rows not for each rows.
    NSString*  exactTimeee;
    //  NSArray *listOFCurrentCell = [_myTableView visibleCells]; // Returns the table cells that are visible in the table view.
    // for(globalViewCell *theMycustomCell in listOFCurrentCell)
    //  {
    if (valTextForComments  >0 ) {
        //
        //        NSCalendar *_calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        //        NSCalendarUnit _units = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        //        NSDateComponents *_components = [_calendar components:_units fromDate:[NSDate date] toDate:[NSDate dateWithTimeIntervalSinceNow:valTextForComments] options:kNilOptions];
        //
        //        NSLog(@"%ld Days, %ld Hours, %ld Minutes, %ld Seconds", _components.day, _components.hour, _components.minute, _components.second);
        secondsLeftForComments = valTextForComments;
        
        
        int milliseconds = valTextForComments;
        
        int seconds = milliseconds / 1000;
        
        int minutes = seconds / 60;
        
        seconds %= 60;
        
        int hours = minutes / 60;
        
        minutes %= 60;
        
        int days = hours / 24;
        
        hours %= 24;
        
        
        NSLog(@"dayssssss  : %d",days);
        NSLog(@"hourssssss  : %d",hours);
        
        NSLog(@"minsssss  : %d",minutes);
        
        
        
        if (days  == 0) {
            
            
            if (hours == 0) {
                
                
                if (minutes == 0 ) {
                    exactTimeee = @"Just now";
                }
                
                
                else{
                    exactTimeee = [NSString stringWithFormat:@"%d min. ago",minutes];
                }
                
                
            }
            
            
            else{
                
                exactTimeee = [NSString stringWithFormat:@"%d hours. ago",minutes];
                
            }
            
            
        }
        
        
        else{
            
            
            if (days == 1) {
                exactTimeee = [NSString stringWithFormat:@"Yesterday"];
            }
            
            else {
                
                exactTimeee = [NSString stringWithFormat:@"%d days.ago",days];
            }
            
        }
        
        
        
        
        
        
        //  secondsLeftForComments--;
        
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(secondsLeftForComments / 1000.0)];
        
        
        
        NSString* localTime =[NSString stringWithFormat:@"%@",date];
        
        NSArray *seperateVal =  [localTime componentsSeparatedByString:@" "];
        
        NSArray *timeSplit = [[seperateVal objectAtIndex:1] componentsSeparatedByString:@":"];
        
        if ([[timeSplit objectAtIndex:0] isEqualToString:@"00"]) {
            
            if ([[timeSplit objectAtIndex:0] isEqualToString:@"00"] && [[timeSplit objectAtIndex:1] isEqualToString:@"00"]) {
                exactTimeee = @"Just now";
            }
            
            else{
                exactTimeee = [NSString stringWithFormat:@"%@ min. ago",[timeSplit objectAtIndex:1]];
            }
            
            
            
            
        }
        
        else {
            if ([[timeSplit objectAtIndex:0] integerValue] <= 24) {
                
                exactTimeee = [NSString stringWithFormat:@"%@ hr. ago",[timeSplit objectAtIndex:0]];
            }
            
            
            
            else if ([[timeSplit objectAtIndex:0] integerValue] >= 24 && [[timeSplit objectAtIndex:0] integerValue] <= 48) {
                
                exactTimeee = [NSString stringWithFormat:@"Yesterday"];
                
            }
            
            else if ([[timeSplit objectAtIndex:0] integerValue] > 48 ){
                
                NSInteger i = [[timeSplit objectAtIndex:0] integerValue]/24;
                
                NSString * newV = [NSString stringWithFormat:@"%ld",(long)i];
                
                if([newV rangeOfString:@"."].location == NSNotFound)
                {
                    exactTimeee = [NSString stringWithFormat:@"%@ days",newV];
                }
                else
                {
                    
                    NSArray *items = [newV componentsSeparatedByString:@"."];
                    
                    exactTimeee = [NSString stringWithFormat:@"%@ days",[items objectAtIndex:0]];
                    
                    NSLog(@"found");
                }
                
                
            }
            
            
            
            
            
            
            
        }
        
        
        
        
        // Timer.text = exactTime;
        //[_myTableView reloadData];
        if (secondsLeftForComments==0) {
            [_timerCalc invalidate];
            
            exactTime = @"";
        }
        
        
        
        
        
        
        // recentVal = exactTimeee;
        //  }
        
        
        
        
    }
    
    
    return exactTimeee;
}







- (NSString *) calculateTimer
{
    // Here count down timer is only for visible rows not for each rows.
    NSString*  exactTimeee;
    //  NSArray *listOFCurrentCell = [_myTableView visibleCells]; // Returns the table cells that are visible in the table view.
    // for(globalViewCell *theMycustomCell in listOFCurrentCell)
    //  {
    if (valText >0 && valText <86400000 ) {
        
        
        
        secondsLeft = valText;
        
        
        secondsLeft--;
        
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(secondsLeft / 1000.0)];
        
        NSString* localTime =[NSString stringWithFormat:@"%@",date];
        
        NSArray *seperateVal =  [localTime componentsSeparatedByString:@" "];
        
        NSArray *timeSplit = [[seperateVal objectAtIndex:1] componentsSeparatedByString:@":"];
        
        if ([[timeSplit objectAtIndex:0] isEqualToString:@"00"]) {
            exactTimeee = [NSString stringWithFormat:@"%@m. %@s.",[timeSplit objectAtIndex:1],[timeSplit objectAtIndex:2]];
            
            
        }
        
        else {
            
            exactTimeee = [NSString stringWithFormat:@"%@h. %@m. %@s.",[timeSplit objectAtIndex:0],[timeSplit objectAtIndex:1],[timeSplit objectAtIndex:2]];
            
            
        }
        
        
        
        
        // Timer.text = exactTime;
        //[_myTableView reloadData];
        if (secondsLeft==0) {
            [_timerCalc invalidate];
            
            exactTime = @"";
        }
        
        
        
        
        
        
        // recentVal = exactTimeee;
        //  }
        
        
        
        
    }
    
    
    return exactTimeee;
}

- (void)runScheduledTask: (NSTimer *) runningTimer {
    if ([timerLoad isEqualToString:@""]) {
        
        //
        //          NSArray *visible       = [self.myTableView indexPathsForVisibleRows];
        //         NSIndexPath *indexpath = (NSIndexPath*)[visible objectAtIndex:0];
        //
        //        //  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        //
        //          globalViewCell *cell = [self.myTableView cellForRowAtIndexPath:indexpath];
        //
        
        [_myTableView reloadData];
        
    }
    
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (globalArray.count >0) {
        
        if ([[[globalArray valueForKey:@"ReHeyVotePostId"] objectAtIndex:section] integerValue]==0) {
            
            
            if (screenWidthios == 320) {
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 14)];
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
                button.tag = section;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                
                button.backgroundColor = [UIColor clearColor];
                
                // Doing the Decoration Part
                view.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
                view.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
                view.layer.shadowRadius = 0.0f;
                view.layer.shadowOpacity = 0.1f;
                
                
                /* Create custom view to display section header... */
                
                UILabel *label;
                //  label = [[UILabel alloc] initWithFrame:CGRectMake(58, 24, 200, 20)];
                
                label = [[UILabel alloc] initWithFrame:CGRectMake(58, 12, 160, 18)];
                [label setFont:[UIFont boldSystemFontOfSize:14]];
                NSString *string =[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:section];
                
                
                /* Section header is in 0th index... */
                [label setText:string];
                //  [label sizeToFit];
                
                [label setTextColor:[UIColor blackColor]];
                
                if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:section] integerValue]  == 0 ) {
                    
                    
                    //  Timer = [[UILabel alloc] initWithFrame:CGRectMake(_myTableView.frame.size.width - 130, 24, 130, 20)];
                    
                    Timer = [[UILabel alloc] initWithFrame:CGRectMake(42, 28, 275, 18)];
                    [Timer setFont:[UIFont boldSystemFontOfSize:13]];
                    
                    
                    
                    Timer.textAlignment = NSTextAlignmentRight;
                    
                    NSString *stringTimer =[[globalArray valueForKey:@"EndDate"] objectAtIndex:section];
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    NSString *xString = [splitString objectAtIndex:0];
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        
                        NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTime:%@", localTime);
                        
                        NSDateFormatter *dateFormatterCurrent=[[NSDateFormatter alloc] init];
                        [dateFormatterCurrent setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                        
                        
                        
                        NSString* localCurrentTime = [dateFormatterCurrent stringFromDate:[NSDate date]];
                        NSLog(@"current time :%@",localCurrentTime);
                        
                        NSTimeInterval diff = [tr timeIntervalSinceDate:[NSDate date]];
                        
                        NSLog(@"difffereeenceee %f",diff*1000 );
                        
                        valText = diff*1000;
                        
                        
                        
                        
                        if([[self calculateTimer] isEqualToString:@""]){
                            
                            [Timer setText:@""];
                            
                        }
                        
                        else{
                            
                            
                            [Timer setText:[self calculateTimer]];
                            //  [Timer sizeToFit];
                        }
                        [view addSubview:Timer];
                        [Timer setTextColor:[UIColor darkGrayColor]];
                        
                    }
                    
                }
                
                NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[globalArray valueForKey:@"ImgIdf"] objectAtIndex:section],[[globalArray valueForKey:@"FolderPath"] objectAtIndex:section]];
                
                
                
                UIImageView *labelImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 6, 40, 40)];
                
                [labelImage  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"imagesPerson.jpeg"]];
                
                labelImage.layer.cornerRadius = labelImage.frame.size.height /2;
                labelImage.layer.masksToBounds = YES;
                labelImage.layer.borderWidth = 0;
                
                
                
                [view addSubview:labelImage];
                
                
                [view addSubview:label];
                
                
                [view addSubview:button];
                
                
                [view setBackgroundColor:[UIColor whiteColor]]; //your background color...
                
                return view;
                
            }
            
            else{
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
                button.tag = section;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                
                button.backgroundColor = [UIColor clearColor];
                
                // Doing the Decoration Part
                view.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
                view.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
                view.layer.shadowRadius = 0.0f;
                view.layer.shadowOpacity = 0.1f;
                
                
                /* Create custom view to display section header... */
                
                UILabel *label;
                //  label = [[UILabel alloc] initWithFrame:CGRectMake(58, 24, 200, 20)];
                
                label = [[UILabel alloc] initWithFrame:CGRectMake(58, 14, 200, 20)];
                [label setFont:[UIFont boldSystemFontOfSize:15]];
                NSString *string =[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:section];
                
                
                /* Section header is in 0th index... */
                [label setText:string];
                //  [label sizeToFit];
                
                [label setTextColor:[UIColor blackColor]];
                
                if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:section] integerValue]  == 0 ) {
                    
                    
                    //  Timer = [[UILabel alloc] initWithFrame:CGRectMake(_myTableView.frame.size.width - 130, 24, 130, 20)];
                    
                    Timer = [[UILabel alloc] initWithFrame:CGRectMake(58, 32, 300, 20)];
                    [Timer setFont:[UIFont boldSystemFontOfSize:14]];
                    
                    
                    
                    Timer.textAlignment = NSTextAlignmentRight;
                    
                    NSString *stringTimer =[[globalArray valueForKey:@"EndDate"] objectAtIndex:section];
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    NSString *xString = [splitString objectAtIndex:0];
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        
                        NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTime:%@", localTime);
                        
                        NSDateFormatter *dateFormatterCurrent=[[NSDateFormatter alloc] init];
                        [dateFormatterCurrent setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                        
                        
                        
                        NSString* localCurrentTime = [dateFormatterCurrent stringFromDate:[NSDate date]];
                        NSLog(@"current time :%@",localCurrentTime);
                        
                        NSTimeInterval diff = [tr timeIntervalSinceDate:[NSDate date]];
                        
                        NSLog(@"difffereeenceee %f",diff*1000 );
                        
                        valText = diff*1000;
                        
                        
                        
                        
                        if([[self calculateTimer] isEqualToString:@""]){
                            
                            [Timer setText:@""];
                            
                        }
                        
                        else{
                            
                            
                            [Timer setText:[self calculateTimer]];
                            //  [Timer sizeToFit];
                        }
                        [view addSubview:Timer];
                        [Timer setTextColor:[UIColor darkGrayColor]];
                        
                    }
                    
                }
                
                NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[globalArray valueForKey:@"ImgIdf"] objectAtIndex:section],[[globalArray valueForKey:@"FolderPath"] objectAtIndex:section]];
                
                
                
                UIImageView *labelImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 40, 40)];
                
                [labelImage  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"imagesPerson.jpeg"]];
                
                labelImage.layer.cornerRadius = labelImage.frame.size.height /2;
                labelImage.layer.masksToBounds = YES;
                labelImage.layer.borderWidth = 0;
                
                
                
                [view addSubview:labelImage];
                
                
                [view addSubview:label];
                
                
                [view addSubview:button];
                
                
                [view setBackgroundColor:[UIColor whiteColor]]; //your background color...
                
                return view;
                
            }
        }
        else{
            
            
            if (screenWidthios ==320) {
                
                
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 14)];
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
                button.tag = section;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                
                button.backgroundColor = [UIColor clearColor];
                
                // Doing the Decoration Part
                view.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
                view.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
                view.layer.shadowRadius = 0.0f;
                view.layer.shadowOpacity = 0.1f;
                
                
                /* Create custom view to display section header... */
                
                UILabel *label;
                
                label = [[UILabel alloc] initWithFrame:CGRectMake(58, 12, 160, 18)];
                [label setFont:[UIFont boldSystemFontOfSize:14]];
                
                NSString *string =[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:section];
                
                
                NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[globalArray valueForKey:@"ImgIdf"] objectAtIndex:section],[[globalArray valueForKey:@"FolderPath"] objectAtIndex:section]];
                
                /* Section header is in 0th index... */
                [label setText:string];
                //  [label sizeToFit];
                [label setTextColor:[UIColor blackColor]];
                
                
                if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:section] integerValue]  == 0 ) {
                    
                    Timer = [[UILabel alloc] initWithFrame:CGRectMake(42, 14, 275, 18)];
                    [Timer setFont:[UIFont boldSystemFontOfSize:13]];
                    
                    
                    //                    Timer = [[UILabel alloc] initWithFrame:CGRectMake(_myTableView.frame.size.width - 120, 14, 120, 20)];
                    //                    [Timer setFont:[UIFont boldSystemFontOfSize:13]];
                    
                    
                    Timer.textAlignment = NSTextAlignmentRight;
                    
                    NSString *stringTimer =[[globalArray valueForKey:@"EndDate"] objectAtIndex:section];
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    NSString *xString = [splitString objectAtIndex:0];
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        
                        NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTime:%@", localTime);
                        
                        NSDateFormatter *dateFormatterCurrent=[[NSDateFormatter alloc] init];
                        [dateFormatterCurrent setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                        
                        
                        
                        NSString* localCurrentTime = [dateFormatterCurrent stringFromDate:[NSDate date]];
                        NSLog(@"current time :%@",localCurrentTime);
                        
                        NSTimeInterval diff = [tr timeIntervalSinceDate:[NSDate date]];
                        
                        NSLog(@"difffereeenceee %f",diff*1000 );
                        
                        valText = diff*1000;
                        
                        
                        
                        
                        if([[self calculateTimer] isEqualToString:@""]){
                            
                            [Timer setText:@""];
                        }
                        
                        else{
                            [Timer setText:[self calculateTimer]];
                            //  [Timer sizeToFit];
                        }
                        
                        /* Section header is in 0th index... */
                        
                        
                        [Timer setTextColor:[UIColor darkGrayColor]];
                        [view addSubview:Timer];
                        
                    }
                    
                }
                
                
                
                
                UILabel *labelSub = [[UILabel alloc] initWithFrame:CGRectMake(58, 28, 300, 18)];
                [labelSub setFont:[UIFont boldSystemFontOfSize:11]];
                
                
                //                NSString* rehey = [NSString stringWithFormat:@"has Re-HeyVoted %@'s post",[[globalArray valueForKey:@"ReHeyVoteUserName"] objectAtIndex:section]];
                
                NSString* rehey = [NSString stringWithFormat:@"has Re-HeyVoted the post"];
                
                /* Section header is in 0th index... */
                [labelSub setText:rehey];
                
                [labelSub setTextColor:[UIColor darkGrayColor]];
                
                
                
                UIImageView *labelImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 6, 40, 40)];
                
                [labelImage  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"imagesPerson.jpeg"]];
                
                labelImage.layer.cornerRadius = labelImage.frame.size.height /2;
                labelImage.layer.masksToBounds = YES;
                labelImage.layer.borderWidth = 0;
                
                
                [view addSubview:labelImage];
                
                
                [view addSubview:label];
                
                [view addSubview:labelSub];
                [view addSubview:button];
                
                
                [view setBackgroundColor:[UIColor whiteColor]]; //your background color...
                
                return view;
                
            }
            
            
            else{
                
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
                button.tag = section;
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                
                button.backgroundColor = [UIColor clearColor];
                
                // Doing the Decoration Part
                view.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
                view.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
                view.layer.shadowRadius = 0.0f;
                view.layer.shadowOpacity = 0.1f;
                
                
                /* Create custom view to display section header... */
                
                UILabel *label;
                label = [[UILabel alloc] initWithFrame:CGRectMake(58, 14, 200, 20)];
                [label setFont:[UIFont boldSystemFontOfSize:15]];
                NSString *string =[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:section];
                
                
                NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[globalArray valueForKey:@"ImgIdf"] objectAtIndex:section],[[globalArray valueForKey:@"FolderPath"] objectAtIndex:section]];
                
                /* Section header is in 0th index... */
                [label setText:string];
                //  [label sizeToFit];
                [label setTextColor:[UIColor blackColor]];
                
                
                if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:section] integerValue]  == 0 ) {
                    
                    Timer = [[UILabel alloc] initWithFrame:CGRectMake(_myTableView.frame.size.width - 120, 14, 120, 20)];
                    [Timer setFont:[UIFont boldSystemFontOfSize:14]];
                    
                    
                    Timer.textAlignment = NSTextAlignmentRight;
                    
                    NSString *stringTimer =[[globalArray valueForKey:@"EndDate"] objectAtIndex:section];
                    
                    
                    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
                    NSArray *splitString = [stringTimer componentsSeparatedByCharactersInSet:delimiters];
                    
                    NSString *xString = [splitString objectAtIndex:0];
                    NSString *yString = [splitString objectAtIndex:1];
                    
                    
                    
                    if ([yString containsString:@"-"]) {
                        
                        NSArray *arrrr = [yString componentsSeparatedByString:@"-"];
                        
                        
                        NSString* testOne = [arrrr objectAtIndex:0];
                        
                        
                        NSString* beforeConvert =[arrrr objectAtIndex:1];
                        
                        NSString*mystr=[beforeConvert substringToIndex:2];
                        
                        NSInteger multipliedVal = [mystr integerValue] * 3600000;
                        
                        NSString * finalVal = [NSString stringWithFormat:@"%ld",[testOne integerValue] - multipliedVal];
                        
                        
                        NSDate *tr = [NSDate dateWithTimeIntervalSince1970:[finalVal integerValue]/1000.0];
                        
                        
                        
                        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                        
                        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
                        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        
                        
                        NSString* localTime = [dateFormatter stringFromDate:tr];
                        
                        NSLog(@"localTime:%@", localTime);
                        
                        NSDateFormatter *dateFormatterCurrent=[[NSDateFormatter alloc] init];
                        [dateFormatterCurrent setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
                        // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
                        
                        
                        
                        NSString* localCurrentTime = [dateFormatterCurrent stringFromDate:[NSDate date]];
                        NSLog(@"current time :%@",localCurrentTime);
                        
                        NSTimeInterval diff = [tr timeIntervalSinceDate:[NSDate date]];
                        
                        NSLog(@"difffereeenceee %f",diff*1000 );
                        
                        valText = diff*1000;
                        
                        
                        if([[self calculateTimer] isEqualToString:@""]){
                            
                            [Timer setText:@""];
                        }
                        
                        else{
                            [Timer setText:[self calculateTimer]];
                            //  [Timer sizeToFit];
                        }
                        
                        /* Section header is in 0th index... */
                        
                        
                        [Timer setTextColor:[UIColor darkGrayColor]];
                        [view addSubview:Timer];
                        
                    }
                    
                }
                
                
                UILabel *labelSub = [[UILabel alloc] initWithFrame:CGRectMake(58, 32, 300, 20)];
                [labelSub setFont:[UIFont boldSystemFontOfSize:12]];
                
                
                //            NSString* rehey = [NSString stringWithFormat:@"has Re-HeyVoted %@'s post",[[globalArray valueForKey:@"ReHeyVoteUserName"] objectAtIndex:section]];
                
                NSString* rehey = [NSString stringWithFormat:@"has Re-HeyVoted the post"];
                
                /* Section header is in 0th index... */
                [labelSub setText:rehey];
                
                [labelSub setTextColor:[UIColor darkGrayColor]];
                
                
                
                UIImageView *labelImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 40, 40)];
                
                [labelImage  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"imagesPerson.jpeg"]];
                
                labelImage.layer.cornerRadius = labelImage.frame.size.height /2;
                labelImage.layer.masksToBounds = YES;
                labelImage.layer.borderWidth = 0;
                
                
                
                
                
                
                
                
                
                [view addSubview:labelImage];
                
                
                [view addSubview:label];
                
                [view addSubview:labelSub];
                [view addSubview:button];
                
                
                
                
                
                [view setBackgroundColor:[UIColor whiteColor]]; //your background color...
                
                return view;
                
            }
        }
        
    }
    
    
    
    return nil;
}


-(void)buttonAction:(id)sender{
    
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil || indexPath== nil)
    {
        
        commentViewVal = @"val";
        
        NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
        
        BOOL interNetCheck=[WebServiceUrl InternetCheck];
        if (interNetCheck==YES ) {
            
            UIView *newView = [[UIView alloc]init];
            newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            [self.view addSubview:newView];
            
            [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
            
            
            
            
            NSDictionary *jsonDictionary;
            
            if (indexPath !=nil) {
                
                jsonDictionary=@{
                                 @"contactToken":[[globalArray valueForKey:@"UserIdf"] objectAtIndex:indexPath.section],
                                 @"isWeb":@"false"                                           };
                
            }
            
            
            else{
                
                jsonDictionary=@{
                                 @"contactToken":[[globalArray valueForKey:@"UserIdf"] objectAtIndex:0],
                                 @"isWeb":@"false"                                           };
            }
            
            
            
            
            
            
            
            NSError *error;
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                
                                                               options:0
                                
                                                                 error:&error];
            
            NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
            
            NSLog(@"JSON OUTPUT: %@",JSONString);
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/viewprofileExternal_N4"]];
                
                
                
                [requestPost setHTTPMethod:@"POST"];
                
                
                
                [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                
                
                
                NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                
                
                
                [requestPost setHTTPBody: requestData];
                
                //  [requestPost addValue:@"hhhffftttuuu" forHTTPHeaderField:@"Value"];
                
                
                
                [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                
                // NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:requestPost delegate:self];
                
                [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    if (error) {
                        //do something with error
                        
                        [GMDCircleLoader hideFromView:newView animated:YES];
                        [newView removeFromSuperview];
                    } else {
                        
                        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        //            NSString *responseText = [[NSString alloc] initWithData:data encoding: NSASCIIStringEncoding];
                        //            NSString *newLineStr = @"\n";
                        //            responseText = [responseText stringByReplacingOccurrencesOfString:@"<br />" withString:newLineStr];
                        //
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            if (dic==nil) {
                                
                                
                                [GMDCircleLoader hideFromView:newView animated:YES];
                                [newView removeFromSuperview];
                                
                                
                            }
                            else{
                                
                                
                                NSLog(@"hjfshjfhs%@",dic);
                                
                                
                                
                                
                                NSMutableArray*arrayVal = [[NSMutableArray alloc]init];
                                
                                [arrayVal addObject:[dic valueForKey:@"ViewProfileExternal_N4Result"]];
                                
                                [GMDCircleLoader hideFromView:newView animated:YES];
                                [newView removeFromSuperview];
                                
                                
                                
                                
                                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                heyVoteProfileVC *myVC = (heyVoteProfileVC *)[storyboard instantiateViewControllerWithIdentifier:@"heyVoteProfileVC"];
                                myVC.profileArray = arrayVal;
                                
                                
                                if (indexPath !=nil) {
                                    
                                    myVC.contactToke = [[globalArray valueForKey:@"UserIdf"] objectAtIndex:indexPath.section];
                                    
                                }
                                
                                else{
                                    
                                    myVC.contactToke = [[globalArray valueForKey:@"UserIdf"] objectAtIndex:0];
                                    
                                }
                                
                                
                                [self PushAnimation];
                                [self.navigationController pushViewController:myVC animated:NO];
                                
                                
                            }
                            
                            
                            
                            
                        });
                    }
                }];
                
            });
        }
        
        else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            
        }
        
        
    }
    
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}

//-(CGFloat)tableView:(UITableView *)tableView
//estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (globalArray.count >0) {
        
        if (screenWidthios == 320) {
            return 50.0f;
        }
        else{
            
            return 60.0f;
        }
    }
    else{
        return 0.0f;
    }
    return 60.0f;
}

- (IBAction)homeButton:(id)sender {
}

- (IBAction)centerButton:(id)sender {
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CameraViewController *myVC = (CameraViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CameraViewController"];
    
    
    
    [self presentViewController:myVC animated:YES completion:nil];
    
}

- (IBAction)searchButton:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    searchTabViewController *myVC = (searchTabViewController *)[storyboard instantiateViewControllerWithIdentifier:@"searchTabViewController"];
    
    [self PushAnimation];
    [self.navigationController pushViewController:myVC animated:NO];
}

- (IBAction)profileButton:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    profileViewController *myVC = (profileViewController *)[storyboard instantiateViewControllerWithIdentifier:@"profileViewController"];
    
    [self PushAnimation];
    [self.navigationController pushViewController:myVC animated:NO];
    
    
}

- (IBAction)contactsButton:(id)sender {
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ContactsTabViewController *myVC = (ContactsTabViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ContactsTabViewController"];
    
    [self PushAnimation];
    [self.navigationController pushViewController:myVC animated:NO];
    
    
    
}

-(void)PushAnimation
{
    CATransition* transition = [CATransition animation];
    
    transition.duration = 0.0f;
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    
    transition.subtype = kCATransitionFromRight; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    
    
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
}




-(void)callWebServiceRefresh:(int)indexVal{
    
    
    BOOL interNetCheck=[WebServiceUrl InternetCheck];
    if (interNetCheck==YES ) {
        
        
        
        NSDictionary *jsonDictionary =@{
                                        
                                        @"isWeb":@"false",
                                        @"pageId":[NSNumber numberWithInt:indexVal],
                                        @"pageSize":[NSNumber numberWithInt:5],
                                        @"categoryId":[NSNumber numberWithInteger:categoryID],
                                        @"statusId":[NSNumber numberWithInteger:statusID]
                                        
                                        
                                        };
        
        
        
        
        
        
        NSError *error;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                            
                                                           options:0
                            
                                                             error:&error];
        
        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        
        NSLog(@"JSON OUTPUT: %@",JSONString);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/GetPostList_Z1"]];
            
            
            
            [requestPost setHTTPMethod:@"POST"];
            
            
            
            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
            
            
            
            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
            
            
            
            [requestPost setHTTPBody: requestData];
            
            //  [requestPost addValue:@"hhhffftttuuu" forHTTPHeaderField:@"Value"];
            
            
            
            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
            
            // NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:requestPost delegate:self];
            
            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if (error) {
                    //do something with error
                } else {
                    
                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    //            NSString *responseText = [[NSString alloc] initWithData:data encoding: NSASCIIStringEncoding];
                    //            NSString *newLineStr = @"\n";
                    //            responseText = [responseText stringByReplacingOccurrencesOfString:@"<br />" withString:newLineStr];
                    //
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (dic==nil) {
                            
                            [ _refreshControl endRefreshing];
                            
                            [_myTableView setUserInteractionEnabled:YES];
                            
                        }
                        else{
                            
                            [_myTableView setUserInteractionEnabled:YES];
                            NSLog(@"hjfshjfhs%@",dic);
                            
                            
                            if (indexVal == 0) {
                                globalArray = [[NSMutableArray alloc]init];
                            }
                            
                            
                            NSMutableArray* dataArray = [[NSMutableArray alloc]init];
                            
                            activepostArray = [[NSMutableArray alloc]init];
                            
                            
                            [dataArray addObjectsFromArray:[dic valueForKey:@"GetPostList_Z1Result"]];
                            
                            if (dataArray.count > 0) {
                                
                                [_noPostView setHidden:YES];
                                
                                
                                for(int i = 0 ; i<[dataArray count]; i++){
                                    
                                    if ([[[dataArray valueForKey:@"isDone"] objectAtIndex:i] integerValue]  == 0) {
                                        
                                        
                                        [activepostArray addObject:[dataArray objectAtIndex:i]];
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                                
                                
                                [globalArray addObjectsFromArray:activepostArray];
                                
                                [_myTableView reloadData];
                                
                            }
                            
                            
                            
                            [ _refreshControl endRefreshing];
                            
                            
                        }
                        
                        
                        
                        
                    });
                }
            }];
            
        });
    }
    
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        
    }
    
}




-(void)callWebService:(int)indexVal{
    
    
    BOOL interNetCheck=[WebServiceUrl InternetCheck];
    if (interNetCheck==YES) {
        
        //        UIView *newView = [[UIView alloc]init];
        //        newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        //        [self.view addSubview:newView];
        //
        //        [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
        //
        
        footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.navigationController.navigationBar.frame.size.height+10)];
        
        footerView.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        
        label.font = [UIFont fontWithName:@"Helvetica" size:14];
        
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        label.textColor = [UIColor darkGrayColor];
        CGSize labelSizeee = [footerLabel sizeThatFits:footerView.frame.size];
        [footerView addSubview:footerLabel];
        // set up activity indicator
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicatorView.hidesWhenStopped = YES;
        activityIndicatorView.color = [UIColor redColor];
        activityIndicator = activityIndicatorView;
        [activityIndicator startAnimating];
        
        activityIndicator.transform = CGAffineTransformMakeScale(1.2, 1.2);
        [footerView addSubview:activityIndicator];
        CGRect footerFrame = footerView.frame;
        label.frame = CGRectMake((footerFrame.size.width-labelSizeee.width - 4 - activityIndicatorView.frame.size.width)/2, (footerFrame.size.height-labelSizeee.height)/3 , (footerFrame.size.width-labelSizeee.width - 4 - activityIndicatorView.frame.size.width), labelSizeee.height);
        activityIndicator.frame = CGRectMake(label.frame.origin.x + labelSizeee.width + 4, (footerFrame.size.height-activityIndicatorView.frame.size.height)/2
                                             
                                             , activityIndicatorView.frame.size.width, activityIndicatorView.frame.size.height);
        
        
        _myTableView.tableFooterView = footerView;
        
        
        
        NSDictionary *jsonDictionary =@{
                                        
                                        @"isWeb":@"false",
                                        @"pageId":[NSNumber numberWithInt:indexVal],
                                        @"pageSize":[NSNumber numberWithInt:5],
                                        @"categoryId":[NSNumber numberWithInteger:categoryID],
                                        @"statusId":[NSNumber numberWithInteger:statusID]
                                        
                                        
                                        };
        
        
        
        
        
        
        NSError *error;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                            
                                                           options:0
                            
                                                             error:&error];
        
        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        
        NSLog(@"JSON OUTPUT: %@",JSONString);
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/GetPostList_Z1"]];
            
            
            
            [requestPost setHTTPMethod:@"POST"];
            
            
            
            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
            
            
            
            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
            
            
            
            [requestPost setHTTPBody: requestData];
            
            //  [requestPost addValue:@"hhhffftttuuu" forHTTPHeaderField:@"Value"];
            
            
            
            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
            
            // NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:requestPost delegate:self];
            
            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if (error) {
                    //do something with error
                } else {
                    
                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    //            NSString *responseText = [[NSString alloc] initWithData:data encoding: NSASCIIStringEncoding];
                    //            NSString *newLineStr = @"\n";
                    //            responseText = [responseText stringByReplacingOccurrencesOfString:@"<br />" withString:newLineStr];
                    //
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (dic==nil) {
                            
                            [ _refreshControl endRefreshing];
                            
                            //                        [GMDCircleLoader hideFromView:newView animated:YES];
                            //                        [newView removeFromSuperview];
                            //
                            [footerView removeFromSuperview];
                            [activityIndicator stopAnimating];
                            
                        }
                        else{
                            
                            NSLog(@"hjfshjfhs%@",dic);
                            [footerView removeFromSuperview];
                            [activityIndicator stopAnimating];
                            
                            if (indexVal == 0) {
                                globalArray = [[NSMutableArray alloc]init];
                            }
                            
                            
                            NSMutableArray* dataArray = [[NSMutableArray alloc]init];
                            
                            activepostArray = [[NSMutableArray alloc]init];
                            
                            
                            [dataArray addObjectsFromArray:[dic valueForKey:@"GetPostList_Z1Result"]];
                            
                            if (dataArray.count > 0) {
                                
                                [_noPostView setHidden:YES];
                                
                                
                                for(int i = 0 ; i<[dataArray count]; i++){
                                    
                                    if ([[[dataArray valueForKey:@"isDone"] objectAtIndex:i] integerValue]  == 0) {
                                        
                                        
                                        [activepostArray addObject:[dataArray objectAtIndex:i]];
                                        
                                    }
                                    
                                    
                                    
                                    
                                }
                                
                                
                             
                                
                                
                                [globalArray addObjectsFromArray:activepostArray];
                                
                             
                                
                                [_noPostView setHidden:YES];
                                
                                [_myTableView reloadData];
                                
                                
                                
                                
                                
                            }
                            
                            
                            if (indexVal == 0) {
                                
                                
                                if (globalArray.count == 0) {
                                    [_noPostView setHidden:YES];
                                }
                                
                                else{
                                    
                                    
                                    
                                    [_noPostView setHidden:YES];
                                }
                                
                            }
                            
                            
                            
                            [ _refreshControl endRefreshing];
                            
                            //                        [GMDCircleLoader hideFromView:newView animated:YES];
                            //                        [newView removeFromSuperview];
                            //
                            timerLoad = @"";
                            
                            
                            
                            
                        }
                        
                        
                        
                        
                    });
                    
                    
                    
                }
            }];
            
            
        });
    }
    
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        
    }
    
}



-(void)callNewUpdates: (NSTimer *) runningTimer{
    
    if (globalArray.count > 0) {
        
        
        
        NSMutableArray * newArrayyy = [[NSMutableArray alloc]init];
        
        [newArrayyy addObject:[globalArray objectAtIndex:0]];
        
        
        int newValUpdates = 0;
        BOOL interNetCheck=[WebServiceUrl InternetCheck];
        if (interNetCheck==YES ) {
            
            //        UIView *newView = [[UIView alloc]init];
            //        newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            //        [self.view addSubview:newView];
            //
            //        [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
            //
            
            
            
            NSDictionary *jsonDictionary =@{
                                            
                                            @"isWeb":@"false",
                                            @"pageId":[NSNumber numberWithInt:newValUpdates],
                                            @"pageSize":[NSNumber numberWithInt:5],
                                            @"categoryId":[NSNumber numberWithInteger:categoryID],
                                            @"statusId":[NSNumber numberWithInteger:statusID]
                                            
                                            
                                            };
            
            
            
            NSError *error;
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                
                                                               options:0
                                
                                                                 error:&error];
            
            NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
            
            NSLog(@"JSON OUTPUT: %@",JSONString);
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/GetPostList_Z1"]];
                
                
                
                [requestPost setHTTPMethod:@"POST"];
                
                
                
                [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                
                
                
                NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                
                
                
                [requestPost setHTTPBody: requestData];
                
                //  [requestPost addValue:@"hhhffftttuuu" forHTTPHeaderField:@"Value"];
                
                
                
                [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                
                // NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:requestPost delegate:self];
                
                [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    if (error) {
                        //do something with error
                    } else {
                        
                        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        //            NSString *responseText = [[NSString alloc] initWithData:data encoding: NSASCIIStringEncoding];
                        //            NSString *newLineStr = @"\n";
                        //            responseText = [responseText stringByReplacingOccurrencesOfString:@"<br />" withString:newLineStr];
                        //
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            if (dic==nil) {
                                
                                [ _refreshControl endRefreshing];
                                
                                //  [GMDCircleLoader hideFromView:newView animated:YES];
                                //  [newView removeFromSuperview];
                                
                            }
                            else{
                                
                                
                                NSLog(@"hjfshjfhs%@",dic);
                                
                                
                                if (newValUpdates == 0) {
                                    globalArray = [[NSMutableArray alloc]init];
                                }
                                
                                
                                NSMutableArray* dataArray = [[NSMutableArray alloc]init];
                                
                                NSMutableArray* secArray = [[NSMutableArray alloc]init];
                                
                                
                                [dataArray addObjectsFromArray:[dic valueForKey:@"GetPostList_Z1Result"]];
                                
                                if (dataArray.count > 0) {
                                    
                                    
                                    [globalArray addObjectsFromArray:dataArray];
                                    
                                    [_myTableView reloadData];
                                    
                                    [secArray addObject:[globalArray objectAtIndex:0]];
                                    
                                    
                                }
                                
                                
                                if ([newArrayyy isEqualToArray:secArray]) {
                                    
                                }
                                
                                else{
                                    [heyVoteUpdates setHidden:NO];
                                    
                                }
                                
                                
                                
                                [ _refreshControl endRefreshing];
                                
                                //  [GMDCircleLoader hideFromView:newView animated:YES];
                                // [newView removeFromSuperview];
                                
                                
                                
                                
                                
                                
                                
                            }
                            
                            
                            
                            
                        });
                    }
                }];
                
            });
        }
        
        else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            
        }
        
    }
    
}





-(void)callProfileView{
    
    
    BOOL interNetCheck=[WebServiceUrl InternetCheck];
    if (interNetCheck==YES ) {
        
        
        
        NSDictionary *jsonDictionary =@{
                                        
                                        @"isWeb":@"false",
                                        
                                        
                                        
                                        };
        
        
        
        
        
        
        NSError *error;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                            
                                                           options:0
                            
                                                             error:&error];
        
        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        
        NSLog(@"JSON OUTPUT: %@",JSONString);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/GetBasicProfileData_n1"]];
            
            
            [requestPost setHTTPMethod:@"POST"];
            
            
            
            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
            
            
            
            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
            
            
            
            [requestPost setHTTPBody: requestData];
            
            //  [requestPost addValue:@"hhhffftttuuu" forHTTPHeaderField:@"Value"];
            
            
            
            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
            
            // NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:requestPost delegate:self];
            
            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if (error) {
                    //do something with error
                } else {
                    
                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    //            NSString *responseText = [[NSString alloc] initWithData:data encoding: NSASCIIStringEncoding];
                    //            NSString *newLineStr = @"\n";
                    //            responseText = [responseText stringByReplacingOccurrencesOfString:@"<br />" withString:newLineStr];
                    //
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        if (dic==nil) {
                            
                            
                            
                        }
                        else{
                            
                            
                            NSLog(@"hjfshjfhs%@",dic);
                            
                            
                            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"basicInformation"];
                            
                            [[NSUserDefaults standardUserDefaults] synchronize];
                            
                            
                            [_qatarButton setTitle:[[[[[NSUserDefaults standardUserDefaults] objectForKey:@"basicInformation"] allObjects] valueForKey:@"Country"] objectAtIndex:0] forState:UIControlStateNormal];
                            
                            
                        }
                        
                        
                    });
                }
            }];
            
        });
    }
    
    else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                        message:@""
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        
    }
    
}




- (IBAction)homwSlider:(id)sender {
    
    if (_homeSlider.value>10 && _homeSlider.value<60) {
        [_globalButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_qatarButton setTitleColor:[UIColor colorWithRed:(212/255.f) green:(0/255.f) blue:(25/255.f) alpha:1] forState:UIControlStateNormal];
        [_privateButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _homeSlider.value = 50;
        
        categoryID = 1;
        
        
        if (_homeSlider.value == 50) {
            [self callWebService:0];
        }
        
        
        
    }
    
    else if (_homeSlider.value>60&& _homeSlider.value<100){
        [_globalButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_qatarButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_privateButton setTitleColor:[UIColor colorWithRed:(212/255.f) green:(0/255.f) blue:(25/255.f) alpha:1] forState:UIControlStateNormal];
        _homeSlider.value = 100;
        categoryID = 2;
        
        
        if (_homeSlider.value == 100) {
            [self callWebService:0];
        }
        
    }
    
    else if(_homeSlider.value <40){
        
        [_globalButton setTitleColor:[UIColor colorWithRed:(212/255.f) green:(0/255.f) blue:(25/255.f) alpha:1] forState:UIControlStateNormal];
        [_qatarButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_privateButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        _homeSlider.value = 0;
        
        categoryID = 0;
        
        
        if (_homeSlider.value == 0) {
            [self callWebService:0];
        }
        
    }
}

- (IBAction)globalButton:(id)sender {
    
    [_globalButton setTitleColor:[UIColor colorWithRed:(212/255.f) green:(0/255.f) blue:(25/255.f) alpha:1] forState:UIControlStateNormal];
    [_qatarButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_privateButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    _homeSlider.value = 0;
    
    categoryID = 0 ;
    
    [self callWebService:0];
}

- (IBAction)qatarButton:(id)sender {
    
    [_globalButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_qatarButton setTitleColor:[UIColor colorWithRed:(212/255.f) green:(0/255.f) blue:(25/255.f) alpha:1] forState:UIControlStateNormal];
    [_privateButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    _homeSlider.value = 50;
    
    categoryID = 2;
    
    [self callWebService:0];
}

- (IBAction)privateButton:(id)sender {
    [_globalButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_qatarButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_privateButton setTitleColor:[UIColor colorWithRed:(212/255.f) green:(0/255.f) blue:(25/255.f) alpha:1] forState:UIControlStateNormal];
    _homeSlider.value = 100;
    
    categoryID = 1;
    
    [self callWebService:0];
}



- (IBAction)homwSliderTwo:(id)sender {
    
    if (_homeSliderTwo.value>10 && _homeSliderTwo.value<60) {
        [_funButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_seriousButton setTitleColor:[UIColor colorWithRed:(212/255.f) green:(0/255.f) blue:(25/255.f) alpha:1] forState:UIControlStateNormal];
        [_generalButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _homeSliderTwo.value = 50;
        
        // categoryID = 1;
        
        statusID =2;
        
        if (_homeSliderTwo.value == 50) {
            [self callWebService:0];
        }
        
        
        
    }
    
    else if (_homeSliderTwo.value>60&& _homeSliderTwo.value<100){
        [_generalButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_seriousButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_funButton setTitleColor:[UIColor colorWithRed:(212/255.f) green:(0/255.f) blue:(25/255.f) alpha:1] forState:UIControlStateNormal];
        _homeSliderTwo.value = 100;
        //categoryID = 2;
        statusID =1;
        
        
        if (_homeSliderTwo.value == 100) {
            [self callWebService:0];
        }
        
    }
    
    else if(_homeSliderTwo.value <40){
        
        [_generalButton setTitleColor:[UIColor colorWithRed:(212/255.f) green:(0/255.f) blue:(25/255.f) alpha:1] forState:UIControlStateNormal];
        [_seriousButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_funButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
        _homeSliderTwo.value = 0;
        
        //  categoryID = 0;
        statusID = 0;
        
        
        if (_homeSliderTwo.value == 0) {
            [self callWebService:0];
        }
        
    }
}

- (IBAction)funButton:(id)sender {
    
    [_funButton setTitleColor:[UIColor colorWithRed:(212/255.f) green:(0/255.f) blue:(25/255.f) alpha:1] forState:UIControlStateNormal];
    [_seriousButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_generalButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    _homeSliderTwo.value = 100;
    
    statusID = 1 ;
    
    [self callWebService:0];
}

- (IBAction)seriousButton:(id)sender {
    
    [_funButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_seriousButton setTitleColor:[UIColor colorWithRed:(212/255.f) green:(0/255.f) blue:(25/255.f) alpha:1] forState:UIControlStateNormal];
    [_generalButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    _homeSliderTwo.value = 50;
    
    statusID = 2;
    
    [self callWebService:0];
}

- (IBAction)generalButton:(id)sender {
    [_funButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_seriousButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_generalButton setTitleColor:[UIColor colorWithRed:(212/255.f) green:(0/255.f) blue:(25/255.f) alpha:1] forState:UIControlStateNormal];
    _homeSliderTwo.value = 0;
    
    statusID = 0;
    
    [self callWebService:0];
}


- (IBAction)leftButton:(id)sender {
    
    // timerLoad = @"invalid";
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    
    
    if ([[[globalArray valueForKey:@"CanVote"] objectAtIndex:indexPath.section] integerValue] == 0) {
        [self showToast:@"You can't vote on this post"];
    }
    
    else{
        
        if (indexPath != nil)
        {
            [voteResultAraay addObject:[globalArray objectAtIndex:indexPath.section]];
            
            
            NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:indexPath.section] integerValue];
            
            NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
            if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                
                
                if ( [[[globalArray objectAtIndex:indexPath.section] valueForKey:@"hasVoted"] integerValue ]==0) {
                    
                    
                    
                    cell.leftButton.userInteractionEnabled = NO;
                    cell.rightButton.userInteractionEnabled = NO;
                    
                    
                    
                    [cell.leftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                        green:200.0f/255.0f
                                                                         blue:200.0f/255.0f
                                                                        alpha:1.0f]];
                    [cell.rightButton setBackgroundColor:[UIColor whiteColor]];
                    
                    if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1) {
                        
                        [cell.progresssView setHidden:NO];
                        
                        cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                  green:0.0f/255.0f
                                                                                   blue:20.0f/255.0f
                                                                                  alpha:0.7f];
                        cell.circularProgress.max = 1.0f;
                        cell.circularProgress.fillRadiusPx = 25;
                        cell.circularProgress.step = 0.1f;
                        cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                        cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        cell.circularProgress.outlineWidth = 1;
                        cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                        cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                        
                        
                        [[HKCircularProgressView appearance] setAnimationDuration:5];
                        
                        cell.circularProgress.alwaysDrawOutline = YES;
                        
                        
                        cell.insideProgress.fillRadius = 1;
                        cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                        cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        [cell.circularProgress setCurrent:testVa
                                                 animated:YES];
                        [cell.insideProgress setCurrent:1.0f
                                               animated:YES];
                        
                        
                    }
                    NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",cell.leftButton.currentTitle];
                    
                    cell.youHaveVotedLabel.text =uVoted;
                    
                    
                    NSInteger newVall = [cell.totalVotesLabel.text integerValue] + 1;
                    cell.totalVotesLabel.text = [NSString stringWithFormat:@"%ld HeyVotes",(long)newVall];
                    
                    
                    
                    if ([[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section] integerValue] == 2) {
                        
                        
                        BOOL interNetCheck=[WebServiceUrl InternetCheck];
                        if (interNetCheck==YES ) {
                            
                            
                            
                            
                            
                            NSString*uVoted = [NSString stringWithFormat:@"%@",cell.leftButton.currentTitle];
                            
                            NSString * commentAttrText = [[[[[NSUserDefaults standardUserDefaults] objectForKey:@"basicInformation"] allObjects] valueForKey:@"UserName"] objectAtIndex:0] ;
                            
                            NSString * combinedText = [NSString stringWithFormat:@"%@ %@",commentAttrText,uVoted];
                            
                            CGFloat boldTextFontSize = 12.0f;
                            
                            //  cell.commentAttributedLabel.text = combinedText;
                            
                            NSRange range1 = [combinedText rangeOfString:commentAttrText];
                            NSRange range2 = [combinedText rangeOfString:uVoted];
                            
                            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                            
                            
                            
                            [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                            
                            
                            
                            [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                                    range:range1];
                            
                            
                            
                            if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 0){
                                [self showToast:@"Please wait.."];
                                
                            }
                            
                            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 1)
                            {
                                cell.commentAttributedLabel.attributedText = attributedText;
                                
                            }
                            
                            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 2){
                                
                                cell.commentAttributedLabelTwo.attributedText = attributedText;
                            }
                            
                            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 3) {
                                
                                cell.commentAttributedLabelThree.attributedText = attributedText;
                                
                            }
                            
                            
                            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] > 3) {
                                
                                cell.commentAttributedLabelThree.attributedText = attributedText;
                            }
                            
                            
                            
                            NSDictionary *jsonDictionary =@{
                                                            
                                                            @"isWeb":@"false",
                                                            @"postId":[NSNumber numberWithInteger:[[[globalArray objectAtIndex:indexPath.section] valueForKey:@"Id"] integerValue]],
                                                            @"info":@{
                                                                    
                                                                    @"Comment":uVoted
                                                                    }
                                                            
                                                            };
                            
                            
                            
                            
                            NSError *error;
                            
                            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                
                                                                               options:0
                                                
                                                                                 error:&error];
                            
                            NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                            
                            NSLog(@"JSON OUTPUT: %@",JSONString);
                            
                            
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                
                                NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/addcomment"]];
                                
                                
                                
                                [requestPost setHTTPMethod:@"POST"];
                                
                                
                                
                                [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                                
                                
                                
                                NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                                
                                
                                
                                [requestPost setHTTPBody: requestData];
                                
                                
                                [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                                
                                
                                
                                [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                    if (error) {
                                        //do something with error
                                    } else {
                                        
                                        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            
                                            if (dic==nil) {
                                                
                                                
                                                //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                                //                                    [newView removeFromSuperview];
                                                
                                                
                                            }
                                            else{
                                                
                                                
                                                NSLog(@"hjfshjfhs%@",dic);
                                                
                                                
                                                //  [self callWebServiceRefresh:0];
                                                
                                                
                                                
                                                
                                                //
                                                //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                                //                                    [newView removeFromSuperview];
                                                
                                                
                                                
                                            }
                                            
                                            
                                            
                                        });
                                    }
                                }];
                                
                            });
                        }
                        
                        else{
                            
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                            message:@""
                                                                           delegate:self
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil];
                            [alert show];
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    BOOL interNetCheck=[WebServiceUrl InternetCheck];
                    if (interNetCheck==YES ) {
                        
                        
                        
                        
                        
                        //
                        //                    UIView *newView = [[UIView alloc]init];
                        //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                        //                    [self.view addSubview:newView];
                        //
                        //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                        //
                        
                        
                        
                        NSDictionary *jsonDictionary =@{
                                                        
                                                        @"isWeb":@"false",
                                                        @"voteOption":[NSNumber numberWithInteger:0],
                                                        @"postId":[NSNumber numberWithInteger:IDval]
                                                        
                                                        };
                        
                        
                        
                        
                        
                        
                        NSError *error;
                        
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                            
                                                                           options:0
                                            
                                                                             error:&error];
                        
                        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                        
                        NSLog(@"JSON OUTPUT: %@",JSONString);
                        
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            
                            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/Vote_Z1"]];
                            
                            
                            
                            [requestPost setHTTPMethod:@"POST"];
                            
                            
                            
                            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                            
                            
                            
                            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                            
                            
                            
                            [requestPost setHTTPBody: requestData];
                            
                            
                            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                            
                            
                            
                            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                if (error) {
                                    //do something with error
                                } else {
                                    
                                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if (dic==nil) {
                                            
                                            
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                        }
                                        else{
                                            
                                            
                                            NSLog(@"hjfshjfhs%@",dic);
                                            
                                            
                                            [self callWebServiceRefresh:0];
                                            voteResultVal = @"leftvoted";
                                            
                                            
                                            //
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                    });
                                }
                            }];
                            
                        });
                    }
                    
                    else{
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                        message:@""
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        
                        
                    }
                    
                    
                }
                
                //   [cell.yesNoMainView setHidden:YES];
                
                
                
                
            }
            
            
        }
    }
    
}

- (IBAction)rightButton:(id)sender {
    
    //  timerLoad = @"invalid";
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    
    if ([[[globalArray valueForKey:@"CanVote"] objectAtIndex:indexPath.section] integerValue] == 0) {
        [self showToast:@"You can't vote on this post"];
    }
    else{
        if (indexPath != nil)
        {
            [voteResultAraay addObject:[globalArray objectAtIndex:indexPath.section]];
            
            NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:indexPath.section] integerValue];
            
            NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
            if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                
                
                
                
                if ( [[[globalArray objectAtIndex:indexPath.section] valueForKey:@"hasVoted"] integerValue ]==0) {
                    
                    
                    
                    
                    cell.leftButton.userInteractionEnabled = NO;
                    cell.rightButton.userInteractionEnabled = NO;
                    
                    
                    
                    [cell.leftButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.rightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                         green:200.0f/255.0f
                                                                          blue:200.0f/255.0f
                                                                         alpha:1.0f]];
                    
                    if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1) {
                        [cell.progresssView setHidden:NO];
                        
                        cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                  green:0.0f/255.0f
                                                                                   blue:20.0f/255.0f
                                                                                  alpha:0.7f];
                        cell.circularProgress.max = 1.0f;
                        cell.circularProgress.fillRadiusPx = 25;
                        cell.circularProgress.step = 0.1f;
                        cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                        cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        cell.circularProgress.outlineWidth = 1;
                        cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                        cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                        
                        
                        [[HKCircularProgressView appearance] setAnimationDuration:5];
                        
                        cell.circularProgress.alwaysDrawOutline = YES;
                        
                        
                        cell.insideProgress.fillRadius = 1;
                        cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                        cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        [cell.circularProgress setCurrent:testVa
                                                 animated:YES];
                        [cell.insideProgress setCurrent:1.0f
                                               animated:YES];
                        
                    }
                    
                    NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",cell.rightButton.currentTitle];
                    
                    cell.youHaveVotedLabel.text =uVoted;
                    
                    
                    NSInteger newVall = [cell.totalVotesLabel.text integerValue] + 1;
                    cell.totalVotesLabel.text = [NSString stringWithFormat:@"%ld HeyVotes",(long)newVall];
                    
                    
                    
                    if ([[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section] integerValue] == 2) {
                        
                        
                        BOOL interNetCheck=[WebServiceUrl InternetCheck];
                        if (interNetCheck==YES ) {
                            
                            
                            
                            
                            
                            NSString*uVoted = [NSString stringWithFormat:@"%@",cell.rightButton.currentTitle];
                            
                            NSString * commentAttrText = [[[[[NSUserDefaults standardUserDefaults] objectForKey:@"basicInformation"] allObjects] valueForKey:@"UserName"] objectAtIndex:0] ;
                            
                            NSString * combinedText = [NSString stringWithFormat:@"%@ %@",commentAttrText,uVoted];
                            
                            CGFloat boldTextFontSize = 12.0f;
                            
                            //  cell.commentAttributedLabel.text = combinedText;
                            
                            NSRange range1 = [combinedText rangeOfString:commentAttrText];
                            NSRange range2 = [combinedText rangeOfString:uVoted];
                            
                            NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                            
                            
                            
                            [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                            
                            
                            
                            [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                                    range:range1];
                            
                            
                            
                            if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 0){
                                [self showToast:@"Please wait.."];
                                
                            }
                            
                            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 1)
                            {
                                cell.commentAttributedLabel.attributedText = attributedText;
                                
                            }
                            
                            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 2){
                                
                                cell.commentAttributedLabelTwo.attributedText = attributedText;
                            }
                            
                            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 3) {
                                
                                cell.commentAttributedLabelThree.attributedText = attributedText;
                                
                            }
                            
                            
                            else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] > 3) {
                                
                                cell.commentAttributedLabelThree.attributedText = attributedText;
                            }
                            
                            
                            
                            NSDictionary *jsonDictionary =@{
                                                            
                                                            @"isWeb":@"false",
                                                            @"postId":[NSNumber numberWithInteger:[[[globalArray objectAtIndex:indexPath.section] valueForKey:@"Id"] integerValue]],
                                                            @"info":@{
                                                                    
                                                                    @"Comment":uVoted
                                                                    }
                                                            
                                                            };
                            
                            
                            
                            
                            NSError *error;
                            
                            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                
                                                                               options:0
                                                
                                                                                 error:&error];
                            
                            NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                            
                            NSLog(@"JSON OUTPUT: %@",JSONString);
                            
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                
                                NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/addcomment"]];
                                
                                
                                
                                [requestPost setHTTPMethod:@"POST"];
                                
                                
                                
                                [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                                
                                
                                
                                NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                                
                                
                                
                                [requestPost setHTTPBody: requestData];
                                
                                
                                [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                                
                                
                                
                                [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                    if (error) {
                                        //do something with error
                                    } else {
                                        
                                        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            
                                            if (dic==nil) {
                                                
                                                
                                                //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                                //                                    [newView removeFromSuperview];
                                                
                                                
                                            }
                                            else{
                                                
                                                
                                                NSLog(@"hjfshjfhs%@",dic);
                                                
                                                
                                                // [self callWebServiceRefresh:0];
                                                
                                                
                                                
                                                
                                                //
                                                //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                                //                                    [newView removeFromSuperview];
                                                
                                                
                                                
                                            }
                                            
                                            
                                            
                                        });
                                    }
                                }];
                                
                            });
                        }
                        
                        else{
                            
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                            message:@""
                                                                           delegate:self
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil];
                            [alert show];
                            
                            
                        }
                        
                        
                        
                        
                    }
                    
                    
                    
                    BOOL interNetCheck=[WebServiceUrl InternetCheck];
                    if (interNetCheck==YES ) {
                        
                        
                        
                        
                        
                        //
                        //                    UIView *newView = [[UIView alloc]init];
                        //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                        //                    [self.view addSubview:newView];
                        //
                        //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                        //
                        
                        
                        
                        NSDictionary *jsonDictionary =@{
                                                        
                                                        @"isWeb":@"false",
                                                        @"voteOption":[NSNumber numberWithInteger:1],
                                                        @"postId":[NSNumber numberWithInteger:IDval]
                                                        
                                                        };
                        
                        
                        
                        
                        
                        
                        NSError *error;
                        
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                            
                                                                           options:0
                                            
                                                                             error:&error];
                        
                        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                        
                        NSLog(@"JSON OUTPUT: %@",JSONString);
                        
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            
                            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/Vote_Z1"]];
                            
                            
                            
                            [requestPost setHTTPMethod:@"POST"];
                            
                            
                            
                            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                            
                            
                            
                            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                            
                            
                            
                            [requestPost setHTTPBody: requestData];
                            
                            
                            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                            
                            
                            
                            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                if (error) {
                                    //do something with error
                                } else {
                                    
                                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if (dic==nil) {
                                            
                                            
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                        }
                                        else{
                                            
                                            
                                            NSLog(@"hjfshjfhs%@",dic);
                                            
                                            
                                            //
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            [self callWebServiceRefresh:0];
                                            voteResultVal = @"rightvoted";
                                            
                                        }
                                        
                                        
                                        
                                        
                                    });
                                }
                            }];
                            
                        });
                    }
                    
                    else{
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                        message:@""
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        
                        
                    }
                    
                    
                }
                
                //  [cell.yesNoMainView setHidden:YES];
                
                
            }
            
            
        }
        
    }
    
}

- (IBAction)showMoreComments:(id)sender {
    
    commentViewVal = @"val";
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil)
    {
        NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:indexPath.section] integerValue];
        NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
        
        
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CommentVC *myVC = (CommentVC *)[storyboard instantiateViewControllerWithIdentifier:@"CommentVC"];
        
        myVC.valueId = IDval;
        
        [self presentViewController:myVC animated:YES completion:nil];
        
        
        
        
        
    }
    
}

-(void)showToast:(NSString*)msg{
    
    [self.view makeToast:msg
                duration:1.0
                position:CSToastPositionCenter];
}


- (IBAction)reHeyVote:(id)sender {
    
    NSLog(@"reheyvote Clicked");
    
    
    
    NSString*stringVal = @"Re-HeyVote in progress...";
    [self showToast:stringVal];
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil)
    {
        NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:indexPath.section] integerValue];
        
        
        NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
        
        
        
        BOOL interNetCheck=[WebServiceUrl InternetCheck];
        if (interNetCheck==YES ) {
            //
            //                    UIView *newView = [[UIView alloc]init];
            //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            //                    [self.view addSubview:newView];
            //
            //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
            //
            
            
            
            NSDictionary *jsonDictionary =@{
                                            
                                            @"isWeb":@"false",
                                            @"postId":[NSNumber numberWithInteger:IDval]
                                            
                                            };
            
            
            
            
            
            
            NSError *error;
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                
                                                               options:0
                                
                                                                 error:&error];
            
            NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
            
            NSLog(@"JSON OUTPUT: %@",JSONString);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/ReHeyVote"]];
                
                
                
                [requestPost setHTTPMethod:@"POST"];
                
                
                
                [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                
                
                
                NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                
                
                
                [requestPost setHTTPBody: requestData];
                
                
                [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                
                
                
                [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    if (error) {
                        //do something with error
                    } else {
                        
                        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            if (dic==nil) {
                                
                                
                                //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                //                                    [newView removeFromSuperview];
                                
                                
                            }
                            else{
                                
                                
                                NSLog(@"hjfshjfhs%@",dic);
                                
                                NSString*stringValll = @"Re-HeyVoted successfully";
                                [self showToast:stringValll];
                                
                                
                                //
                                //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                //                                    [newView removeFromSuperview];
                                
                                
                                
                                
                            }
                            
                            
                            
                            
                        });
                    }
                }];
                
            });
        }
        
        else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            
            
        }
        
        
        
        
        
        
    }
    
}

- (IBAction)shareButton:(id)sender {
    
    timerLoad = @"invalid";
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil)
    {
        NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
        
        NSString*stringURl = [NSString stringWithFormat:@"https://www.heyvote.com/?share=%@",[[globalArray objectAtIndex:indexPath.section]valueForKey:@"PostToken"]];
        
        
        NSURL * strUrl = [NSURL URLWithString:stringURl];
        
        
        //   UIImage *imagetoshare = _img; //this is your image to share
        NSArray *activityItems = @[strUrl];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
        activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint];
        [self presentViewController:activityVC animated:TRUE completion:nil];
        
        
        
        
        
    }
    
}

- (IBAction)moreButton:(id)sender {
    timerLoad = @"invalid";
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil)
    {
        
        NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
        
        if ([[[globalArray valueForKey:@"CanDelete"] objectAtIndex:indexPath.section] integerValue] == 1) {
            
            
            
            if ([cell.deleteView isHidden]) {
                [cell.deleteView setHidden:NO];
                
                cell.deleteView.layer.shadowColor = [UIColor blackColor].CGColor;
                cell.deleteView.layer.shadowOffset = CGSizeMake(5, 5);
                cell.deleteView.layer.shadowOpacity = 0.5;
                cell.deleteView.layer.shadowRadius = 1.0;
                cell.deleteView.layer.cornerRadius = 5.0;
                
                cell.deleteView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     cell.deleteView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                                 } completion:^(BOOL finished) {
                                     
                                 }];
                
                
                
                
            }
            
            else{
                
                [cell.deleteView setHidden:YES];
                
                
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     cell.deleteView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                                 } completion:^(BOOL finished) {
                                     cell.deleteView.hidden = TRUE;
                                 }];
            }
            
            
            
            
            
        }
        
        else{
            
            
            if ([cell.moreButtonView isHidden]) {
                [cell.moreButtonView setHidden:NO];
                
                
                
                //                if ([[[[[[NSUserDefaults standardUserDefaults] objectForKey:@"basicInformation"] allObjects] valueForKey:@"isSpecial"] objectAtIndex:0] integerValue] == 1) {
                [cell.spamView setHidden:NO];
                
                
                
                cell.spamView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     cell.spamView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                                 } completion:^(BOOL finished) {
                                     
                                 }];
                
                //                }
                //
                //                else{
                //                     [cell.spamView setHidden:YES];
                //
                //                }
                
                
                
                cell.moreButtonView.layer.shadowColor = [UIColor blackColor].CGColor;
                cell.moreButtonView.layer.shadowOffset = CGSizeMake(5, 5);
                cell.moreButtonView.layer.shadowOpacity = 0.5;
                cell.moreButtonView.layer.shadowRadius = 1.0;
                cell.moreButtonView.layer.cornerRadius = 5.0;
                
                cell.moreButtonView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     cell.moreButtonView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                                 } completion:^(BOOL finished) {
                                     
                                 }];
                
                
                
                
            }
            
            else{
                
                [cell.moreButtonView setHidden:YES];
                [cell.spamView setHidden:YES];
                
                
                [UIView animateWithDuration:0.2
                                 animations:^{
                                     cell.moreButtonView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
                                 } completion:^(BOOL finished) {
                                     cell.moreButtonView.hidden = TRUE;
                                 }];
            }
            
            
            
            
        }
        
        
        
        
    }
    
}

- (IBAction)moreFollow:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil)
    {
        
        NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
        
        
        NSString * moreFollowString = [NSString stringWithFormat:@"Follow %@",[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:indexPath.section]];
        
        
        
        if ([cell.moreFollow.currentTitle isEqualToString:moreFollowString]) {
            followUnfolloww = @"unfollow";
            
            NSString * moreFollowStringg = [NSString stringWithFormat:@"Unfollow %@",[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:indexPath.section]];
            [cell.moreFollow setTitle:moreFollowStringg forState: UIControlStateNormal];
            
            
            BOOL interNetCheck=[WebServiceUrl InternetCheck];
            if (interNetCheck==YES ) {
                //
                //                    UIView *newView = [[UIView alloc]init];
                //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                //                    [self.view addSubview:newView];
                //
                //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                //
                
                
                
                NSDictionary *jsonDictionary =@{
                                                
                                                @"isWeb":@"false",
                                                @"follow":@"true",
                                                @"contactToken":[[globalArray valueForKey:@"Token"] objectAtIndex:indexPath.section]
                                                
                                                };
                
                
                
                
                
                
                NSError *error;
                
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                    
                                                                   options:0
                                    
                                                                     error:&error];
                
                NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                
                NSLog(@"JSON OUTPUT: %@",JSONString);
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/followunfollowuser"]];
                    
                    
                    
                    [requestPost setHTTPMethod:@"POST"];
                    
                    
                    
                    [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                    
                    
                    
                    NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                    
                    
                    
                    [requestPost setHTTPBody: requestData];
                    
                    
                    [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                    
                    
                    
                    [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                        if (error) {
                            //do something with error
                        } else {
                            
                            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                if (dic==nil) {
                                    
                                    
                                    //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                    //                                    [newView removeFromSuperview];
                                    
                                    
                                }
                                else{
                                    
                                    
                                    NSLog(@"hjfshjfhs%@",dic);
                                    
                                    
                                    
                                    
                                    //
                                    //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                    //                                    [newView removeFromSuperview];
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                                
                            });
                        }
                    }];
                    
                });
            }
            
            else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                message:@""
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                [cell.moreFollow setTitle:moreFollowString forState: UIControlStateNormal];
                
                
            }
            
            
            
        }
        
        else{
            
            followUnfolloww = @"follow";
            
            NSString * moreFollowStringg = [NSString stringWithFormat:@"Follow %@",[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:indexPath.section]];
            [cell.moreFollow setTitle:moreFollowStringg forState: UIControlStateNormal];
            
            
            
            
            {
                
                
                
                BOOL interNetCheck=[WebServiceUrl InternetCheck];
                if (interNetCheck==YES ) {
                    //
                    //                    UIView *newView = [[UIView alloc]init];
                    //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                    //                    [self.view addSubview:newView];
                    //
                    //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                    //
                    
                    
                    
                    NSDictionary *jsonDictionary =@{
                                                    
                                                    @"isWeb":@"false",
                                                    @"follow":@"false",
                                                    @"contactToken":[[globalArray valueForKey:@"Token"] objectAtIndex:indexPath.section]
                                                    
                                                    };
                    
                    
                    
                    
                    
                    
                    NSError *error;
                    
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                        
                                                                       options:0
                                        
                                                                         error:&error];
                    
                    NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                    
                    NSLog(@"JSON OUTPUT: %@",JSONString);
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/followunfollowuser"]];
                        
                        
                        
                        [requestPost setHTTPMethod:@"POST"];
                        
                        
                        
                        [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                        
                        
                        
                        NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                        
                        
                        
                        [requestPost setHTTPBody: requestData];
                        
                        
                        [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                        
                        
                        
                        [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                            if (error) {
                                //do something with error
                            } else {
                                
                                NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                    if (dic==nil) {
                                        
                                        
                                        //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                        //                                    [newView removeFromSuperview];
                                        
                                        
                                    }
                                    else{
                                        
                                        
                                        NSLog(@"hjfshjfhs%@",dic);
                                        
                                        
                                        
                                        
                                        //
                                        //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                        //                                    [newView removeFromSuperview];
                                        
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                });
                            }
                        }];
                        
                        
                    });
                }
                
                else{
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                    message:@""
                                                                   delegate:self
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                    NSString * moreFollowStringg = [NSString stringWithFormat:@"Unfollow %@",[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:indexPath.section]];
                    [cell.moreFollow setTitle:moreFollowStringg forState: UIControlStateNormal];
                }
                
                
                
            }
            
            
        }
        
        
        
    }
}

- (IBAction)moreBlock:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil)
    {
        
        NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
        
        
        NSString * moreFollowString = [NSString stringWithFormat:@"Block %@",[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:indexPath.section]];
        
        
        if ([cell.moreBlock.currentTitle isEqualToString:moreFollowString]) {
            
            
            blockUnblockk = @"unblock";
            
            
            NSString * moreFollowStringg = [NSString stringWithFormat:@"Unblock %@",[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:indexPath.section]];
            [cell.moreBlock setTitle:moreFollowStringg forState: UIControlStateNormal];
            
            
            
            BOOL interNetCheck=[WebServiceUrl InternetCheck];
            if (interNetCheck==YES ) {
                //
                //                    UIView *newView = [[UIView alloc]init];
                //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                //                    [self.view addSubview:newView];
                //
                //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                //
                
                
                
                NSDictionary *jsonDictionary =@{
                                                
                                                @"isWeb":@"false",
                                                @"allowed":[NSNumber numberWithInteger:0],
                                                @"contactToken":[[globalArray valueForKey:@"Token"] objectAtIndex:indexPath.section]
                                                
                                                };
                
                
                
                
                
                
                NSError *error;
                
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                    
                                                                   options:0
                                    
                                                                     error:&error];
                
                NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                
                NSLog(@"JSON OUTPUT: %@",JSONString);
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/blockunblockuser"]];
                    
                    
                    
                    [requestPost setHTTPMethod:@"POST"];
                    
                    
                    
                    [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                    
                    
                    
                    NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                    
                    
                    
                    [requestPost setHTTPBody: requestData];
                    
                    
                    [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                    
                    
                    
                    [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                        if (error) {
                            //do something with error
                        } else {
                            
                            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                if (dic==nil) {
                                    
                                    
                                    //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                    //                                    [newView removeFromSuperview];
                                    
                                    
                                }
                                else{
                                    
                                    
                                    NSLog(@"hjfshjfhs%@",dic);
                                    
                                    
                                    
                                    
                                    //
                                    //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                    //                                    [newView removeFromSuperview];
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                                
                            });
                        }
                    }];
                    
                });
            }
            
            else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                message:@""
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                NSString * moreFollowStringg = [NSString stringWithFormat:@"Block %@",[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:indexPath.section]];
                [cell.moreBlock setTitle:moreFollowStringg forState: UIControlStateNormal];
                
            }
            
            
            
            
            
        }
        
        else{
            
            
            blockUnblockk = @"block";
            
            NSString * moreFollowStringg = [NSString stringWithFormat:@"Block %@",[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:indexPath.section]];
            [cell.moreBlock setTitle:moreFollowStringg forState: UIControlStateNormal];
            
            
            BOOL interNetCheck=[WebServiceUrl InternetCheck];
            if (interNetCheck==YES ) {
                //
                //                    UIView *newView = [[UIView alloc]init];
                //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                //                    [self.view addSubview:newView];
                //
                //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                //
                
                
                
                NSDictionary *jsonDictionary =@{
                                                
                                                @"isWeb":@"false",
                                                @"allowed":[NSNumber numberWithInteger:1],
                                                @"contactToken":[[globalArray valueForKey:@"Token"] objectAtIndex:indexPath.section]
                                                
                                                };
                
                
                
                
                
                
                NSError *error;
                
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                    
                                                                   options:0
                                    
                                                                     error:&error];
                
                NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                
                NSLog(@"JSON OUTPUT: %@",JSONString);
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/blockunblockuser"]];
                    
                    
                    
                    [requestPost setHTTPMethod:@"POST"];
                    
                    
                    
                    [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                    
                    
                    
                    NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                    
                    
                    
                    [requestPost setHTTPBody: requestData];
                    
                    
                    [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                    
                    
                    
                    [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                        if (error) {
                            //do something with error
                        } else {
                            
                            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                if (dic==nil) {
                                    
                                    
                                    //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                    //                                    [newView removeFromSuperview];
                                    
                                    
                                }
                                else{
                                    
                                    
                                    NSLog(@"hjfshjfhs%@",dic);
                                    
                                    
                                    
                                    //
                                    //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                    //                                    [newView removeFromSuperview];
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                                
                            });
                        }
                    }];
                    
                });
            }
            
            else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                message:@""
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                NSString * moreFollowStringg = [NSString stringWithFormat:@"Unblock %@",[[globalArray valueForKey:@"UserDisplayName"] objectAtIndex:indexPath.section]];
                [cell.moreBlock setTitle:moreFollowStringg forState: UIControlStateNormal];
                
            }
            
        }
        
        
        
    }
}

- (IBAction)moreReport:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil)
    {
        
        NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
        
        
        BOOL interNetCheck=[WebServiceUrl InternetCheck];
        if (interNetCheck==YES ) {
            //
            //                    UIView *newView = [[UIView alloc]init];
            //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            //                    [self.view addSubview:newView];
            //
            //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
            //
            
            
            
            NSDictionary *jsonDictionary =@{
                                            
                                            @"isWeb":@"false",
                                            @"postId":[NSNumber numberWithInteger:[[[globalArray objectAtIndex:indexPath.section] valueForKey:@"Id"] integerValue]]
                                            
                                            };
            
            
            
            
            
            
            NSError *error;
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                
                                                               options:0
                                
                                                                 error:&error];
            
            NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
            
            NSLog(@"JSON OUTPUT: %@",JSONString);
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/SpamPost"]];
                
                
                
                [requestPost setHTTPMethod:@"POST"];
                
                
                
                [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                
                
                
                NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                
                
                
                [requestPost setHTTPBody: requestData];
                
                
                [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                
                
                
                [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    if (error) {
                        //do something with error
                    } else {
                        
                        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            if (dic==nil) {
                                
                                
                                //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                //                                    [newView removeFromSuperview];
                                
                                
                            }
                            else{
                                
                                
                                [self showToast:@"Reported Successfully"];
                                
                                NSLog(@"hjfshjfhs%@",dic);
                                
                                
                                
                                
                                //
                                //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                //                                    [newView removeFromSuperview];
                                
                                
                                
                                
                            }
                            
                            
                            
                            
                        });
                    }
                }];
                
            });
        }
        
        else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            
        }
        
        
        
        
        
        
        
    }
}


- (IBAction)commentSendButton:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    //    if ([[[globalArray valueForKey:@"CanVote"] objectAtIndex:indexPath.section] integerValue] == 0) {
    //        [self showToast:@"You can't comment on this post"];
    //    }
    //    else{
    
    if (indexPath != nil)
    {
        
        if ([cell.commentTextField.text length] == 0) {
            
        }
        
        else{
            
            
            BOOL interNetCheck=[WebServiceUrl InternetCheck];
            if (interNetCheck==YES ) {
                
                
                NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[[[[NSUserDefaults standardUserDefaults] objectForKey:@"basicInformation"] allObjects] valueForKey:@"ImageIdf"] objectAtIndex:0],[[[[[NSUserDefaults standardUserDefaults] objectForKey:@"basicInformation"] allObjects] valueForKey:@"FolderPath"] objectAtIndex:0]];
                NSString * commetAttrTextTwo = @"Just now";
                
                
                
                NSString * commentAttrText = [[[[[NSUserDefaults standardUserDefaults] objectForKey:@"basicInformation"] allObjects] valueForKey:@"UserName"] objectAtIndex:0] ;
                
                NSString * combinedText = [NSString stringWithFormat:@"%@ %@",commentAttrText,commetAttrTextTwo];
                
                
                
                CGFloat boldTextFontSize = 12.0f;
                
                CGFloat boldTextFontSizeee = 10.0f;
                
                //  cell.commentAttributedLabel.text = combinedText;
                
                NSRange range1 = [combinedText rangeOfString:commentAttrText];
                NSRange range2 = [combinedText rangeOfString:commetAttrTextTwo];
                
                NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:combinedText];
                
                
                NSDictionary *attrDict = @{
                                           NSFontAttributeName : [UIFont systemFontOfSize:boldTextFontSizeee],
                                           NSForegroundColorAttributeName : [UIColor darkGrayColor]
                                           };
                
                
                //  [attributedText addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range2];
                [attributedText setAttributes:attrDict  range:range2];
                
                
                [attributedText setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:boldTextFontSize]}
                                        range:range1];
                
                
                
                if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 0){
                    [self showToast:@"Posting your comment.."];
                    
                }
                
                else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 1)
                {
                    cell.commentAttributedLabel.attributedText = attributedText;
                    
                    cell.commentAttributedLabelFirst.text = cell.commentTextField.text;
                    
                    [cell.firsttImageButton  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"placeholderImage.png"]];
                    
                    
                    
                }
                
                else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 2){
                    
                    cell.commentAttributedLabelTwo.attributedText = attributedText;
                    cell.commentAttributedCellSecond.text = cell.commentTextField.text;
                    [cell.secondButtonImage  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"placeholderImage.png"]];
                }
                
                else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] == 3) {
                    
                    cell.commentAttributedLabelThree.attributedText = attributedText;
                    cell.commentAttributedCellThird.text = cell.commentTextField.text;
                    [cell.thirsButtonImage  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"placeholderImage.png"]];
                }
                
                
                else if ([[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] count] > 3) {
                    
                    cell.commentAttributedLabelThree.attributedText = attributedText;
                    cell.commentAttributedCellThird.text = cell.commentTextField.text;
                    [cell.thirsButtonImage  sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"placeholderImage.png"]];
                }
                
                
                
                
                
                
                
                
                
                
                NSDictionary *jsonDictionary =@{
                                                
                                                @"isWeb":@"false",
                                                @"postId":[NSNumber numberWithInteger:[[[globalArray objectAtIndex:indexPath.section] valueForKey:@"Id"] integerValue]],
                                                @"info":@{
                                                        
                                                        @"Comment":cell.commentTextField.text
                                                        }
                                                
                                                };
                
                
                cell.commentTextField.text = @"";
                
                NSError *error;
                
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                    
                                                                   options:0
                                    
                                                                     error:&error];
                
                NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                
                NSLog(@"JSON OUTPUT: %@",JSONString);
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/addcomment"]];
                    
                    
                    
                    [requestPost setHTTPMethod:@"POST"];
                    
                    
                    
                    [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                    
                    
                    
                    NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                    
                    
                    
                    [requestPost setHTTPBody: requestData];
                    
                    
                    [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                    
                    
                    
                    [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                        if (error) {
                            //do something with error
                        } else {
                            
                            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                if (dic==nil) {
                                    
                                    
                                    //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                    //                                    [newView removeFromSuperview];
                                    
                                    
                                }
                                else{
                                    
                                    
                                    NSLog(@"hjfshjfhs%@",dic);
                                    
                                    
                                    [self callWebServiceRefresh:0];
                                    
                                    
                                    
                                    
                                    //
                                    //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                    //                                    [newView removeFromSuperview];
                                    
                                    
                                    
                                }
                                
                                
                                
                            });
                        }
                    }];
                    
                });
            }
            
            else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                message:@""
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
                
            }
            
            
            
            
        }
        
        
    }
    
    //   }
    
}



- (IBAction)buttonOverImage:(id)sender {
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil)
    {
        if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 2) {
            
            if (cell.videoplayer.rate == 1.0 ) {
                [cell stopVideo];
            }
            
            else{
                [cell playVideo];
            }
            
            
        }
        
        
        else if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 3) {
            
            if (cell.audioplayer.rate == 1.0 ) {
                [cell stopAudio];
            }
            
            else{
                [cell playAudio];
            }
            
            
        }
        
        
        else{
            
            [_myTableView setUserInteractionEnabled:NO];
            _zoomImageView.image = cell.proImageView.image;
            [_zoomView setHidden:NO];
            
        }
    }
}

- (IBAction)doubleVoicePlayLeftButton:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    
    if (indexPath != nil)
    {
        NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/api/media/playaudio/%@/%@",[[globalArray valueForKey:@"Image1Idf"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"PostFolderPath"] objectAtIndex:indexPath.section]];
        
    }
}

- (IBAction)doubleVoicePlayRightButton:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    
    if (indexPath != nil)
    {
        NSString * imageString = [NSString stringWithFormat:@"https://www.heyvote.com/api/media/playaudio/%@/%@",[[globalArray valueForKey:@"Image2Idf"] objectAtIndex:indexPath.section],[[globalArray valueForKey:@"PostFolderPath"] objectAtIndex:indexPath.section]];
        
    }
    
}

- (IBAction)singleVoicePlayButton:(id)sender {
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil)
    {
        
        
    }
}


-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    NSLog(@"%@",error);
}

- (IBAction)deleteButton:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil)
    {
        
        
        
        NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
        
        
        BOOL interNetCheck=[WebServiceUrl InternetCheck];
        if (interNetCheck==YES ) {
            
            [self showToast:@"Deletion in progress.."];
            
            //
            //                    UIView *newView = [[UIView alloc]init];
            //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
            //                    [self.view addSubview:newView];
            //
            //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
            //
            
            
            
            NSDictionary *jsonDictionary =@{
                                            
                                            @"isWeb":@"false",
                                            @"postId":[NSNumber numberWithInteger:[[[globalArray objectAtIndex:indexPath.section] valueForKey:@"Id"] integerValue]]
                                            
                                            };
            
            
            
            
            
            
            NSError *error;
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                
                                                               options:0
                                
                                                                 error:&error];
            
            NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
            
            NSLog(@"JSON OUTPUT: %@",JSONString);
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/deletepost"]];
                
                
                
                [requestPost setHTTPMethod:@"POST"];
                
                
                
                [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                
                
                
                NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                
                
                
                [requestPost setHTTPBody: requestData];
                
                
                [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                
                
                
                [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    if (error) {
                        //do something with error
                    } else {
                        
                        NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            if (dic==nil) {
                                
                                
                                //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                //                                    [newView removeFromSuperview];
                                
                                
                            }
                            else{
                                
                                
                                
                                [globalArray removeObjectAtIndex:indexPath.section];
                                
                                [_myTableView reloadData];
                                
                                
                                [self showToast:@"Deleted Successfully"];
                                
                                NSLog(@"hjfshjfhs%@",dic);
                                
                                
                                
                                
                                //
                                //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                //                                    [newView removeFromSuperview];
                                
                                
                                
                                
                            }
                            
                            
                            
                            
                        });
                    }
                }];
                
            });
        }
        
        else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                            message:@""
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    
}

- (IBAction)firstCommentButton:(id)sender {
    
    commentViewVal = @"val";
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    if (indexPath != nil)
    {
        NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:indexPath.section] integerValue];
        NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
        
        NSInteger postTypeId = [[[globalArray valueForKey:@"PostTypeId"] objectAtIndex:indexPath.section] integerValue];
        
        
        
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CommentVC *myVC = (CommentVC *)[storyboard instantiateViewControllerWithIdentifier:@"CommentVC"];
        
        
        myVC.valueId = IDval;
        myVC.postId = postTypeId;
        [self presentViewController:myVC animated:YES completion:nil];
        
        
        
        
        
    }
    
}

- (IBAction)secondCommentButton:(id)sender {
    //
    //
    //    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    //    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    //    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    //    if (indexPath != nil)
    //    {
    //
    //        NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
    //
    //        BOOL interNetCheck=[WebServiceUrl InternetCheck];
    //        if (interNetCheck==YES ) {
    //
    //            UIView *newView = [[UIView alloc]init];
    //            newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    //            [self.view addSubview:newView];
    //
    //            [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
    //
    //
    //
    //
    //            NSDictionary *jsonDictionary =@{
    //                                            @"contactToken":[[[[[globalArray valueForKey:@"combo"] objectAtIndex:indexPath.section] valueForKey:@"lstComments"] valueForKey:@"Id"] objectAtIndex:1],
    //                                            @"isWeb":@"false"                                           };
    //
    //
    //
    //
    //
    //
    //            NSError *error;
    //
    //            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
    //
    //                                                               options:0
    //
    //                                                                 error:&error];
    //
    //            NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
    //
    //            NSLog(@"JSON OUTPUT: %@",JSONString);
    //
    //            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/viewprofileExternal"]];
    //
    //
    //
    //            [requestPost setHTTPMethod:@"POST"];
    //
    //
    //
    //            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
    //
    //
    //
    //            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    //
    //
    //
    //            [requestPost setHTTPBody: requestData];
    //
    //            //  [requestPost addValue:@"hhhffftttuuu" forHTTPHeaderField:@"Value"];
    //
    //
    //
    //            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
    //
    //            // NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:requestPost delegate:self];
    //
    //            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    //                if (error) {
    //                    //do something with error
    //                } else {
    //
    //                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //                    //            NSString *responseText = [[NSString alloc] initWithData:data encoding: NSASCIIStringEncoding];
    //                    //            NSString *newLineStr = @"\n";
    //                    //            responseText = [responseText stringByReplacingOccurrencesOfString:@"<br />" withString:newLineStr];
    //                    //
    //                    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //                        if (dic==nil) {
    //
    //
    //                            [GMDCircleLoader hideFromView:newView animated:YES];
    //                            [newView removeFromSuperview];
    //
    //
    //                        }
    //                        else{
    //
    //
    //                            NSLog(@"hjfshjfhs%@",dic);
    //
    //
    //
    //
    //                            NSMutableArray*arrayVal = [[NSMutableArray alloc]init];
    //
    //                            [arrayVal addObject:[dic valueForKey:@"ViewProfileExternalResult"]];
    //
    //                            [GMDCircleLoader hideFromView:newView animated:YES];
    //                            [newView removeFromSuperview];
    //
    //
    //
    //
    //                            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //                            heyVoteProfileVC *myVC = (heyVoteProfileVC *)[storyboard instantiateViewControllerWithIdentifier:@"heyVoteProfileVC"];
    //                            myVC.profileArray = arrayVal;
    //                            myVC.contactToke = [[globalArray valueForKey:@"Token"] objectAtIndex:indexPath.section];
    //                            [self PushAnimation];
    //                            [self.navigationController pushViewController:myVC animated:NO];
    //
    //
    //                        }
    //
    //
    //
    //
    //                    });
    //                }
    //            }];
    //        }
    //
    //        else{
    //
    //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
    //                                                            message:@""
    //                                                           delegate:self
    //                                                  cancelButtonTitle:@"OK"
    //                                                  otherButtonTitles:nil];
    //            [alert show];
    //
    //
    //        }
    //
    //
    //    }
    //
    //
    //
    //
    //
    //
}









- (IBAction)previewCloseButton:(id)sender {
    
    previewVal = @"";
    [_myTableView setUserInteractionEnabled:YES];
    
    [_myTableView reloadData];
    [_previewView setHidden:YES];
    
    arr = [[NSMutableArray alloc]init];
}
- (IBAction)previewLeftButton:(id)sender {
    
    
    NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:[[arr firstObject] section]] integerValue];
    
    
    if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:[[arr firstObject] section]] integerValue]  == 0) {
        
        
        
        
        if ( [[[globalArray objectAtIndex:[[arr firstObject] section]] valueForKey:@"hasVoted"] integerValue ]==0) {
            
            BOOL interNetCheck=[WebServiceUrl InternetCheck];
            if (interNetCheck==YES ) {
                //
                //                    UIView *newView = [[UIView alloc]init];
                //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                //                    [self.view addSubview:newView];
                //
                //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                //
                
                
                
                NSDictionary *jsonDictionary =@{
                                                
                                                @"isWeb":@"false",
                                                @"voteOption":@"false",
                                                @"postId":[NSNumber numberWithInteger:IDval]
                                                
                                                };
                
                
                
                
                
                
                NSError *error;
                
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                    
                                                                   options:0
                                    
                                                                     error:&error];
                
                NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                
                NSLog(@"JSON OUTPUT: %@",JSONString);
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/Vote_Z1"]];
                    
                    
                    
                    [requestPost setHTTPMethod:@"POST"];
                    
                    
                    
                    [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                    
                    
                    
                    NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                    
                    
                    
                    [requestPost setHTTPBody: requestData];
                    
                    
                    [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                    
                    
                    
                    [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                        if (error) {
                            //do something with error
                        } else {
                            
                            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                if (dic==nil) {
                                    
                                    
                                    //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                    //                                    [newView removeFromSuperview];
                                    
                                    
                                }
                                else{
                                    
                                    
                                    NSLog(@"hjfshjfhs%@",dic);
                                    
                                    
                                    
                                    voteResultVal = @"leftvoted";
                                    
                                    
                                    //
                                    //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                    //                                    [newView removeFromSuperview];
                                    
                                    
                                    
                                    
                                }
                                
                                
                                
                                
                            });
                        }
                    }];
                    
                });
            }
            
            else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                message:@""
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
                
            }
            
            
        }
        
        [_previewButtonView setHidden:YES];
        [_previewYouHaveVoted setHidden:NO];
        
        
        NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",_previewLeftButton.currentTitle];
        
        _previewYouVotedText.text =uVoted;
        
        
        
    }
    
    
}
- (IBAction)previewRightButton:(id)sender {
    
    
    NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:[[arr firstObject] section] ] integerValue];
    
    if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:[[arr firstObject] section]] integerValue]  == 0) {
        
        
        
        
        if ( [[[globalArray objectAtIndex:[[arr firstObject] section]] valueForKey:@"hasVoted"] integerValue ]==0) {
            
            BOOL interNetCheck=[WebServiceUrl InternetCheck];
            if (interNetCheck==YES ) {
                //
                //                    UIView *newView = [[UIView alloc]init];
                //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                //                    [self.view addSubview:newView];
                //
                //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                //
                
                
                
                NSDictionary *jsonDictionary =@{
                                                
                                                @"isWeb":@"false",
                                                @"voteOption":@"true",
                                                @"postId":[NSNumber numberWithInteger:IDval]
                                                
                                                };
                
                
                
                
                
                
                NSError *error;
                
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                    
                                                                   options:0
                                    
                                                                     error:&error];
                
                NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                
                NSLog(@"JSON OUTPUT: %@",JSONString);
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/Vote_Z1"]];
                    
                    
                    
                    [requestPost setHTTPMethod:@"POST"];
                    
                    
                    
                    [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                    
                    
                    
                    NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                    
                    
                    
                    [requestPost setHTTPBody: requestData];
                    
                    
                    [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                    
                    
                    
                    [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                        if (error) {
                            //do something with error
                        } else {
                            
                            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                if (dic==nil) {
                                    
                                    
                                    //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                    //                                    [newView removeFromSuperview];
                                    
                                    
                                }
                                else{
                                    
                                    
                                    NSLog(@"hjfshjfhs%@",dic);
                                    
                                    
                                    //
                                    //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                    //                                    [newView removeFromSuperview];
                                    
                                    
                                    voteResultVal = @"rightvoted";
                                    
                                }
                                
                                
                                
                                
                            });
                        }
                    }];
                    
                });
            }
            
            else{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                message:@""
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
                
            }
            
            
        }
        
        [_previewButtonView setHidden:YES];
        [_previewYouHaveVoted setHidden:NO];
        
        
        NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",_previewRightButton.currentTitle];
        
        _previewYouVotedText.text =uVoted;
        
        
    }
    
    
}




//ZOOM IMAGE VIEW INSIDE SCROLL VIEW


-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    
    
    CGSize boundsSize = _zoomView.bounds.size;
    CGRect contentsFrame = _zoomImageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    _zoomImageView.frame = contentsFrame;
    
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.zoomImageView;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
}


- (IBAction)zoomCloseButton:(id)sender {
    [_myTableView setUserInteractionEnabled:YES];
    [_zoomView setHidden:YES];
}
- (IBAction)CheckInButton:(id)sender {
}

- (IBAction)newHeyVotes:(id)sender {
    
    [heyVoteUpdates setHidden:YES];
    
    [_myTableView setContentOffset:CGPointZero animated:YES];
    
    
    if ([_secondHeader alpha] == 0.0f) {
        
        
        
        //fade in
        [UIView animateWithDuration:0.0f animations:^{
            _secondHeader.alpha = 1.0f;
            _headerView.alpha = 1.0f;
            _headerView.frame = HeaderRect;
            _myTableView.frame = tabRect;
            
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    
    
}

- (IBAction)threeVersusRightButton:(id)sender {
    
    // timerLoad = @"invalid";
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    
    
    if ([[[globalArray valueForKey:@"CanVote"] objectAtIndex:indexPath.section] integerValue] == 0) {
        [self showToast:@"You can't vote on this post"];
    }
    
    else{
        
        if (indexPath != nil)
        {
            [voteResultAraayThreeVersus addObject:[globalArray objectAtIndex:indexPath.section]];
            
            
            NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:indexPath.section] integerValue];
            
            //   NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
            if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                
                
                if ( [[[globalArray objectAtIndex:indexPath.section] valueForKey:@"hasVoted"] integerValue ]==0) {
                    
                    
                    
                    cell.threeVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                    cell.threeVersusFirstSecondRightButton.userInteractionEnabled = NO;
                    cell.threeVersusRightButton.userInteractionEnabled = NO;
                    
                    
                    
                    [cell.threeVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.threeVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.threeVersusRightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                    green:200.0f/255.0f
                                                                                     blue:200.0f/255.0f
                                                                                    alpha:1.0f]];
                    
                    if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1) {
                        
                        [cell.progresssView setHidden:NO];
                        
                        cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                  green:0.0f/255.0f
                                                                                   blue:20.0f/255.0f
                                                                                  alpha:0.7f];
                        cell.circularProgress.max = 1.0f;
                        cell.circularProgress.fillRadiusPx = 25;
                        cell.circularProgress.step = 0.1f;
                        cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                        cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        cell.circularProgress.outlineWidth = 1;
                        cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                        cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                        
                        
                        [[HKCircularProgressView appearance] setAnimationDuration:5];
                        
                        cell.circularProgress.alwaysDrawOutline = YES;
                        
                        
                        cell.insideProgress.fillRadius = 1;
                        cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                        cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        [cell.circularProgress setCurrent:testVa
                                                 animated:YES];
                        [cell.insideProgress setCurrent:1.0f
                                               animated:YES];
                        
                        
                    }
                    NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",cell.leftButton.currentTitle];
                    
                    cell.youHaveVotedLabel.text =uVoted;
                    
                    
                    NSInteger newVall = [cell.totalVotesLabel.text integerValue] + 1;
                    cell.totalVotesLabel.text = [NSString stringWithFormat:@"%ld HeyVotes",(long)newVall];
                    
                    
                    
                    
                    BOOL interNetCheck=[WebServiceUrl InternetCheck];
                    if (interNetCheck==YES ) {
                        
                        
                        
                        
                        
                        //
                        //                    UIView *newView = [[UIView alloc]init];
                        //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                        //                    [self.view addSubview:newView];
                        //
                        //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                        //
                        
                        
                        
                        NSDictionary *jsonDictionary =@{
                                                        
                                                        @"isWeb":@"false",
                                                        @"voteOption":[NSNumber numberWithInteger:2],
                                                        @"postId":[NSNumber numberWithInteger:IDval]
                                                        
                                                        };
                        
                        
                        
                        
                        
                        
                        NSError *error;
                        
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                            
                                                                           options:0
                                            
                                                                             error:&error];
                        
                        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                        
                        NSLog(@"JSON OUTPUT: %@",JSONString);
                        
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            
                            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/Vote_Z1"]];
                            
                            
                            
                            [requestPost setHTTPMethod:@"POST"];
                            
                            
                            
                            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                            
                            
                            
                            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                            
                            
                            
                            [requestPost setHTTPBody: requestData];
                            
                            
                            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                            
                            
                            
                            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                if (error) {
                                    //do something with error
                                } else {
                                    
                                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if (dic==nil) {
                                            
                                            
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                        }
                                        else{
                                            
                                            
                                            NSLog(@"hjfshjfhs%@",dic);
                                            
                                            
                                            [self callWebServiceRefresh:0];
                                            voteResultValThreeVersus = @"downvoted";
                                            
                                            
                                            //
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                    });
                                }
                            }];
                            
                        });
                    }
                    
                    else{
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                        message:@""
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        
                        
                    }
                    
                    
                }
                
                //   [cell.yesNoMainView setHidden:YES];
                
                
                
                
            }
            
            
        }
    }
    
}

- (IBAction)threeVersusRightResultButton:(id)sender {
}

- (IBAction)threeVersusFirstSecondLeftButton:(id)sender {
    
    // timerLoad = @"invalid";
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    
    
    if ([[[globalArray valueForKey:@"CanVote"] objectAtIndex:indexPath.section] integerValue] == 0) {
        [self showToast:@"You can't vote on this post"];
    }
    
    else{
        
        if (indexPath != nil)
        {
            [voteResultAraayThreeVersus addObject:[globalArray objectAtIndex:indexPath.section]];
            
            
            NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:indexPath.section] integerValue];
            
            NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
            if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                
                
                if ( [[[globalArray objectAtIndex:indexPath.section] valueForKey:@"hasVoted"] integerValue ]==0) {
                    
                    
                    
                    cell.threeVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                    cell.threeVersusFirstSecondRightButton.userInteractionEnabled = NO;
                    cell.threeVersusRightButton.userInteractionEnabled = NO;
                    
                    
                    
                    [cell.threeVersusFirstSecondLeftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                              green:200.0f/255.0f
                                                                                               blue:200.0f/255.0f
                                                                                              alpha:1.0f]];
                    [cell.threeVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.threeVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                    
                    if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1) {
                        
                        [cell.progresssView setHidden:NO];
                        
                        cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                  green:0.0f/255.0f
                                                                                   blue:20.0f/255.0f
                                                                                  alpha:0.7f];
                        cell.circularProgress.max = 1.0f;
                        cell.circularProgress.fillRadiusPx = 25;
                        cell.circularProgress.step = 0.1f;
                        cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                        cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        cell.circularProgress.outlineWidth = 1;
                        cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                        cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                        
                        
                        [[HKCircularProgressView appearance] setAnimationDuration:5];
                        
                        cell.circularProgress.alwaysDrawOutline = YES;
                        
                        
                        cell.insideProgress.fillRadius = 1;
                        cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                        cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        [cell.circularProgress setCurrent:testVa
                                                 animated:YES];
                        [cell.insideProgress setCurrent:1.0f
                                               animated:YES];
                        
                        
                    }
                    NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",cell.leftButton.currentTitle];
                    
                    cell.youHaveVotedLabel.text =uVoted;
                    
                    
                    NSInteger newVall = [cell.totalVotesLabel.text integerValue] + 1;
                    cell.totalVotesLabel.text = [NSString stringWithFormat:@"%ld HeyVotes",(long)newVall];
                    
                    
                    
                    
                    BOOL interNetCheck=[WebServiceUrl InternetCheck];
                    if (interNetCheck==YES ) {
                        
                        
                        
                        
                        
                        //
                        //                    UIView *newView = [[UIView alloc]init];
                        //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                        //                    [self.view addSubview:newView];
                        //
                        //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                        //
                        
                        
                        
                        NSDictionary *jsonDictionary =@{
                                                        
                                                        @"isWeb":@"false",
                                                        @"voteOption":[NSNumber numberWithInteger:0],
                                                        @"postId":[NSNumber numberWithInteger:IDval]
                                                        
                                                        };
                        
                        
                        
                        
                        
                        
                        NSError *error;
                        
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                            
                                                                           options:0
                                            
                                                                             error:&error];
                        
                        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                        
                        NSLog(@"JSON OUTPUT: %@",JSONString);
                        
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            
                            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/Vote_Z1"]];
                            
                            
                            
                            [requestPost setHTTPMethod:@"POST"];
                            
                            
                            
                            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                            
                            
                            
                            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                            
                            
                            
                            [requestPost setHTTPBody: requestData];
                            
                            
                            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                            
                            
                            
                            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                if (error) {
                                    //do something with error
                                } else {
                                    
                                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if (dic==nil) {
                                            
                                            
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                        }
                                        else{
                                            
                                            
                                            NSLog(@"hjfshjfhs%@",dic);
                                            
                                            
                                            [self callWebServiceRefresh:0];
                                            voteResultValThreeVersus = @"leftvoted";
                                            
                                            
                                            //
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                    });
                                }
                            }];
                            
                        });
                    }
                    
                    else{
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                        message:@""
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        
                        
                    }
                    
                    
                }
                
                //   [cell.yesNoMainView setHidden:YES];
                
                
                
                
            }
            
            
        }
    }
    
}

- (IBAction)threeVersusFirstSecondRightButton:(id)sender {
    
    // timerLoad = @"invalid";
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    
    
    if ([[[globalArray valueForKey:@"CanVote"] objectAtIndex:indexPath.section] integerValue] == 0) {
        [self showToast:@"You can't vote on this post"];
    }
    
    else{
        
        if (indexPath != nil)
        {
            [voteResultAraayThreeVersus addObject:[globalArray objectAtIndex:indexPath.section]];
            
            
            NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:indexPath.section] integerValue];
            
            NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
            if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                
                
                if ( [[[globalArray objectAtIndex:indexPath.section] valueForKey:@"hasVoted"] integerValue ]==0) {
                    
                    
                    
                    cell.threeVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                    cell.threeVersusFirstSecondRightButton.userInteractionEnabled = NO;
                    cell.threeVersusRightButton.userInteractionEnabled = NO;
                    
                    
                    
                    [cell.threeVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.threeVersusFirstSecondRightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                               green:200.0f/255.0f
                                                                                                blue:200.0f/255.0f
                                                                                               alpha:1.0f]];
                    [cell.threeVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                    
                    if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1) {
                        
                        [cell.progresssView setHidden:NO];
                        
                        cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                  green:0.0f/255.0f
                                                                                   blue:20.0f/255.0f
                                                                                  alpha:0.7f];
                        cell.circularProgress.max = 1.0f;
                        cell.circularProgress.fillRadiusPx = 25;
                        cell.circularProgress.step = 0.1f;
                        cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                        cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        cell.circularProgress.outlineWidth = 1;
                        cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                        cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                        
                        
                        [[HKCircularProgressView appearance] setAnimationDuration:5];
                        
                        cell.circularProgress.alwaysDrawOutline = YES;
                        
                        
                        cell.insideProgress.fillRadius = 1;
                        cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                        cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        [cell.circularProgress setCurrent:testVa
                                                 animated:YES];
                        [cell.insideProgress setCurrent:1.0f
                                               animated:YES];
                        
                        
                    }
                    NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",cell.leftButton.currentTitle];
                    
                    cell.youHaveVotedLabel.text =uVoted;
                    
                    
                    NSInteger newVall = [cell.totalVotesLabel.text integerValue] + 1;
                    cell.totalVotesLabel.text = [NSString stringWithFormat:@"%ld HeyVotes",(long)newVall];
                    
                    
                    
                    
                    
                    BOOL interNetCheck=[WebServiceUrl InternetCheck];
                    if (interNetCheck==YES ) {
                        
                        
                        
                        
                        
                        //
                        //                    UIView *newView = [[UIView alloc]init];
                        //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                        //                    [self.view addSubview:newView];
                        //
                        //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                        //
                        
                        
                        
                        NSDictionary *jsonDictionary =@{
                                                        
                                                        @"isWeb":@"false",
                                                        @"voteOption":[NSNumber numberWithInteger:1],
                                                        @"postId":[NSNumber numberWithInteger:IDval]
                                                        
                                                        };
                        
                        
                        
                        
                        
                        
                        NSError *error;
                        
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                            
                                                                           options:0
                                            
                                                                             error:&error];
                        
                        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                        
                        NSLog(@"JSON OUTPUT: %@",JSONString);
                        
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            
                            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/Vote_Z1"]];
                            
                            
                            
                            [requestPost setHTTPMethod:@"POST"];
                            
                            
                            
                            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                            
                            
                            
                            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                            
                            
                            
                            [requestPost setHTTPBody: requestData];
                            
                            
                            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                            
                            
                            
                            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                if (error) {
                                    //do something with error
                                } else {
                                    
                                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if (dic==nil) {
                                            
                                            
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                        }
                                        else{
                                            
                                            
                                            NSLog(@"hjfshjfhs%@",dic);
                                            
                                            
                                            [self callWebServiceRefresh:0];
                                            voteResultValThreeVersus = @"rightvoted";
                                            
                                            
                                            //
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                    });
                                }
                            }];
                            
                        });
                    }
                    
                    else{
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                        message:@""
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        
                        
                    }
                    
                    
                }
                
                //   [cell.yesNoMainView setHidden:YES];
                
                
                
                
            }
            
            
        }
    }
    
}

- (IBAction)threeVersusFinalLeftButton:(id)sender {
}

- (IBAction)threeVersusFinalRightButton:(id)sender {
}

- (IBAction)fourVersusFirstSecondLeftButton:(id)sender {
    
    // timerLoad = @"invalid";
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    
    
    if ([[[globalArray valueForKey:@"CanVote"] objectAtIndex:indexPath.section] integerValue] == 0) {
        [self showToast:@"You can't vote on this post"];
    }
    
    else{
        
        if (indexPath != nil)
        {
            [voteResultAraayFourVersus addObject:[globalArray objectAtIndex:indexPath.section]];
            
            
            NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:indexPath.section] integerValue];
            
            NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
            if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                
                
                if ( [[[globalArray objectAtIndex:indexPath.section] valueForKey:@"hasVoted"] integerValue ]==0) {
                    
                    
                    
                    cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                    cell.fourVersusFirstSecondRightButton.userInteractionEnabled = NO;
                    cell.fourVersusLeftButton.userInteractionEnabled = NO;
                    cell.fourVersusRightButton.userInteractionEnabled = NO;
                    
                    
                    
                    [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                             green:200.0f/255.0f
                                                                                              blue:200.0f/255.0f
                                                                                             alpha:1.0f]];
                    [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.fourVersusLeftButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.fourVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                    
                    if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1) {
                        
                        [cell.progresssView setHidden:NO];
                        
                        cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                  green:0.0f/255.0f
                                                                                   blue:20.0f/255.0f
                                                                                  alpha:0.7f];
                        cell.circularProgress.max = 1.0f;
                        cell.circularProgress.fillRadiusPx = 25;
                        cell.circularProgress.step = 0.1f;
                        cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                        cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        cell.circularProgress.outlineWidth = 1;
                        cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                        cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                        
                        
                        [[HKCircularProgressView appearance] setAnimationDuration:5];
                        
                        cell.circularProgress.alwaysDrawOutline = YES;
                        
                        
                        cell.insideProgress.fillRadius = 1;
                        cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                        cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        [cell.circularProgress setCurrent:testVa
                                                 animated:YES];
                        [cell.insideProgress setCurrent:1.0f
                                               animated:YES];
                        
                        
                    }
                    NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",cell.leftButton.currentTitle];
                    
                    cell.youHaveVotedLabel.text =uVoted;
                    
                    
                    NSInteger newVall = [cell.totalVotesLabel.text integerValue] + 1;
                    cell.totalVotesLabel.text = [NSString stringWithFormat:@"%ld HeyVotes",(long)newVall];
                    
                    
                    
                    
                    BOOL interNetCheck=[WebServiceUrl InternetCheck];
                    if (interNetCheck==YES ) {
                        
                        
                        
                        
                        
                        //
                        //                    UIView *newView = [[UIView alloc]init];
                        //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                        //                    [self.view addSubview:newView];
                        //
                        //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                        //
                        
                        
                        
                        NSDictionary *jsonDictionary =@{
                                                        
                                                        @"isWeb":@"false",
                                                        @"voteOption":[NSNumber numberWithInteger:0],
                                                        @"postId":[NSNumber numberWithInteger:IDval]
                                                        
                                                        };
                        
                        
                        
                        
                        
                        
                        NSError *error;
                        
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                            
                                                                           options:0
                                            
                                                                             error:&error];
                        
                        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                        
                        NSLog(@"JSON OUTPUT: %@",JSONString);
                        
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            
                            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/Vote_Z1"]];
                            
                            
                            
                            [requestPost setHTTPMethod:@"POST"];
                            
                            
                            
                            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                            
                            
                            
                            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                            
                            
                            
                            [requestPost setHTTPBody: requestData];
                            
                            
                            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                            
                            
                            
                            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                if (error) {
                                    //do something with error
                                } else {
                                    
                                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if (dic==nil) {
                                            
                                            
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                        }
                                        else{
                                            
                                            
                                            NSLog(@"hjfshjfhs%@",dic);
                                            
                                            
                                            [self callWebServiceRefresh:0];
                                            voteResultValFourVersus = @"leftvoted";
                                            
                                            
                                            //
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                    });
                                }
                            }];
                            
                        });
                    }
                    
                    else{
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                        message:@""
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        
                        
                    }
                    
                    
                }
                
                //   [cell.yesNoMainView setHidden:YES];
                
                
                
                
            }
            
            
        }
    }
    
}

- (IBAction)fourVersusFirstSecondRightButton:(id)sender {
    
    // timerLoad = @"invalid";
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    
    
    if ([[[globalArray valueForKey:@"CanVote"] objectAtIndex:indexPath.section] integerValue] == 0) {
        [self showToast:@"You can't vote on this post"];
    }
    
    else{
        
        if (indexPath != nil)
        {
            [voteResultAraayFourVersus addObject:[globalArray objectAtIndex:indexPath.section]];
            
            
            NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:indexPath.section] integerValue];
            
            NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
            if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                
                
                if ( [[[globalArray objectAtIndex:indexPath.section] valueForKey:@"hasVoted"] integerValue ]==0) {
                    
                    
                    
                    cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                    cell.fourVersusFirstSecondRightButton.userInteractionEnabled = NO;
                    cell.fourVersusLeftButton.userInteractionEnabled = NO;
                    cell.fourVersusRightButton.userInteractionEnabled = NO;
                    
                    
                    
                    [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                              green:200.0f/255.0f
                                                                                               blue:200.0f/255.0f
                                                                                              alpha:1.0f]];
                    [cell.fourVersusLeftButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.fourVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                    
                    if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1) {
                        
                        [cell.progresssView setHidden:NO];
                        
                        cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                  green:0.0f/255.0f
                                                                                   blue:20.0f/255.0f
                                                                                  alpha:0.7f];
                        cell.circularProgress.max = 1.0f;
                        cell.circularProgress.fillRadiusPx = 25;
                        cell.circularProgress.step = 0.1f;
                        cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                        cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        cell.circularProgress.outlineWidth = 1;
                        cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                        cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                        
                        
                        [[HKCircularProgressView appearance] setAnimationDuration:5];
                        
                        cell.circularProgress.alwaysDrawOutline = YES;
                        
                        
                        cell.insideProgress.fillRadius = 1;
                        cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                        cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        [cell.circularProgress setCurrent:testVa
                                                 animated:YES];
                        [cell.insideProgress setCurrent:1.0f
                                               animated:YES];
                        
                        
                    }
                    NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",cell.leftButton.currentTitle];
                    
                    cell.youHaveVotedLabel.text =uVoted;
                    
                    
                    NSInteger newVall = [cell.totalVotesLabel.text integerValue] + 1;
                    cell.totalVotesLabel.text = [NSString stringWithFormat:@"%ld HeyVotes",(long)newVall];
                    
                    
                    
                    
                    BOOL interNetCheck=[WebServiceUrl InternetCheck];
                    if (interNetCheck==YES ) {
                        
                        
                        
                        
                        
                        //
                        //                    UIView *newView = [[UIView alloc]init];
                        //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                        //                    [self.view addSubview:newView];
                        //
                        //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                        //
                        
                        
                        
                        NSDictionary *jsonDictionary =@{
                                                        
                                                        @"isWeb":@"false",
                                                        @"voteOption":[NSNumber numberWithInteger:1],
                                                        @"postId":[NSNumber numberWithInteger:IDval]
                                                        
                                                        };
                        
                        
                        
                        
                        
                        
                        NSError *error;
                        
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                            
                                                                           options:0
                                            
                                                                             error:&error];
                        
                        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                        
                        NSLog(@"JSON OUTPUT: %@",JSONString);
                        
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            
                            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/Vote_Z1"]];
                            
                            
                            
                            [requestPost setHTTPMethod:@"POST"];
                            
                            
                            
                            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                            
                            
                            
                            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                            
                            
                            
                            [requestPost setHTTPBody: requestData];
                            
                            
                            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                            
                            
                            
                            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                if (error) {
                                    //do something with error
                                } else {
                                    
                                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if (dic==nil) {
                                            
                                            
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                        }
                                        else{
                                            
                                            
                                            NSLog(@"hjfshjfhs%@",dic);
                                            
                                            
                                            [self callWebServiceRefresh:0];
                                            voteResultValFourVersus = @"rightvoted";
                                            
                                            
                                            //
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                    });
                                }
                            }];
                            
                        });
                    }
                    
                    else{
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                        message:@""
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        
                        
                    }
                    
                    
                }
                
                //   [cell.yesNoMainView setHidden:YES];
                
                
                
                
            }
            
            
        }
    }
    
}

- (IBAction)fourVersusLeftButton:(id)sender {
    
    // timerLoad = @"invalid";
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    
    
    if ([[[globalArray valueForKey:@"CanVote"] objectAtIndex:indexPath.section] integerValue] == 0) {
        [self showToast:@"You can't vote on this post"];
    }
    
    else{
        
        if (indexPath != nil)
        {
            [voteResultAraayFourVersus addObject:[globalArray objectAtIndex:indexPath.section]];
            
            
            NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:indexPath.section] integerValue];
            
            NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
            if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                
                
                if ( [[[globalArray objectAtIndex:indexPath.section] valueForKey:@"hasVoted"] integerValue ]==0) {
                    
                    
                    
                    cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                    cell.fourVersusFirstSecondRightButton.userInteractionEnabled = NO;
                    cell.fourVersusLeftButton.userInteractionEnabled = NO;
                    cell.fourVersusRightButton.userInteractionEnabled = NO;
                    
                    
                    
                    [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.fourVersusLeftButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                  green:200.0f/255.0f
                                                                                   blue:200.0f/255.0f
                                                                                  alpha:1.0f]];
                    [cell.fourVersusRightButton setBackgroundColor:[UIColor whiteColor]];
                    
                    if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1) {
                        
                        [cell.progresssView setHidden:NO];
                        
                        cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                  green:0.0f/255.0f
                                                                                   blue:20.0f/255.0f
                                                                                  alpha:0.7f];
                        cell.circularProgress.max = 1.0f;
                        cell.circularProgress.fillRadiusPx = 25;
                        cell.circularProgress.step = 0.1f;
                        cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                        cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        cell.circularProgress.outlineWidth = 1;
                        cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                        cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                        
                        
                        [[HKCircularProgressView appearance] setAnimationDuration:5];
                        
                        cell.circularProgress.alwaysDrawOutline = YES;
                        
                        
                        cell.insideProgress.fillRadius = 1;
                        cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                        cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        [cell.circularProgress setCurrent:testVa
                                                 animated:YES];
                        [cell.insideProgress setCurrent:1.0f
                                               animated:YES];
                        
                        
                    }
                    NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",cell.leftButton.currentTitle];
                    
                    cell.youHaveVotedLabel.text =uVoted;
                    
                    
                    NSInteger newVall = [cell.totalVotesLabel.text integerValue] + 1;
                    cell.totalVotesLabel.text = [NSString stringWithFormat:@"%ld HeyVotes",(long)newVall];
                    
                    
                    
                    
                    BOOL interNetCheck=[WebServiceUrl InternetCheck];
                    if (interNetCheck==YES ) {
                        
                        
                        
                        
                        
                        //
                        //                    UIView *newView = [[UIView alloc]init];
                        //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                        //                    [self.view addSubview:newView];
                        //
                        //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                        //
                        
                        
                        
                        NSDictionary *jsonDictionary =@{
                                                        
                                                        @"isWeb":@"false",
                                                        @"voteOption":[NSNumber numberWithInteger:2],
                                                        @"postId":[NSNumber numberWithInteger:IDval]
                                                        
                                                        };
                        
                        
                        
                        
                        
                        
                        NSError *error;
                        
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                            
                                                                           options:0
                                            
                                                                             error:&error];
                        
                        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                        
                        NSLog(@"JSON OUTPUT: %@",JSONString);
                        
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            
                            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/Vote_Z1"]];
                            
                            
                            
                            [requestPost setHTTPMethod:@"POST"];
                            
                            
                            
                            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                            
                            
                            
                            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                            
                            
                            
                            [requestPost setHTTPBody: requestData];
                            
                            
                            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                            
                            
                            
                            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                if (error) {
                                    //do something with error
                                } else {
                                    
                                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if (dic==nil) {
                                            
                                            
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                        }
                                        else{
                                            
                                            
                                            NSLog(@"hjfshjfhs%@",dic);
                                            
                                            
                                            [self callWebServiceRefresh:0];
                                            voteResultValFourVersus = @"downleftvoted";
                                            
                                            
                                            //
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                    });
                                }
                            }];
                            
                        });
                    }
                    
                    else{
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                        message:@""
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        
                        
                    }
                    
                    
                }
                
                //   [cell.yesNoMainView setHidden:YES];
                
                
                
                
            }
            
            
        }
    }
    
}

- (IBAction)fourVersusRightButton:(id)sender {
    
    // timerLoad = @"invalid";
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    globalViewCell*cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    
    
    if ([[[globalArray valueForKey:@"CanVote"] objectAtIndex:indexPath.section] integerValue] == 0) {
        [self showToast:@"You can't vote on this post"];
    }
    
    else{
        
        if (indexPath != nil)
        {
            [voteResultAraayFourVersus addObject:[globalArray objectAtIndex:indexPath.section]];
            
            
            NSInteger IDval = [[[globalArray valueForKey:@"Id"] objectAtIndex:indexPath.section] integerValue];
            
            NSLog(@"%@",[globalArray objectAtIndex:indexPath.section]);
            if ([[[globalArray valueForKey:@"isDone"] objectAtIndex:indexPath.section] integerValue]  == 0) {
                
                
                if ( [[[globalArray objectAtIndex:indexPath.section] valueForKey:@"hasVoted"] integerValue ]==0) {
                    
                    
                    
                    cell.fourVersusFirstSecondLeftButton.userInteractionEnabled = NO;
                    cell.fourVersusFirstSecondRightButton.userInteractionEnabled = NO;
                    cell.fourVersusLeftButton.userInteractionEnabled = NO;
                    cell.fourVersusRightButton.userInteractionEnabled = NO;
                    
                    
                    
                    [cell.fourVersusFirstSecondLeftButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.fourVersusFirstSecondRightButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.fourVersusLeftButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.fourVersusRightButton setBackgroundColor:[UIColor colorWithRed:200.0f/255.0f
                                                                                   green:200.0f/255.0f
                                                                                    blue:200.0f/255.0f
                                                                                   alpha:1.0f]];
                    
                    if ([[[globalArray valueForKey:@"PostType"] objectAtIndex:indexPath.section] integerValue] == 1) {
                        
                        [cell.progresssView setHidden:NO];
                        
                        cell.circularProgress.progressTintColor = [UIColor colorWithRed:202.0f/255.0f
                                                                                  green:0.0f/255.0f
                                                                                   blue:20.0f/255.0f
                                                                                  alpha:0.7f];
                        cell.circularProgress.max = 1.0f;
                        cell.circularProgress.fillRadiusPx = 25;
                        cell.circularProgress.step = 0.1f;
                        cell.circularProgress.startAngle = (M_PI * 3) * 0.5;
                        cell.circularProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        cell.circularProgress.outlineWidth = 1;
                        cell.circularProgress.outlineTintColor = [UIColor whiteColor];
                        cell.circularProgress.endPoint = [[HKCircularProgressEndPointSpike alloc] init];
                        
                        
                        [[HKCircularProgressView appearance] setAnimationDuration:5];
                        
                        cell.circularProgress.alwaysDrawOutline = YES;
                        
                        
                        cell.insideProgress.fillRadius = 1;
                        cell.insideProgress.progressTintColor = [UIColor lightGrayColor];
                        cell.insideProgress.translatesAutoresizingMaskIntoConstraints = NO;
                        [cell.circularProgress setCurrent:testVa
                                                 animated:YES];
                        [cell.insideProgress setCurrent:1.0f
                                               animated:YES];
                        
                        
                    }
                    NSString*uVoted = [NSString stringWithFormat:@"You have voted for \"%@\"",cell.leftButton.currentTitle];
                    
                    cell.youHaveVotedLabel.text =uVoted;
                    
                    
                    NSInteger newVall = [cell.totalVotesLabel.text integerValue] + 1;
                    cell.totalVotesLabel.text = [NSString stringWithFormat:@"%ld HeyVotes",(long)newVall];
                    
                    
                    
                    
                    BOOL interNetCheck=[WebServiceUrl InternetCheck];
                    if (interNetCheck==YES ) {
                        
                        
                        
                        
                        
                        //
                        //                    UIView *newView = [[UIView alloc]init];
                        //                    newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
                        //                    [self.view addSubview:newView];
                        //
                        //                    [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
                        //
                        
                        
                        
                        NSDictionary *jsonDictionary =@{
                                                        
                                                        @"isWeb":@"false",
                                                        @"voteOption":[NSNumber numberWithInteger:3],
                                                        @"postId":[NSNumber numberWithInteger:IDval]
                                                        
                                                        };
                        
                        
                        
                        
                        
                        
                        NSError *error;
                        
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                            
                                                                           options:0
                                            
                                                                             error:&error];
                        
                        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                        
                        NSLog(@"JSON OUTPUT: %@",JSONString);
                        
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            
                            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/posts/Vote_Z1"]];
                            
                            
                            
                            [requestPost setHTTPMethod:@"POST"];
                            
                            
                            
                            [requestPost setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"content-type"];
                            
                            
                            
                            NSData *requestData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
                            
                            
                            
                            [requestPost setHTTPBody: requestData];
                            
                            
                            [requestPost addValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"tokenVal"] forHTTPHeaderField:@"hjtyu34"];
                            
                            
                            
                            [NSURLConnection sendAsynchronousRequest:requestPost queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                if (error) {
                                    //do something with error
                                } else {
                                    
                                    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        if (dic==nil) {
                                            
                                            
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                        }
                                        else{
                                            
                                            
                                            NSLog(@"hjfshjfhs%@",dic);
                                            
                                            
                                            [self callWebServiceRefresh:0];
                                            voteResultValFourVersus = @"downrightvoted";
                                            
                                            
                                            //
                                            //                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                            //                                    [newView removeFromSuperview];
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                        
                                        
                                    });
                                }
                            }];
                            
                        });
                    }
                    
                    else{
                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check your Internet Connection"
                                                                        message:@""
                                                                       delegate:self
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        
                        
                    }
                    
                    
                }
                
                //   [cell.yesNoMainView setHidden:YES];
                
                
                
                
            }
            
            
        }
    }
    
}



- (IBAction)rollOverButton:(id)sender {
    
    if ([topViewVal isEqualToString:@"one"]) {
        topViewVal = @"two";
        
        
        
        [_topView setHidden:NO];
        
        
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        transition.duration = 0.3;
        [_topView.layer addAnimation:transition forKey:nil];
        
    }
    
    else{
        topViewVal = @"one";
        [_topView setHidden:YES];
        
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        transition.duration = 0.4;
        [_topView.layer addAnimation:transition forKey:nil];
        
    }
    
}


@end
