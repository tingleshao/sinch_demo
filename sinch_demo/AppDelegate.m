//
//  AppDelegate.m
//  sinch_demo
//
//  Created by Chong Shao on 3/27/16.
//  Copyright © 2016 Chong Shao. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// TDOO: we don't do parse right now
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


// DONE five methods below
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark Functional methods
// TODO: we don't do parse right now
//- (void)saveMessagesOnParse:(id<SINMessage>)message {
//    PFQuery *query = [PFQuery queryWithClassName:@"SinchMessage"];
//    [query whereKey:@"messageId" equalTo:[message messageId]];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *messageArray, NSError *error) {
//        if (!error) {
//            // If the SinchMessage is not already saved on Parse (an empty array is returned), save it.
//            if ([messageArray count] <= 0) {
//                PFObject *messageObject = [PFObject objectWithClassName:@"SinchMessage"];
//                
//                messageObject[@"messageId"] = [message messageId];
//                messageObject[@"senderId"] = [message senderId];
//                messageObject[@"recipientId"] = [message recipientIds][0];
//                messageObject[@"text"] = [message text];
//                messageObject[@"timestamp"] = [message timestamp];
//                
//                [messageObject saveInBackground];
//            }
//        } else {
//            NSLog(@"Error: %@", error.description);
//        }
//    }];
//}


// Send a text message
// DONE
- (void)sendTextMessage:(NSString *)messageText toRecipient:(NSString *)recipientId {
    SINOutgoingMessage *outgoingMessage = [SINOutgoingMessage messageWithRecipient:recipientId text:messageText];
    [self.sinchClient.messageClient sendMessage:outgoingMessage];
}


// Initialize the Sinch client
// DONE
- (void)initSinchClient:(NSString*)userId {
    self.sinchClient = [Sinch clientWithApplicationKey:SINCH_APPLICATION_KEY
                                     applicationSecret:SINCH_APPLICATION_SECRET
                                       environmentHost:SINCH_ENVIRONMENT_HOST
                                                userId:userId];
    NSLog(@"Sinch version: %@, userId: %@", [Sinch version], [self.sinchClient userId]);
    
    [self.sinchClient setSupportMessaging:YES];
    [self.sinchClient start];
    [self.sinchClient startListeningOnActiveConnection];
    self.sinchClient.delegate = self;   /* add this line */
}


#pragma mark SINClientDelegate methods
// DONE
- (void)clientDidFail:(id<SINClient>)client error:(NSError *)error {
    NSLog(@"Start SINClient failed. Description: %@. Reason: %@.", error.localizedDescription, error.localizedFailureReason);
}


// DONE
- (void)clientDidStart:(id<SINClient>)client {
    NSLog(@"Start SINClient successful!");
    self.sinchMessageClient = [self.sinchClient messageClient];
    self.sinchMessageClient.delegate =  self;
}


#pragma mark SINMessageClientDelegate methods
// Receiving an incoming message.
// TODO: does not use Parse
- (void)messageClient:(id<SINMessageClient>)messageClient didReceiveIncomingMessage:(id<SINMessage>)message {
  //  [self saveMessagesOnParse:message];
    [[NSNotificationCenter defaultCenter] postNotificationName:SINCH_MESSAGE_RECIEVED object:self userInfo:@{@"message" : message}];
}


// Finish sending a message
// TODO: does not use Parse
- (void)messageSent:(id<SINMessage>)message recipientId:(NSString *)recipientId {
  //  [self saveMessagesOnParse:message];
    [[NSNotificationCenter defaultCenter] postNotificationName:SINCH_MESSAGE_SENT object:self userInfo:@{@"message" : message}];
}


// Failed to send a message
// DONE
- (void)messageFailed:(id<SINMessage>)message info:(id<SINMessageFailureInfo>)messageFailureInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:SINCH_MESSAGE_FAILED object:self userInfo:@{@"message" : message}];
    NSLog(@"MessageBoard: message to %@ failed. Description: %@. Reason: %@.", messageFailureInfo.recipientId, messageFailureInfo.error.localizedDescription, messageFailureInfo.error.localizedFailureReason);
}


// DONE
-(void)messageDelivered:(id<SINMessageDeliveryInfo>)info
{
    [[NSNotificationCenter defaultCenter] postNotificationName:SINCH_MESSAGE_FAILED object:info];
}


@end
