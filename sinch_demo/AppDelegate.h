//
//  AppDelegate.h
//  sinch_demo
//
//  Created by Chong Shao on 3/27/16.
//  Copyright © 2016 Chong Shao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Sinch/Sinch.h>
#import "Config.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, SINClientDelegate, SINMessageClientDelegate>

// TODO: we don't do parse right now 
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) id<SINClient> sinchClient;
@property (strong, nonatomic) id<SINMessageClient> sinchMessageClient;

- (void)initSinchClient:(NSString*)userId;
- (void)sendTextMessage:(NSString *)messageText toRecipient:(NSString *)recipientID;

@end

