//
//  fb_connectAppDelegate.h
//  fb-connect
//
//  Created by TopTier on 10/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class fb_connectViewController;

@interface fb_connectAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet fb_connectViewController *viewController;

@end
