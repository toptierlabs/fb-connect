//
//  fb_connectViewController.h
//  fb-connect
//
//  Created by TopTier on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "fb_connectAppDelegate.h"

@interface fb_connectViewController : UIViewController <FBRequestDelegate, FBSessionDelegate, UITableViewDataSource, UITableViewDelegate> {
    //Facebook delegate
    fb_connectAppDelegate *appDelegate;
    
    //Table view Outlet
    IBOutlet UITableView *messageTableView;
    
    //Array to be used as table view's datasource
    NSMutableArray *wall;
    
}

@property(retain, nonatomic) NSMutableArray *wall;
@property(retain, nonatomic) UITableView *messageTableView;
@property (nonatomic,retain) NSDictionary *dicBundle;
@end
