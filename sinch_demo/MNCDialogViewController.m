//
//  MNCDialogViewController.m
//  sinch_demo
//
//  Created by Chong Shao on 3/27/16.
//  Copyright © 2016 Chong Shao. All rights reserved.
//

#import "MNCDialogViewController.h"
#import "AppDelegate.h"

@interface MNCDialogViewController ()


//@property (strong, nonatomic) MNCDialogViewController *activeDialogViewController;  /* add this line */
//@property (strong, nonatomic) UITextField *activeTextField;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextField *messageEditField;
@property (strong, nonatomic) IBOutlet UITableView *historicalMessagesTableView;


@end


@implementation MNCDialogViewController

// DONE
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.chatMateId;
    self.messageArray = [[NSMutableArray alloc] init];
    self.historicalMessagesTableView.rowHeight = UITableViewAutomaticDimension;     /* add this line */

    [self retrieveMessagesFromParseWithChatMateID:self.chatMateId];
    
    UITapGestureRecognizer *tapTableGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView)];
    [self.historicalMessagesTableView addGestureRecognizer:tapTableGR];
    [self registerForKeyboardNotifications];
}


// DONE
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageDelivered:) name:SINCH_MESSAGE_RECIEVED object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageDelivered:) name:SINCH_MESSAGE_SENT object:nil];
}


// DONE
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// DONE
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


// DONE
// Setting up keyboard notifications.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


// DONE
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(-kbSize.height, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.activeTextField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:self.activeTextField.frame animated:NO];
    }
}


//DONE
// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


#pragma mark UITextFieldDelegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeTextField = nil;
}


- (void)messageDelivered:(NSNotification *)notification
{
    MNCChatMessage *chatMessage = [[notification userInfo] objectForKey:@"message"];
    [self.messageArray addObject:chatMessage];
    [self.historicalMessagesTableView reloadData];
    [self scrollTableToBottom];
}


-(void)sendMessage:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate sendTextMessage:self.messageEditField.text toRecipient:self.chatMateId];
}


#pragma mark User interface behavioral methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.messageArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MNCChatMessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:@"MessageListPrototypeCell" forIndexPath:indexPath];
    [self configureCell:messageCell forIndexPath:indexPath];
    
    return messageCell;
}


#pragma mark Method to configure the appearance of a message list prototype cell

- (void)configureCell:(MNCChatMessageCell *)messageCell forIndexPath:(NSIndexPath *)indexPath {
    
    MNCChatMessage *chatMessage = self.messageArray[indexPath.row];
    
    if ([[chatMessage senderId] isEqualToString:self.myUserId]) {
        // If the message was sent by myself
        messageCell.chatMateMessageLabel.text = @"";
        messageCell.myMessageLabel.text = chatMessage.text;
    } else {
        // If the message was sent by the chat mate
        messageCell.myMessageLabel.text = @"";
        messageCell.chatMateMessageLabel.text = chatMessage.text;
    }
}


- (void)scrollTableToBottom {
    int rowNumber = [self.historicalMessagesTableView numberOfRowsInSection:0];
    if (rowNumber > 0) [self.historicalMessagesTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rowNumber-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


// TODO: does not handle Parse
- (void)retrieveMessagesFromParseWithChatMateID:(NSString *)chatMateId {
    NSLog(@"self user id and chat mate id: %@ %@", self.myUserId, self.chatMateId );
    
    
    NSArray *userNames = @[self.myUserId, chatMateId];
    __weak typeof(self) weakSelf = self;
    
    
    
// //   PFQuery *query = [PFQuery queryWithClassName:@"SinchMessage"];
// //   [query whereKey:@"senderId" containedIn:userNames];
//    [query whereKey:@"recipientId" containedIn:userNames];
//    [query orderByAscending:@"timestamp"];
//    
//    __weak typeof(self) weakSelf = self;
//    [query findObjectsInBackgroundWithBlock:^(NSArray *chatMessageArray, NSError *error) {
//        if (!error) {
//            // Store all retrieve messages into historicalMessagesArray
//            for (int i = 0; i < [chatMessageArray count]; i++) {
//                MNCChatMessage *chatMessage = [[MNCChatMessage alloc] init];
//                
//                [chatMessage setMessageId:chatMessageArray[i][@"messageId"]];
//                [chatMessage setSenderId:chatMessageArray[i][@"senderId"]];
//                [chatMessage setRecipientIds:[NSArray arrayWithObject:chatMessageArray[i][@"recipientId"]]];
//                [chatMessage setText:chatMessageArray[i][@"text"]];
//                [chatMessage setTimestamp:chatMessageArray[i][@"timestamp"]];
//                
//                [weakSelf.messageArray addObject:chatMessage];
//            }
//            [weakSelf.historicalMessagesTableView reloadData];  // Refresh the table view
//            [weakSelf scrollTableToBottom];  // Scroll to the bottom of the table view
//        } else {
//            NSLog(@"Error: %@", error.description);
//        }
//    }];
}


@end
