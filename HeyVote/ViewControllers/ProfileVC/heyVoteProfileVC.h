//
//  heyVoteProfileVC.h
//  HeyVote
//
//  Created by Ikhram Khan on 5/14/16.
//  Copyright © 2016 AppCandles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "YMCAudioPlayer.h"
#import "MZTimerLabel.h"
#import <AudioToolbox/AudioToolbox.h>
#import "HeyVoteProfileCollectionViewCell.h"
#import <MediaPlayer/MediaPlayer.h>

@interface heyVoteProfileVC : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate,MZTimerLabelDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
 
        int secondsLeft;
        MZTimerLabel *timerExample8;
   
}
@property (nonatomic, weak) NSTimer *timerCalc;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollableMainView;

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *followUnfollow;
- (IBAction)followUnfollow:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *blockUnblock;
- (IBAction)blockUnblock:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIView *profileNameImageView;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet NSMutableArray *profileArray;
- (IBAction)closeButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *heyVotesLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (strong, nonatomic) MPMoviePlayerController* mc;
@property (strong, nonatomic) IBOutlet NSString *contactToke;

@property (weak, nonatomic) IBOutlet UIView *imageZoomView;
@property (weak, nonatomic) IBOutlet UIImageView *zoomingImage;
- (IBAction)zoomCloseButton:(id)sender;


@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;





@end
