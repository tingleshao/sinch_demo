//
//  MNCDialogViewController.h
//  sinch_demo
//
//  Created by Chong Shao on 3/27/16.
//  Copyright © 2016 Chong Shao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Sinch/Sinch.h>
#import "AppDelegate.h"

#import "MNCChatMessage.h"
#import "MNCChatMessageCell.h"  /* add this line */

// DONE
@interface MNCDialogViewController : UIViewController <UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) NSString *chatMateId;     /* add this line */
@property (strong, nonatomic) NSMutableArray* messageArray;
@property (strong, nonatomic) NSString *myUserId;   /* add this line */
@property (strong, nonatomic) UITextField *activeTextField;

- (IBAction)sendMessage:(id)sender;


@end
