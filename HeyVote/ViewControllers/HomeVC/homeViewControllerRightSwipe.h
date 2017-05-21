//
//  homeViewControllerRightSwipe.h
//  HeyVote
//
//  Created by macbook on 4/4/17.
//  Copyright © 2017 AppCandles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GMDCircleLoader.h"
#import "UIView+Toast.h"
#import "WebServiceUrl.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import "CollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "THCircularProgressView.h"
#import <AVKit/AVKit.h>
#import "AppDelegate.h"

@interface homeViewControllerRightSwipe : UIViewController<UITableViewDataSource,
UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,AVAudioPlayerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,AVPlayerViewControllerDelegate>

{
    UIActivityIndicatorView *activityIndicator;
    UILabel *footerLabel;
    int secondsLeft;
    int secondsLeftForComments;
    //    AVPlayerViewController *playerViewController;
    //    AVPlayer * videoplayer;
    // AVPlayerItem *item;
}

//@property (nonatomic) AVPlayerItem *playerItem;
//
@property (weak, nonatomic) IBOutlet UIButton *rollOverButton;

//@property (strong,nonatomic) AVPlayerViewController *playerViewController;
//@property (strong,nonatomic) AVPlayer *videoplayer;
- (IBAction)rollOverButton:(id)sender;

- (IBAction)videoThumbnailPlayButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *secondHeader;
@property (weak, nonatomic) IBOutlet UISlider *homeSliderTwo;
- (IBAction)homwSliderTwo:(id)sender;
- (IBAction)funButton:(id)sender;
- (IBAction)seriousButton:(id)sender;
- (IBAction)generalButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *funButton;
@property (weak, nonatomic) IBOutlet UIButton *seriousButton;
@property (weak, nonatomic) IBOutlet UIButton *generalButton;



@property (weak, nonatomic) IBOutlet UILabel *wonText;
@property (weak, nonatomic) IBOutlet UILabel *lostText;
@property (weak, nonatomic) IBOutlet UIButton *heyVoteUpdates;
- (IBAction)CheckInButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *topView;

- (IBAction)newHeyVotes:(id)sender;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIView *noPostView;

@property (nonatomic, weak) NSTimer *timerCalc;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
- (IBAction)homeButton:(id)sender;
- (IBAction)centerButton:(id)sender;
- (IBAction)searchButton:(id)sender;
- (IBAction)profileButton:(id)sender;
- (IBAction)contactsButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UISlider *homeSlider;
- (IBAction)homwSlider:(id)sender;
- (IBAction)globalButton:(id)sender;
- (IBAction)qatarButton:(id)sender;
- (IBAction)privateButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *qatarButton;
@property (weak, nonatomic) IBOutlet UIButton *privateButton;
@property (weak, nonatomic) IBOutlet UIView *previewYouHaveVoted;
@property (weak, nonatomic) IBOutlet UILabel *previewYouVotedText;
@property (weak, nonatomic) IBOutlet UIView *previewButtonView;

@property (weak, nonatomic) IBOutlet UIButton *globalButton;
@property (nonatomic, assign) CGPoint lastContentOffset;
@property (weak, nonatomic) IBOutlet UIView *previewView;
- (IBAction)previewCloseButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *previewTitle;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
- (IBAction)previewLeftButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *previewRightButton;
- (IBAction)previewRightButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *previewLeftButton;
@property(retain,nonatomic)UIRefreshControl *refreshControl;
@property (strong, nonatomic) NSMutableArray *globalArray;
- (IBAction)zoomCloseButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *zoomView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollZoomView;
@property (weak, nonatomic) IBOutlet UIImageView *zoomImageView;

//Global

- (IBAction)buttonOverImage:(id)sender;
- (IBAction)doubleVoicePlayLeftButton:(id)sender;
- (IBAction)doubleVoicePlayRightButton:(id)sender;
- (IBAction)leftButton:(id)sender;
- (IBAction)rightButton:(id)sender;
- (IBAction)showMoreComments:(id)sender;
- (IBAction)reHeyVote:(id)sender;
- (IBAction)shareButton:(id)sender;
- (IBAction)moreButton:(id)sender;
- (IBAction)moreFollow:(id)sender;
- (IBAction)moreBlock:(id)sender;
- (IBAction)moreReport:(id)sender;
- (IBAction)commentSendButton:(id)sender;
- (IBAction)singleVoicePlayButton:(id)sender;

- (IBAction)deleteButton:(id)sender;
- (IBAction)firstCommentButton:(id)sender;
- (IBAction)secondCommentButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *thirdCommentButton;
- (IBAction)thirdCommentButton:(id)sender;
- (IBAction)threeVersusRightButton:(id)sender;

- (IBAction)threeVersusRightResultButton:(id)sender;

- (IBAction)threeVersusFirstSecondLeftButton:(id)sender;
- (IBAction)threeVersusFirstSecondRightButton:(id)sender;

- (IBAction)threeVersusFinalLeftButton:(id)sender;

- (IBAction)threeVersusFinalRightButton:(id)sender;
- (IBAction)fourVersusFirstSecondLeftButton:(id)sender;
- (IBAction)fourVersusFirstSecondRightButton:(id)sender;


- (IBAction)fourVersusLeftButton:(id)sender;

- (IBAction)fourVersusRightButton:(id)sender;






@end
