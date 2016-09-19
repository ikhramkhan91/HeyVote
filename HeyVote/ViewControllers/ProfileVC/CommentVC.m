//
//  CommentVC.m
//  HeyVote
//
//  Created by Ikhram Khan on 5/19/16.
//  Copyright © 2016 AppCandles. All rights reserved.
//

#import "CommentVC.h"
#import "GMDCircleLoader.h"
#import "UIView+Toast.h"
#import "WebServiceUrl.h"
#import "UIImageView+WebCache.h"
#import "IQKeyboardManager.h"
#import "heyVoteProfileVC.h"


@interface CommentVC (){
    
    CGRect  replyrect;
    
    CGRect  commentBoxRect;
    NSString * userName;
     NSInteger  userId;
    NSString * newStr ;
    NSString * testde;
    
    NSString* userIdf;
    NSString*token;
   
}

@end

@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     testde = @"";
    _commentTextView.autocorrectionType = UITextAutocorrectionTypeNo;
    
   [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
    
   [[IQKeyboardManager sharedManager] setEnable:NO];
    commentBoxRect = CGRectMake(self.commentBoxView.frame.origin.x, self.commentBoxView.frame.origin.y , self.commentBoxView.frame.size.width, self.commentBoxView.frame.size.height);
    replyrect =CGRectMake(self.replyInnerView.frame.origin.x, self.replyInnerView.frame.origin.y , self.replyInnerView.frame.size.width, self.replyInnerView.frame.size.height);
    
    
   // [_myTableView reloadData];
    
    arrayValuee = [[NSMutableArray alloc]init];
    hashAdArray = [[NSMutableArray alloc]init];
     AdTheRateArray = [[NSMutableArray alloc]init];
    [self callWebService];
    
self.commentTextView.layer.borderWidth = 0.0f;
 _commentTextView.text  = @"";
    [_commentTextView becomeFirstResponder];
    [_writeAcommentLabel setHidden:NO];
  
    
    [_replyView setHidden:YES];
    [_blurView setAlpha:0];
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.replyView addGestureRecognizer:singleFingerTap];
    
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:YES];
     [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
   [[IQKeyboardManager sharedManager] setEnable:YES];
//    
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}


//#pragma mark - keyboard movements
//- (void)keyboardWillShow:(NSNotification *)notification
//{
//    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        CGRect f = self.commentBoxView.frame;
//        f.origin.y = -keyboardSize.height;
//        self.commentBoxView.frame = f;
//    }];
//}
//
//-(void)keyboardWillHide:(NSNotification *)notification
//{
//    [UIView animateWithDuration:0.3 animations:^{
//        CGRect f = self.commentBoxView.frame;
//        f.origin.y = 0.0f;
//        self.commentBoxView.frame = f;
//    }];
//}

//The event handling method
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         [UIView animateWithDuration:0.3 animations:^{
                             _blurView.alpha = 0;
                         }];
                         
                         self.replyInnerView.frame = CGRectMake(self.replyInnerView.frame.origin.x, self.replyInnerView.frame.origin.y + self.replyInnerView.frame.size.height, self.replyInnerView.frame.size.width, self.replyInnerView.frame.size.height);
                         
                       
                         
                         
                     }
                     completion:^(BOOL finished){
                         if (finished){
                             
                             [_replyView setHidden:YES];
                             
                             
                         }
                             
                     }];
   
    
    
    //Do stuff here...
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table View Data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section{
    
    if (hashAdArray.count > 0) {
       return [hashAdArray count];
    }
   else if (AdTheRateArray.count > 0) {
        return [AdTheRateArray count];
    }
   else{
        return [arrayValuee count];
   }
    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:
(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"myCell";
    static NSString *cellIdentifierHash = @"hashCell";
    static NSString *cellIdentifierAd = @"adCell";
    
    
    if (hashAdArray.count > 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifierHash];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifierHash];
        }
        
        
        UILabel * labOne = (UILabel*)[cell viewWithTag:100];
        labOne.text =[[hashAdArray valueForKey:@"HashTag"] objectAtIndex:indexPath.row];
        
        return cell;
        
    }
    else if (AdTheRateArray.count > 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifierAd];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifierAd];
        }
        NSString *imageStr = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[AdTheRateArray valueForKey:@"ImageIdf"] objectAtIndex:indexPath.row],[[AdTheRateArray valueForKey:@"FolderPath"] objectAtIndex:indexPath.row]];
        
        UIImageView * imgOne = (UIImageView*)[cell viewWithTag:101];
        [imgOne  sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"imagesPerson.jpeg"]];
        
        imgOne.layer.cornerRadius = imgOne.frame.size.height /2;
        imgOne.layer.masksToBounds = YES;
        imgOne.layer.borderWidth = 0;
        
        
        UILabel * labOne = (UILabel*)[cell viewWithTag:102];
        labOne.text =[[AdTheRateArray valueForKey:@"DisplayName"] objectAtIndex:indexPath.row];
        
        
        
        return cell;
    }
   else if (arrayValuee.count > 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
    NSString *imageStr = [NSString stringWithFormat:@"https://www.heyvote.com/Home/GetImage/%@/%@",[[arrayValuee valueForKey:@"ImageIdf"] objectAtIndex:indexPath.row],[[arrayValuee valueForKey:@"FolderPath"] objectAtIndex:indexPath.row]];
    
    UIImageView * imgOne = (UIImageView*)[cell viewWithTag:10];
    [imgOne  sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"imagesPerson.jpeg"]];
    
    imgOne.layer.cornerRadius = imgOne.frame.size.height /2;
    imgOne.layer.masksToBounds = YES;
    imgOne.layer.borderWidth = 0;
    
    
    UILabel * labOne = (UILabel*)[cell viewWithTag:11];
    labOne.text =[[arrayValuee valueForKey:@"DisplayName"] objectAtIndex:indexPath.row];
    
    UITextView * labOnee = (UITextView*)[cell viewWithTag:12];
    labOnee.text =[[arrayValuee valueForKey:@"Comment"] objectAtIndex:indexPath.row];

    
    
    
    UILabel * daysAgo = (UILabel*)[cell viewWithTag:13];
    
    NSString*stringTimer =[[arrayValuee valueForKey:@"CreatedOn"] objectAtIndex:indexPath.row];
    
    
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
        
        
        daysAgo.text = localTime;
        
    }
        
        return cell;
    
     }
    
   
    
    return nil;
    

}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    NSInteger newValF;
//    
//    
//       CGFloat height = 0;
//    if (hashAdArray.count > 0) {
//        
//        height = 37;
//        
//    }
//    
//    else if (AdTheRateArray.count > 0){
//        
//        height = 37;
//        
//        
//    }
//    
//    else {
//         height = 65;
//       
//    }
//  
//    
//    
//   return height;
//    
//}
// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         [_commentTextView resignFirstResponder];
                         _commentBoxView.frame = commentBoxRect;
                     }
                     completion:^(BOOL finished){
                     }];
    
    
  
    if (hashAdArray.count > 0 ) {
        


        NSMutableArray * testVa  = [[NSMutableArray alloc]init];
     NSArray*  testVaArra = [_commentTextView.text componentsSeparatedByString:@" "];
        [testVa addObjectsFromArray:testVaArra];
        [testVa removeLastObject];
        NSString * neeeewString = @"";
        NSMutableString *nameString = [[NSMutableString alloc]init];
        
        if ([testVa count]> 0) {
            
            for (int i = 0 ; i < [testVa count] ; i++) {
                
         
                neeeewString = [NSString stringWithFormat:@"%@",[testVa objectAtIndex:i]];
       

                
                  [nameString appendString:[NSString stringWithFormat:@"%@ ",neeeewString]];
                
            }
            
            
            NSString * finalStr =[NSString stringWithFormat:@"%@%@ ",nameString,[[hashAdArray valueForKey:@"HashTag"] objectAtIndex:indexPath.row]];
            
            if ([finalStr containsString:@"#"]) {
                                  finalStr =   [finalStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
                
                
                                }
            
            hashAdArray = [[NSMutableArray alloc]init];
            AdTheRateArray = [[NSMutableArray alloc]init];
            [_myTableView reloadData];
            
            _commentTextView.text = finalStr;
            
    
            

            
        }
        
    
        
        
        
       
        
    }
    
    else if (AdTheRateArray.count > 0 ) {
        
        
        
        NSMutableArray * testVa  = [[NSMutableArray alloc]init];
        NSArray*  testVaArra = [_commentTextView.text componentsSeparatedByString:@" "];
        [testVa addObjectsFromArray:testVaArra];
   [testVa removeLastObject];
      
        NSString * neeeewString = @"";
        NSMutableString *nameString = [[NSMutableString alloc]init];
        
        if ([testVa count]> 0 || [testVa count] == 0) {
            
            for (int i = 0 ; i < [testVa count] ; i++) {
                
                
                
                
            
                    neeeewString = [NSString stringWithFormat:@"%@",[testVa objectAtIndex:i]];
            
                
                
                
                [nameString appendString:[NSString stringWithFormat:@"%@ ",neeeewString]];
                
            }
            
            
            NSString * finalStr =[NSString stringWithFormat:@"%@@%@ ",nameString,[[AdTheRateArray valueForKey:@"DisplayName"] objectAtIndex:indexPath.row]];
            
            if ([finalStr containsString:@"#"]) {
                finalStr =   [finalStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
                
                
            }
            
            hashAdArray = [[NSMutableArray alloc]init];
            AdTheRateArray = [[NSMutableArray alloc]init];
            [_myTableView reloadData];
            
            _commentTextView.text = finalStr;
            
            
            
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    else if (arrayValuee.count > 0 ) {
        userName =[[arrayValuee valueForKey:@"DisplayName"] objectAtIndex:indexPath.row];
          userId =[[[arrayValuee valueForKey:@"Id"] objectAtIndex:indexPath.row] integerValue];
        
        userIdf =[[arrayValuee valueForKey:@"UserIdf"] objectAtIndex:indexPath.row];
        
         token =[[arrayValuee valueForKey:@"Token"] objectAtIndex:indexPath.row];
        
        
        
        [UIView animateWithDuration:0.2
                              delay:0.1
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             [_replyView setHidden:NO];
                             [UIView animateWithDuration:0.3 animations:^{
                                 _blurView.alpha = 0.5;
                             }];
                             
                             
                             self.replyInnerView.frame = replyrect;
                             
                             
                             
                         }
                         completion:^(BOOL finished){
                             
                             
                             
                         }];

    }
    
    
    
   
    

    
    
    
}


- (IBAction)cloaseButton:(id)sender {
    
     [_commentTextView resignFirstResponder];
 
    

    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)replyyyButton:(id)sender {
    
    [_writeAcommentLabel setHidden:YES];
    _commentTextView.text = @"";
    
    

    
  if (arrayValuee.count > 0 ) {
         _commentTextView.text = [NSString stringWithFormat:@"@%@",userName];
    }
    
    
  
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         [UIView animateWithDuration:0.3 animations:^{
                             _blurView.alpha = 0;
                         }];
                         
                         self.replyInnerView.frame = CGRectMake(self.replyInnerView.frame.origin.x, self.replyInnerView.frame.origin.y + self.replyInnerView.frame.size.height, self.replyInnerView.frame.size.width, self.replyInnerView.frame.size.height);
                         
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         if (finished){
                             
                             [_replyView setHidden:YES];
                             
                               [_commentTextView becomeFirstResponder];
                         }
                         
                     }];
}

- (IBAction)reporttButton:(id)sender {
    
    
    
    
    
    
    
    BOOL interNetCheck=[WebServiceUrl InternetCheck];
    if (interNetCheck==YES ) {
        
        
        [self showToast:@"Comment has been reported..."];
        
        
        NSDictionary *jsonDictionary =@{
                                        
                                        @"isWeb":@"false",
                                        @"commentId":[NSNumber numberWithInteger:userId]
                                        
                                        
                                        };
                                        
                                        NSError *error;
                                        
                                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                            
                                                                                           options:0
                                                            
                                                                                             error:&error];
                                        
                                        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
                                        
                                        NSLog(@"JSON OUTPUT: %@",JSONString);
                                        
                                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                            
                                            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/SpamComment"]];
                                            
                                            
                                            
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
                                                            
                                                            //
                                                            //                                                                    [GMDCircleLoader hideFromView:newView animated:YES];
                                                            //                                                                    [newView removeFromSuperview];
                                                            //
                                                            
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
            
            
        }
        

    
    
    
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         [UIView animateWithDuration:0.3 animations:^{
                             _blurView.alpha = 0;
                         }];
                         
                         self.replyInnerView.frame = CGRectMake(self.replyInnerView.frame.origin.x, self.replyInnerView.frame.origin.y + self.replyInnerView.frame.size.height, self.replyInnerView.frame.size.width, self.replyInnerView.frame.size.height);
                         
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         if (finished){
                             
                             [_replyView setHidden:YES];
                             
                           
                             
                             
                         }
                         
                     }];
    
    
    


    
}

- (IBAction)cancelllButton:(id)sender {
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         [UIView animateWithDuration:0.3 animations:^{
                             _blurView.alpha = 0;
                         }];
                         
                         self.replyInnerView.frame = CGRectMake(self.replyInnerView.frame.origin.x, self.replyInnerView.frame.origin.y + self.replyInnerView.frame.size.height, self.replyInnerView.frame.size.width, self.replyInnerView.frame.size.height);
                         
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         if (finished){
                             
                             [_replyView setHidden:YES];
                             
                             
                         }
                         
                     }];
}



-(void)showToast:(NSString*)msg{
    
    [self.view makeToast:msg
                duration:1.0
                position:CSToastPositionCenter];
}

- (IBAction)commentSendingButton:(id)sender {
    
    if ([_commentTextView.text length] == 0) {
        
    }
    
    else{
        
        
        BOOL interNetCheck=[WebServiceUrl InternetCheck];
        if (interNetCheck==YES ) {
            
       
             [self showToast:@"Posting your comment.."];
            
            
            NSDictionary *jsonDictionary =@{
                                            
                                            @"isWeb":@"false",
                                            @"postId":[NSNumber numberWithInteger:_valueId],
                                            @"info":@{
                                                    
                                                    @"Comment":_commentTextView.text
                                                    }
                                            
                                            };
            
            
           _commentTextView.text = @"";
            
            
            if ([_commentTextView.text isEqualToString:@""]) {
                
                
                [UIView animateWithDuration:0.2
                                      delay:0.0
                                    options: UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     
                                     [_commentTextView resignFirstResponder];
                                     _commentBoxView.frame = commentBoxRect;
                                 }
                                 completion:^(BOOL finished){
                                 }];
                
                
                
                //  [textView resignFirstResponder];
              
            }

            
            [_commentTextView resignFirstResponder];
            
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
                                
//                                
//                                                                    [GMDCircleLoader hideFromView:newView animated:YES];
//                                                                    [newView removeFromSuperview];
//                                
                                
                            }
                            else{
                                
                                
                                NSLog(@"hjfshjfhs%@",dic);
                                
                                
                                [self callWebServiceTwo];
                                
                                
                                
                                
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



-(void)callHashAndAdServices{
    
    
    BOOL interNetCheck=[WebServiceUrl InternetCheck];
    if (interNetCheck==YES ) {
        //
//        UIView *newView = [[UIView alloc]init];
//        newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
//        [self.view addSubview:newView];
//        
//        [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
//        
//        
        
        
        NSDictionary *jsonDictionary =@{
                                        
                                        @"isWeb":@"false",
                                        @"searchString":newStr,
                                        @"pageId":[NSNumber numberWithInteger:0]
                                        
                                        };
        
        
        
        
        
        
        NSError *error;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                            
                                                           options:0
                            
                                                             error:&error];
        
        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        
        NSLog(@"JSON OUTPUT: %@",JSONString);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/SearchHash_z1"]];
            
            
            
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
//                            
//                            
//                            [GMDCircleLoader hideFromView:newView animated:YES];
//                            [newView removeFromSuperview];
//                            
                            
                        }
                        else{
                            
                            
                            NSLog(@"hjfshjfhs%@",dic);
                            
                            
                            hashAdArray = [[NSMutableArray alloc]init];
                            
                            [hashAdArray addObjectsFromArray:[dic valueForKey:@"SearchHash_Z1Result"]];
                            
                            [_myTableView reloadData];
                            
                            
                            
                            
                            
//                            
//                            
//                            [GMDCircleLoader hideFromView:newView animated:YES];
//                            [newView removeFromSuperview];
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





-(void)callAdServices{
    
    
    BOOL interNetCheck=[WebServiceUrl InternetCheck];
    if (interNetCheck==YES ) {
        //
        //        UIView *newView = [[UIView alloc]init];
        //        newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        //        [self.view addSubview:newView];
        //
        //        [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
        //
        //
        
        
        NSDictionary *jsonDictionary =@{
                                        
                                        @"isWeb":@"false",
                                        @"searchString":newStr,
                                        @"pageId":[NSNumber numberWithInteger:0]
                                        
                                        };
        
        
        
        
        
        
        NSError *error;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                            
                                                           options:0
                            
                                                             error:&error];
        
        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        
        NSLog(@"JSON OUTPUT: %@",JSONString);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/SearchUsers_N2"]];
            
            
            
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
                            //
                            //
                            //                            [GMDCircleLoader hideFromView:newView animated:YES];
                            //                            [newView removeFromSuperview];
                            //
                            
                        }
                        else{
                            
                            
                            NSLog(@"hjfshjfhs%@",dic);
                            
                            
                            AdTheRateArray = [[NSMutableArray alloc]init];
                            
                            [AdTheRateArray addObjectsFromArray:[dic valueForKey:@"SearchUsers_N2Result"]];
                            
                            [_myTableView reloadData];
                            
                            
                            
                            
                            
                            //
                            //
                            //                            [GMDCircleLoader hideFromView:newView animated:YES];
                            //                            [newView removeFromSuperview];
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



-(void)callWebService{
    
    
    BOOL interNetCheck=[WebServiceUrl InternetCheck];
    if (interNetCheck==YES ) {
        //
//        UIView *newView = [[UIView alloc]init];
//        newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
//        [self.view addSubview:newView];
//        
//        [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
//        
//        
        
        
        NSDictionary *jsonDictionary =@{
                                        
                                        @"isWeb":@"false",
                                        @"postId":[NSNumber numberWithInteger:_valueId],
                                        @"pageId":[NSNumber numberWithInteger:0],
                                        @"pageSize":@"50"
                                        
                                        };
        
        
        
        
        
        
        NSError *error;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                            
                                                           options:0
                            
                                                             error:&error];
        
        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        
        NSLog(@"JSON OUTPUT: %@",JSONString);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/getComments"]];
            
            
            
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
                            
                            
//                            [GMDCircleLoader hideFromView:newView animated:YES];
//                            [newView removeFromSuperview];
//                            
                            
                        }
                        else{
                            
                            
                            NSLog(@"hjfshjfhs%@",dic);
                            
                            
                           arrayValuee = [[NSMutableArray alloc]init];
                            
                            [arrayValuee addObjectsFromArray:[dic valueForKey:@"GetCommentsResult"]];
                            
                            [_myTableView reloadData];
                            
                            
                            
                            
                            
//                            
//                            
//                            [GMDCircleLoader hideFromView:newView animated:YES];
//                            [newView removeFromSuperview];
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

- (void)textViewDidBeginEditing:(UITextView *)textView
{
//    if ([textView.text isEqualToString:@"Write"]) {
//        textView.text = @"";
//        textView.textColor = [UIColor blackColor]; //optional
//    }
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    
//    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShownFirstTime:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
}
//
- (void)keyboardWasShownFirstTime:(NSNotification *)notification
{
    
    
    
    if ([testde isEqualToString:@""]) {
        
        testde = @"new";
        
        CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        int height = MIN(keyboardSize.height,keyboardSize.width);
        
        
        [UIView animateWithDuration:0.1
                              delay:0.1
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             
                             
                             
                             
                             _commentBoxView.frame = CGRectMake(commentBoxRect.origin.x,  self.view.frame.size.height - height - commentBoxRect.size.height , commentBoxRect.size.width, commentBoxRect.size.height);
                             
                             [_commentTextView becomeFirstResponder];
                         }
                         completion:^(BOOL finished){
                         }];
        
        
    }
    
    
    
}





- (void)keyboardWasShown:(NSNotification *)notification
{
    
  
    if ([testde isEqualToString:@"new"]) {
   
        
        NSDictionary* notificationInfo = [notification userInfo];
        // Get the size of the keyboard.
        // CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        
        CGRect keyboardSize = [[notificationInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        //Given size may not account for screen rotation
        //    int height = MIN(keyboardSize.height,keyboardSize.width);
        //    int width = MAX(keyboardSize.height,keyboardSize.width);
        //
        //    //your other code here..........
        //    int newHeight = height;
        
        [UIView animateWithDuration:0.1
                              delay:0.1
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             
                             
                             
                             
                             
                             _commentBoxView.frame = CGRectMake(commentBoxRect.origin.x,  self.view.frame.size.height - keyboardSize.size.height - commentBoxRect.size.height , commentBoxRect.size.width, commentBoxRect.size.height);
                             
                             [_commentTextView becomeFirstResponder];
                         }
                         completion:^(BOOL finished){
                         }];
        
        
        
    }
    
}

//-(void)keyboardWillHideE:(NSNotification *)notification
//{
//    
//
//    
//    
//   
//}


-(void)callWebServiceTwo{
    
    
    BOOL interNetCheck=[WebServiceUrl InternetCheck];
    if (interNetCheck==YES ) {
        //
//        UIView *newView = [[UIView alloc]init];
//        newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
//        [self.view addSubview:newView];
//        
//        [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
//        
//        
        
        
        NSDictionary *jsonDictionary =@{
                                        
                                        @"isWeb":@"false",
                                        @"postId":[NSNumber numberWithInteger:_valueId],
                                        @"pageId":[NSNumber numberWithInteger:0],
                                        @"pageSize":@"50"
                                        
                                        };
        
        
        
        
        
        
        NSError *error;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                            
                                                           options:0
                            
                                                             error:&error];
        
        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        
        NSLog(@"JSON OUTPUT: %@",JSONString);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableURLRequest *requestPost =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.heyvote.com/WebServices/HeyVoteService.svc/user/getComments"]];
            
            
            
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
                            
//                            
//                            [GMDCircleLoader hideFromView:newView animated:YES];
//                            [newView removeFromSuperview];
//                            
                            
                        }
                        else{
                            
                            
                            NSLog(@"hjfshjfhs%@",dic);
                            
                            
                            arrayValuee = [[NSMutableArray alloc]init];
                            
                            [arrayValuee addObjectsFromArray:[dic valueForKey:@"GetCommentsResult"]];
                            
                            [_myTableView reloadData];
                            
                            
                            
                            
                            
                            
//                            
//                            [GMDCircleLoader hideFromView:newView animated:YES];
//                            [newView removeFromSuperview];
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




- (void)textViewDidEndEditing:(UITextView *)textView
{
//    if ([textView.text isEqualToString:@""]) {
//        textView.text = @"placeholder text here...";
//        textView.textColor = [UIColor lightGrayColor]; //optional
//    }
   

//

    if ([_commentTextView.text length]>0) {
        [_writeAcommentLabel setHidden:YES];
        
    }
    
    else{
        [_writeAcommentLabel setHidden:NO];
        hashAdArray = [[NSMutableArray alloc]init];
        AdTheRateArray = [[NSMutableArray alloc]init];
        [_myTableView reloadData];
    }
    
  
    
//     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideE:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    if ([textView.text length]>0) {
        [_writeAcommentLabel setHidden:YES];
        
//        if ([textView.text containsString:@" #"] || [textView.text containsString:@" @"]) {
//            NSArray * newArr = [[NSArray alloc]init];
//            newArr = [textView.text componentsSeparatedByString:@" "];
//                    NSLog(@"@valueeees %@",[newArr lastObject]);
//   
//
//        }
        
        if ([_commentTextView.text rangeOfString:@"@"].location == NSNotFound) {
            NSLog(@"string does not contain bla");
            
           
            
                 }
        
        
        else {
          //  NSLog(@"string contains bla!");
            
            hashAdArray = [[NSMutableArray alloc]init];
            AdTheRateArray = [[NSMutableArray alloc]init];
            [_myTableView reloadData];
            
            NSArray * newArr = [[NSArray alloc]init];
                        newArr = [textView.text componentsSeparatedByString:@" "];
            
            
           newStr =[newArr lastObject];
            
            if ([newStr containsString:@"@"]) {
                
                newStr = [newStr stringByReplacingOccurrencesOfString:@"@" withString:@""];
                
                NSLog(@"AdtheRateValue :%@",newStr);
                
                if (newStr.length > 0) {
                    [self callAdServices];
                }
                
                else{
                    hashAdArray = [[NSMutableArray alloc]init];
                    AdTheRateArray = [[NSMutableArray alloc]init];
                    [_myTableView reloadData];
                }
                
            
            }
            
            else if ([newStr containsString:@"#"]){
                 newStr = [newStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
                 NSLog(@"HashValue :%@",newStr);
                
                if (newStr.length > 0) {
                    [self callHashAndAdServices];
                }
                
                else{
                    hashAdArray = [[NSMutableArray alloc]init];
                    AdTheRateArray = [[NSMutableArray alloc]init];
                    [_myTableView reloadData];

                }
                
                
            }
            
            
            
            
        }
        
        
    }
    
    else{
        [_writeAcommentLabel setHidden:NO];
        hashAdArray = [[NSMutableArray alloc]init];
        AdTheRateArray = [[NSMutableArray alloc]init];
        [_myTableView reloadData];
    }
}


//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    NSLog(@"currenrt %@",text);
//    
////    
////    if ([text isEqualToString:@"#"]) {
////        NSArray * newArr = [textView.text componentsSeparatedByString:@" @"];
////        
////        NSLog(@"@valueeees %@",[newArr lastObject]);
////        
////    }
////    
////    else if ([textView.text containsString:@" #"]){
////        
////        NSArray * newArr = [textView.text componentsSeparatedByString:@" #"];
////        NSLog(@"#valueeees %@",[newArr lastObject]);
////    }
////
////    
////    
////    
////    
////      return YES;
//    
//    
//    NSString* parameterStr=@"";
//    parameterStr=[[textView text] stringByAppendingString:text];
//    
//    if([parameterStr isEqualToString:@" #"] || [parameterStr isEqualToString:@" @"])
//    {
//        NSString * newWa ;
//        newWa = [newWa stringByAppendingFormat:@"%@",text];
//        NSLog(@" fsdfsdf sdf : %@",newWa);
//        
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//    
//}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
 
 
    
        if ([text isEqualToString:@"\n"]) {
            
            
            [UIView animateWithDuration:0.2
                                  delay:0.0
                                options: UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 
                                 [_commentTextView resignFirstResponder];
                                 _commentBoxView.frame = commentBoxRect;
                             }
                             completion:^(BOOL finished){
                             }];
            
            
            
          //  [textView resignFirstResponder];
            return NO;
        }
 
    return YES;
}


- (IBAction)viewProfileButton:(id)sender {
    
  
    
    
    BOOL interNetCheck=[WebServiceUrl InternetCheck];
    if (interNetCheck==YES ) {
        
        UIView *newView = [[UIView alloc]init];
        newView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
        [self.view addSubview:newView];
        
        [GMDCircleLoader setOnView:newView withTitle:@"Loading..." animated:YES];
        
        
        
        
        NSDictionary *jsonDictionary =@{
                                        @"contactToken":userIdf,
                                        @"isWeb":@"false"                                           };
        
        
        
        
        
        
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
                            myVC.contactToke = token;
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
    
    
    
    
    [UIView animateWithDuration:0.2
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         [UIView animateWithDuration:0.3 animations:^{
                             _blurView.alpha = 0;
                         }];
                         
                         self.replyInnerView.frame = CGRectMake(self.replyInnerView.frame.origin.x, self.replyInnerView.frame.origin.y + self.replyInnerView.frame.size.height, self.replyInnerView.frame.size.width, self.replyInnerView.frame.size.height);
                         
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         if (finished){
                             
                             [_replyView setHidden:YES];
                             
                             
                             
                             
                         }
                         
                     }];
    
    
    
    
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



@end
