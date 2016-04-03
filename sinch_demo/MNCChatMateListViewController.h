//
//  MNCChatMateListViewController.h
//  sinch_demo
//
//  Created by Chong Shao on 3/27/16.
//  Copyright © 2016 Chong Shao. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "MNCDialogViewController.h"
#import <Sinch/Sinch.h>
#import "Config.h"

@interface MNCChatMateListViewController : UITableViewController <UITableViewDataSource>

@property (strong, nonatomic) MNCDialogViewController *activeDialogViewController;
@property (strong, nonatomic) NSString *myUserId; 
@property (strong, nonatomic) NSMutableArray *chatMatesArray;

@end
