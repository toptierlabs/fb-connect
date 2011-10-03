//
//  fb_connectAppDelegate.h
//  fb-connect
//
//  Created by TopTier on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"

@class fb_connectViewController;

@interface fb_connectAppDelegate : NSObject <UIApplicationDelegate> {
    NSString *fbURL;
    Facebook *facebook;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet fb_connectViewController *viewController;

//Facebook object (facebook ios api)  
// github.com/facebook/facebook-ios-sdk
@property (nonatomic, retain) Facebook *facebook;

//Facebook url, initialized with fb[AppID] without []
//AppId must be also initialized in Supporting Files/fb-connect-list.plist,  URLTypes,Item 0, Url Schemes, Item 0.
@property (nonatomic, retain) NSString *fbURL;



@end
