//
//  searchTabViewController.h
//  HeyVote
//
//  Created by Ikhram Khan on 5/14/16.
//  Copyright © 2016 AppCandles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchTabViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    
   
        
        NSArray* searchResult;
    
}
 @property (nonatomic, strong) NSMutableArray *tableData;
- (IBAction)homeButton:(id)sender;
- (IBAction)contactButton:(id)sender;
- (IBAction)centerButton:(id)sender;
- (IBAction)searchButton:(id)sender;
- (IBAction)profileButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchTabBar;

@end
