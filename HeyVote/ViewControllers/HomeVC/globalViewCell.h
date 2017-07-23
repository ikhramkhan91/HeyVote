//
//  globalViewCell.h
//  HeyVote
//
//  Created by Ikhram Khan on 5/31/16.
//  Copyright © 2016 AppCandles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKCircularProgressView.h"
#import <AVFoundation/AVFoundation.h>

#import <AVKit/AVKit.h>



@interface globalViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLableText;

@property (weak, nonatomic) IBOutlet UILabel *timerCell;
@property (weak, nonatomic) IBOutlet UIView *yesNoMainView;
@property (strong, nonatomic) IBOutlet UIView *videoPreview;
@property (weak, nonatomic) IBOutlet UIView *progresssView;

@property (weak, nonatomic) IBOutlet HKCircularProgressView *insideProgress;
@property (weak, nonatomic) IBOutlet UILabel *remainingLabel;

@property (weak, nonatomic) IBOutlet HKCircularProgressView *circularProgress;

@property (weak, nonatomic) IBOutlet UIView *yesNoNotDoneButtonView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *mySpinner;
@property (weak, nonatomic) IBOutlet UIView *doubleVoiceView;
@property (weak, nonatomic) IBOutlet UIButton *doubleAudioPlayRightButton;
@property (weak, nonatomic) IBOutlet UIButton *doubleAudioPlayLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *singleAudioPlayButton;
@property (weak, nonatomic) IBOutlet UIView *singleVoiceView;
@property (weak, nonatomic) IBOutlet UIImageView *proImageView;
@property (weak, nonatomic) IBOutlet UILabel *voteLabelLeft;
@property (weak, nonatomic) IBOutlet UILabel *votesLabelRight;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *buttonOverImage;
@property (weak, nonatomic) IBOutlet UIImageView *leftTickImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightTickImage;
@property (weak, nonatomic) IBOutlet UILabel *totalVotesLabel;
@property (weak, nonatomic) IBOutlet UIButton *reheyVoteButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UILabel *totalComments;
@property (weak, nonatomic) IBOutlet UILabel *commentAttributedLabel;
@property (weak, nonatomic) IBOutlet UIButton *showMoreComments;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *rightResultButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *titleLabelView;
@property (weak, nonatomic) IBOutlet UIView *yesNoButtonView;
@property (weak, nonatomic) IBOutlet UIView *voiceView;
@property (weak, nonatomic) IBOutlet UIButton *leftResultButton;
@property (weak, nonatomic) IBOutlet UILabel *youHaveVotedLabel;
//- (IBAction)leftButton:(id)sender;
//- (IBAction)rightButton:(id)sender;
//- (IBAction)showMoreComments:(id)sender;
//- (IBAction)commentSendButton:(id)sender;
//- (IBAction)reHeyVote:(id)sender;
//- (IBAction)shareButton:(id)sender;
//- (IBAction)moreButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *moreButtonView;
@property (weak, nonatomic) IBOutlet UIButton *moreFollow;
@property (weak, nonatomic) IBOutlet UIButton *moreBlock;
@property (weak, nonatomic) IBOutlet UIButton *moreReport;
@property (weak, nonatomic) IBOutlet UIView *deleteView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (weak, nonatomic) IBOutlet UIView *spamView;
@property (weak, nonatomic) IBOutlet UIView *checkInView;

@property (weak, nonatomic) IBOutlet UILabel *commentAttributedLabelTwo;

@property (weak, nonatomic) IBOutlet UILabel *commentAttributedLabelThree;

@property (weak, nonatomic) IBOutlet UIButton *checkinButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdCommentButton;
@property (weak, nonatomic) IBOutlet UIButton *secondCommentButton;
@property (weak, nonatomic) IBOutlet UIButton *firstCommentButton;
@property (weak, nonatomic) IBOutlet UICollectionView *hashCollectionView;

@property (weak, nonatomic) IBOutlet UIView *commentViewIcon;



@property (weak, nonatomic) IBOutlet UIImageView *firsttImageButton;
@property (weak, nonatomic) IBOutlet UIImageView *secondButtonImage;
@property (weak, nonatomic) IBOutlet UIImageView *thirsButtonImage;
@property (weak, nonatomic) IBOutlet UIButton *videoThumbnailPlayButton;
@property (weak, nonatomic) IBOutlet UIImageView *videoThumbnailImage;


@property (strong,nonatomic) AVPlayerLayer *playerLayer;
@property (strong,nonatomic) AVPlayerItem *item;
@property (strong,nonatomic) AVPlayerViewController *playerViewController;
@property (strong,nonatomic) AVPlayer *videoplayer;

-(void)stopVideo;
-(void)playVideo;

- (void) createPlayerWithURL:(NSURL*)url;


@property (weak, nonatomic) IBOutlet UILabel *commentAttributedLabelFirst;
@property (weak, nonatomic) IBOutlet UILabel *commentAttributedCellSecond;

@property (weak, nonatomic) IBOutlet UILabel *commentAttributedCellThird;

@property (strong,nonatomic) AVPlayerLayer *playerLayerAudio;
@property (strong,nonatomic) AVPlayerItem *itemAudio;
@property (strong,nonatomic) AVPlayerViewController *playerViewControllerAudio;
@property (strong,nonatomic) AVPlayer *audioplayer;

-(void)stopAudio;
-(void)playAudio;
@property (weak, nonatomic) IBOutlet UIImageView *leftWinnerImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightWinnerImage;

- (void) createPlayerWithURLForAudio:(NSURL*)url;

@property (weak, nonatomic) IBOutlet UIView *threeVersusYesNoMainView;
@property (weak, nonatomic) IBOutlet UIView *threeVersusYesNoNotDoneButton;
@property (weak, nonatomic) IBOutlet UIButton *threeVersusRightButton;
- (IBAction)threeVersusRightButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *threeVersusYesNoButtonView;
@property (weak, nonatomic) IBOutlet UIButton *threeVersusRightResultButton;
- (IBAction)threeVersusRightResultButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *threeVersusVotesLabelRight;
@property (weak, nonatomic) IBOutlet UIImageView *threeVersusRightWinnerImage;




@property (weak, nonatomic) IBOutlet UIView *threeVersusFirstSecondYesNoMainView;
@property (weak, nonatomic) IBOutlet UIView *threeVersusFirstSecondNotDoneView;

@property (weak, nonatomic) IBOutlet UIView *threeVersusFirstSecondYesNoView;





@property (weak, nonatomic) IBOutlet UIButton *threeVersusFirstSecondLeftButton;

@property (weak, nonatomic) IBOutlet UIButton *threeVersusFirstSecondRightButton;
@property (weak, nonatomic) IBOutlet UIButton *threeVersusFinalLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *threeVersusFinalRightButton;
@property (weak, nonatomic) IBOutlet UILabel *threeVersusFinalLeftVote;

@property (weak, nonatomic) IBOutlet UILabel *threeVersusFinalRightVote;
@property (weak, nonatomic) IBOutlet UIImageView *threeVersusFinalWinnerLeft;
@property (weak, nonatomic) IBOutlet UIImageView *threeVersusFinalWinnerRight;
@property (weak, nonatomic) IBOutlet UILabel *fourVersusFinalRightVote;

@property (weak, nonatomic) IBOutlet UIButton *fourVersusFinalRightButton;

@property (weak, nonatomic) IBOutlet UILabel *fourVersusFinalLeftVote;
@property (weak, nonatomic) IBOutlet UIImageView *fourVersusLeftWinnerImage;

@property (weak, nonatomic) IBOutlet UIView *fourVersusFirstSecondMainView;
@property (weak, nonatomic) IBOutlet UIImageView *fourVersusRightWinnerImage;

@property (weak, nonatomic) IBOutlet UIView *fourVersusFirstSecondNotDoneView;
@property (weak, nonatomic) IBOutlet UIImageView *fourVersusFirstSecondLeftWinnerImage;
@property (weak, nonatomic) IBOutlet UIImageView *fourVersusFirstSecondRightWinnerImage;

@property (weak, nonatomic) IBOutlet UIView *fourVersusFirstSecondButtonView;

@property (weak, nonatomic) IBOutlet UIButton *fourVersusFirstSecondLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *fourVersusFirstSecondRightButton;
@property (weak, nonatomic) IBOutlet UIButton *fourVersusFirstSecondFinalRightButton;
@property (weak, nonatomic) IBOutlet UIButton *fourVersusFirstSecondFinalLeftButton;

@property (weak, nonatomic) IBOutlet UIView *fourVersusButtonView;
@property (weak, nonatomic) IBOutlet UIButton *fourVersusFinalLeftButton;

@property (weak, nonatomic) IBOutlet UIButton *fourVersusLeftButton;
@property (weak, nonatomic) IBOutlet UIButton *fourVersusRightButton;



@property (weak, nonatomic) IBOutlet UILabel *fourVersusFirstSecondLeftVote;
@property (weak, nonatomic) IBOutlet UILabel *fourVersusFirstSecondRightVote;
@property (weak, nonatomic) IBOutlet UIView *fourVersusNotDoneView;

@property (weak, nonatomic) IBOutlet UIImageView *fourVersusZeroComment;


@property (weak, nonatomic) IBOutlet UIView *fourVersusMainView;
@property (weak, nonatomic) IBOutlet UIImageView *threeVersusZeroComment;



@end
