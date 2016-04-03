//
//  MNCChatMessageCell.h
//  sinch_demo
//
//  Created by Chong Shao on 3/29/16.
//  Copyright © 2016 Chong Shao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNCChatMessageCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *chatMateMessageLabel;

@property (strong, nonatomic) IBOutlet UILabel *myMessageLabel;

@end
